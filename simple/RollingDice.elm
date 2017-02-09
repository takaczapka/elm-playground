module RollingDice exposing(..)

import Html exposing(..)
import Html.Events exposing(..)

import Random

type alias Model = Int

init : ( Model, Cmd Msg )
init = ( 0, Cmd.none )

type Msg = Roll
  | OnResult Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
  OnResult i -> ( i, Cmd.none )
  Roll -> ( model, Random.generate OnResult (Random.int 1 6) )

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Roll ] [ text "Roll" ]
        , text (toString model)
        ]

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
