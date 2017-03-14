module CatchTheSheep exposing(..)

import Html exposing(..)
import Html.Events exposing(..)

import Random

type alias Sheep = { posX : Int, posY : Int }

type alias Model = { sheep : List Sheep, targetAmount : Int }

init : ( Model, Cmd Msg )
init = ( { sheep = [], targetAmount = 10 }, generateSheep )

type Msg = OnGenerated (Int, Int)

generateSheep : Cmd Msg
generateSheep = Random.generate OnGenerated (Random.pair (Random.int 1 500) (Random.int 1 500))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
  OnGenerated (posX, posY) ->
    let
      updatedModel = { model | sheep = { posX = posX, posY = posY } :: model.sheep }
    in
      if ((List.length updatedModel.sheep) >= model.targetAmount) then (updatedModel, Cmd.none)
        else (updatedModel, generateSheep)

view : Model -> Html Msg
view model =
    div []
      (List.map
        (\sheep -> div [] [ text ("x: " ++ (toString sheep.posX) ++ ", y: " ++ (toString sheep.posY)) ] )
        model.sheep)

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
