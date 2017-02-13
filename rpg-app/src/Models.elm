module Models exposing(..)

import Http
import Players.Models exposing (Player)
import Routing

type alias Model =
  {
    players : Result Http.Error (List Player)
  , route: Routing.Route
  }

initialModel : Routing.Route -> Model
initialModel route =
  {
    players = Ok []
  , route = route
  }
