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
        -- Widget.view emits Widget.Msg so it is incompatible with this view which emits Main.Msg.
        -- We use Html.map to map emitted messages from Widget.view to the type we expect (Msg).
        -- Html.map tags messages coming from the sub view using the WidgetMsg tag.
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
