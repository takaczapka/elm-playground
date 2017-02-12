module Models exposing(..)

import Players.Models exposing (Player)

type alias Model =
  {
    players : List Player
  }

initialModel : Model
initialModel =
  {
    players = [ { id = "0", name = "Sam", level = 1 } ] -- or [ Player "0", "Sam", 1 ]
  }
