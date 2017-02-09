module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard

type alias Model =
  Int

init : ( Model, Cmd Msg )
init =
  ( 0, Cmd.none )

type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]
-- Sub.batch takes a list of subscriptions and returns one subscription which includes all of them

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
