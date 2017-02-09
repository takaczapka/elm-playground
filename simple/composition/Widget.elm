module Composition.Widget exposing (..)

import Html exposing(..)
import Html.Events exposing(..)

type alias Model =
  { count : Int }

initialModel : Model
initialModel = { count = 32 }

type Msg = Increase

view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (toString model.count) ]
        , button [ onClick Increase ] [ text "Click" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | count = model.count + 1 }, Cmd.none )
