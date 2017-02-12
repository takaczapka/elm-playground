module Main exposing (..)

import Html exposing (Html, div, text, program)
import Messages exposing (..)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Players.Commands

init : ( Model, Cmd Msg )
init =
     ( initialModel, Cmd.map PlayersMsg Players.Commands.fetchAll )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
