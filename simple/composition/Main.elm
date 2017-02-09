module Composition.Main exposing (..)

import Html exposing (..)
import Composition.Widget


type alias AppModel = { widgetModel : Composition.Widget.Model }

initialModel : AppModel
initialModel = { widgetModel = Composition.Widget.initialModel }

init : ( AppModel, Cmd Msg )
init = ( initialModel, Cmd.none )

type Msg =
   WidgetMsg Composition.Widget.Msg

view : AppModel -> Html Msg
view model =
    Html.div []
        [ Html.map WidgetMsg (Composition.Widget.view model.widgetModel)
        ]

update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
  case msg of
    WidgetMsg widgetMsg ->
      let
        ( widgetModel, widgetCmd ) = Composition.Widget.update widgetMsg model.widgetModel
      in
        ( { model | widgetModel = widgetModel }, Cmd.map WidgetMsg widgetCmd )

subscriptions : AppModel -> Sub Msg
subscriptions model = Sub.none

main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
