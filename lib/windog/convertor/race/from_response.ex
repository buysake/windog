defmodule Windog.Convertor.Race.FromResponse do
  alias Windog.Convertor.Common.Utils

  alias Windog.Structs.{
    RaceContext,
    Race,
    Cup,
    OddsItem,
    OddsCategory,
    ResultItem,
    PlayerDetail,
    Player,
    ResultHistory,
    ResultHistoryRace,
    PlayerRecord,
    PlayerRecordLegType,
    PlayerRecordPercent,
    PlayerRecordEx,
    PlayerRecordExCount,
    PlayerRecordSB,
    Venue
  }

  @margin_overtime 99.9

  # body: response of /v1/keirin/cups/:cup_id/schedules/:day/races/:r?pfm=web
  def run(body) do
    %{cup: cup, race: race} = parse_race_info(body["race"], body["schedule"], body["cups"])
    players = parse_players(body["entries"], body["players"], body["records"])
    line = parse_line(body["linePrediction"])
    odds = parse_odds(body)
    results = parse_results(body["results"], body["entries"])
    venue = parse_venue(body["schedule"], body["cups"], body["venues"])

    has_absent_player = players |> Enum.any?(fn p -> p.absent end)
    has_accident = results |> Enum.any?(fn r -> r.accident != nil end)
    is_defect_line = line == nil
    is_finish = results != []

    RaceContext.validate(%{
      players: players,
      line: line,
      results: results,
      odds: odds,
      race: race,
      venue: venue,
      cup: cup,
      is_defect_line: is_defect_line,
      has_accident: has_accident,
      has_absent_player: has_absent_player,
      is_finish: is_finish
    })
  end

  defp parse_venue(schedule_r, cups_r, venues_r) do
    cup = Enum.find(cups_r, fn %{"id" => c_id} -> c_id == schedule_r["cupId"] end)
    venue = Enum.find(venues_r, fn %{"id" => v_id} -> v_id == cup["venueId"] end)

    Venue.validate(%{
      name: venue["name"],
      slug: venue["slug"],
      id: venue["id"],
      region_id: venue["regionId"],
      has_food: venue["hasFood"],
      distance: venue["trackDistance"],
      straight_distance: venue["trackStraightDistance"],
      home_width: venue["homeWidth"],
      back_width: venue["backWidth"],
      best_agari: venue["bestRecord"]["second"]
    })
  end

  defp parse_race_info(race_r, schedule_r, cups_r) do
    cup = Enum.find(cups_r, fn %{"id" => c_id} -> c_id == schedule_r["cupId"] end)

    %{
      race:
        Race.validate(%{
          id: race_r["id"],
          r: race_r["number"],
          day_index: schedule_r["index"],
          day: schedule_r["day"],
          start_at: race_r["startAt"],
          close_at: race_r["closeAt"],
          type: race_r["raceType"],
          class: race_r["class"],
          distance: race_r["distance"],
          lap: race_r["lap"],
          date: Utils.parse_response_date(schedule_r["date"]),
          cup_id: schedule_r["cupId"]
        }),
      cup:
        Cup.validate(%{
          grade: cup["grade"],
          venue_id: cup["venueId"],
          name: cup["name"],
          id: schedule_r["cupId"],
          start_date: Utils.parse_response_date(cup["startDate"])
        })
    }
  end

  defp parse_odds([%{"key" => _, "odds" => _} | _] = odds) do
    odds
    |> Enum.map(fn odd ->
      OddsItem.validate(%{
        key: Enum.map(odd["key"], fn k -> "#{k}" end),
        odds: odd["odds"]
      })
    end)
  end

  defp parse_odds(%{"quinella" => _} = odds_r) do
    OddsCategory.validate(%{
      nishafuku: parse_odds(odds_r["quinella"]),
      nishatan: parse_odds(odds_r["exacta"]),
      sanrenpuku: parse_odds(odds_r["trio"]),
      sanrentan: parse_odds(odds_r["trifecta"])
    })
  end

  defp parse_results(result_r, entries_r) do
    result_r
    |> Enum.reduce([], fn r, acc ->
      %{
        "playerId" => p_id,
        "hasAccident" => has_accident,
        "accident" => accident,
        "factor" => factor,
        "finalHalfRecord" => agari_time,
        "standing" => standing,
        "back" => back,
        "order" => order,
        "margin" => margin_str
      } = r

      hit =
        entries_r
        |> Enum.find(fn %{"playerId" => id} -> id == p_id end)

      # 同着のデータが積まれているか
      equal_order =
        acc
        |> Enum.find(&(&1.order == order))

      margin =
        cond do
          equal_order != nil ->
            equal_order.margin

          true ->
            margin_to_float(margin_str)
        end

      margin_by_top =
        cond do
          margin == @margin_overtime ->
            # 大差は合計着差を計算せずに@margin_overtime
            @margin_overtime

          # 1着 or 失格
          margin == nil and order in [0, 1] ->
            nil

          # 落車→再乗などのパターン
          margin == nil and agari_time == "0.0" ->
            nil

          true ->
            acc
            |> Enum.filter(&(&1.order != 1))
            |> Enum.filter(&(&1.order != order))
            |> Enum.uniq_by(& &1.order)
            |> Enum.map(& &1.margin)
            |> Enum.sum()
            |> Kernel.+(margin)
            |> Kernel.*(100)
            |> round()
            |> Kernel./(100)
        end

      acc ++
        [
          ResultItem.validate(%{
            number: "#{hit["number"]}",
            player_id: "#{p_id}",
            has_accident: has_accident,
            accident: with("" <- accident, do: nil),
            factor: factor,
            agari_time: if(agari_time == "0.0", do: nil, else: parse_float(agari_time)),
            standing: standing,
            back: back,
            order: with(0 <- order, do: nil),
            margin: margin,
            margin_by_top: margin_by_top
          })
        ]
    end)
  end

  defp margin_to_float(str) do
    float =
      case str do
        <<p::binary-size(1), "車身">> ->
          String.to_integer(p) / 1

        <<p::binary-size(1), "/", q::binary-size(1), "車身">> ->
          String.to_integer(p) / String.to_integer(q)

        <<p::binary-size(1), "車身", q::binary-size(1), "/", r::binary-size(1)>> ->
          String.to_integer(p) + String.to_integer(q) / String.to_integer(r)

        <<p::binary-size(1), "車輪">> ->
          String.to_integer(p) / 2.75

        <<p::binary-size(1), "/", q::binary-size(1), "車輪">> ->
          String.to_integer(p) / String.to_integer(q) / 2.75

        # 1/8車輪より小さい
        "タイヤ" ->
          1 / 16 / 2.75

        # タイヤの半分
        "微差" ->
          1 / 32 / 2.75

        "大差" ->
          99.9

        "" ->
          nil
      end

    if float == nil,
      do: nil,
      else: round(float * 100) / 100
  end

  defp parse_line(nil) do
    nil
  end

  defp parse_line(line_prediction_r) do
    line_prediction_r["lines"]
    |> Enum.map(fn line -> line["entries"] end)
    |> Enum.map(fn line ->
      line
      |> Enum.map(fn %{"numbers" => ns} -> ns end)
      |> Enum.map(fn ns ->
        case ns do
          [n] ->
            "#{n}"

          [_ | _] ->
            ns |> Enum.map(fn n -> "#{n}" end)
        end
      end)
    end)
  end

  defp parse_players(entries_r, players_r, record_r) do
    entries_r
    |> Enum.map(fn %{"playerId" => p_id, "number" => number, "absent" => absent} ->
      hit =
        players_r
        |> Enum.find(fn %{"id" => id} -> id == p_id end)

      %{
        number: "#{number}",
        player_id: p_id,
        absent: absent,
        player:
          PlayerDetail.validate(%{
            name: hit["name"],
            term: hit["term"],
            class: hit["class"],
            group: hit["group"],
            age: hit["age"],
            region_id: hit["regionId"]
          })
      }
    end)
    |> Enum.map(fn %{player_id: id} = data ->
      hit =
        record_r
        |> Enum.find(fn %{"playerId" => p_id} -> p_id == id end)

      adjust_latest_result_item = fn r ->
        ResultHistoryRace.validate(%{
          day: r["day"],
          has_accident: r["hasAccident"],
          accident: with("" <- r["accident"], do: nil),
          back: r["back"],
          standing: r["standing"],
          order: with(0 <- r["order"], do: nil),
          agari_time: parse_float(r["finalHalfRecord"]),
          race_id: r["raceId"],
          display_type: r["displayType"],
          factor: r["factor"],
          margin: r["margin"],
          race_type_short: r["raceType3"]
        })
      end

      current_cup = Enum.map(hit["currentCupResults"], fn r -> adjust_latest_result_item.(r) end)

      previous_cup =
        Enum.map(hit["previousCupResults"], fn r -> adjust_latest_result_item.(r) end)

      latest_cups =
        hit["latestCupResults"]
        |> Enum.take(10)
        |> Enum.map(fn lcr ->
          ResultHistory.validate(%{
            cup_id: lcr["cupId"],
            race_point: parse_float(lcr["racePoint"]),
            races: lcr["raceResults"] |> Enum.map(fn lcrr -> adjust_latest_result_item.(lcrr) end)
          })
        end)

      record =
        PlayerRecord.validate(%{
          race_point: hit["racePoint"],
          comment: hit["comment"],
          countable: hit["first"] + hit["second"] + hit["third"] + hit["others"],
          style: hit["style"],
          sb:
            PlayerRecordSB.validate(%{
              standing: hit["standing"],
              back: hit["back"]
            }),
          percent:
            PlayerRecordPercent.validate(%{
              in_1: hit["firstRate"],
              in_2: hit["secondRate"],
              in_3: hit["thirdRate"]
            }),
          leg_type:
            PlayerRecordLegType.validate(%{
              nige: hit["frontRunner"],
              sashi: hit["stalker"],
              makuri: hit["deepCloser"],
              marker: hit["marker"]
            }),
          ex:
            PlayerRecordEx.validate(%{
              is_line_1:
                PlayerRecordExCount.validate(%{
                  first: hit["linePositionFirst"]["first"],
                  second: hit["linePositionFirst"]["second"],
                  third: hit["linePositionFirst"]["third"],
                  total: hit["linePositionFirst"]["total"]
                }),
              is_line_2:
                PlayerRecordExCount.validate(%{
                  first: hit["linePositionSecond"]["first"],
                  second: hit["linePositionSecond"]["second"],
                  third: hit["linePositionSecond"]["third"],
                  total: hit["linePositionSecond"]["total"]
                }),
              is_line_tail:
                PlayerRecordExCount.validate(%{
                  first: hit["linePositionThird"]["first"],
                  second: hit["linePositionThird"]["second"],
                  third: hit["linePositionThird"]["third"],
                  total: hit["linePositionThird"]["total"]
                }),
              is_single:
                PlayerRecordExCount.validate(%{
                  first: hit["lineSingleHorseman"]["first"],
                  second: hit["lineSingleHorseman"]["second"],
                  third: hit["lineSingleHorseman"]["third"],
                  total: hit["lineSingleHorseman"]["total"]
                })
            })
        })

      Player.validate(%{
        number: data[:number],
        absent: data[:absent],
        player_id: data[:player_id],
        player: data[:player],
        record: record,
        current_cup: current_cup,
        previous_cup: previous_cup,
        latest_cups: latest_cups
      })
    end)
  end

  defp parse_float(str) do
    case Float.parse(str) do
      {f, _} -> f
      _ -> nil
    end
  end
end
