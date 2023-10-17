# Windog

🚲 API client for winticket.jp  

## Installation

```elixir
def deps do
  [
    {:windog, "~> 0.7.3"}
  ]
end
```

## Config
```elixir
config :windog,
    token: "....",
    short_password: "0000"
```

## Example
```elixir
# 📅 Get race data ( e.g. /keirin/beppu/racecard/2023092845/3/11 )
{:ok, race_context} = Windog.Api.Race.get_race("2023092845", "3", "11")

# 🎫 Assemble ticket ( e.g. 二車単 7-2(¥200) & 7-8(¥100) )
base_ticket = Windog.RequestHelpers.TicketMaker.V2.make_nishatan([[7], [2, 8]], race_context)
ticket = Windog.RequestHelpers.TicketMaker.V2.set_unit(base_ticket, [7, 2], 2)

# 🤤 Buy
Windog.Api.Ticket.buy_v2(race_context, [ticket])
```
