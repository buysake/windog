# Windog

🚲 API client for winticket.jp  

## Installation

```elixir
def deps do
  [
    {:windog, "~> 0.5.0"}
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
# 📅 Get race data ( e.g. /keirin/beppu/racecard/2023081586/3/1 )
{:ok, race_context} = Windog.Api.Race.get_race("2023081586", "3", "1")

# 🎫 Assemble ticket ( e.g. 二車単 1-3 )
ticket = Windog.RequestHelpers.TicketMaker.V1.make_nishatan([1,3], 100)

# 🤤 Buy
Windog.Api.Ticket.buy(race_context, [ticket])
```
