module Inc exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias Model =
    { result: Int, value: Int }

init : ( Model, Cmd Msg )
init =
    ( { result = 54, value = 1}, Cmd.none )


-- MESSAGES
type Msg
    = NoOp
    | SetValue String
    | Add
    | Sub

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ text (toString model.result),
          input [ placeholder "value", value (toString model.value), onInput SetValue] [],
          button [ onClick (Sub) ] [ text "-" ],
          button [ onClick (Add) ] [ text "+" ]
        ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp -> ( model , Cmd.none )
        Add  -> ( { model | result = model.result + model.value } , Cmd.none )
        Sub  -> ( { model | result = model.result - model.value }, Cmd.none )
        SetValue value ->
          let
            newInt = Result.withDefault 0 (String.toInt value)
          in
            ( { model | value = newInt }, Cmd.none )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
