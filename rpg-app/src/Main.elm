module Main exposing (..)

import Html exposing (Html, div, text, program)
import Navigation exposing (Location)
import Routing exposing(parseLocation)
import Messages exposing (..)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Players.Commands


init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute = parseLocation location
  in
    ( initialModel currentRoute, Cmd.map PlayersMsg Players.Commands.fetchAll )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
