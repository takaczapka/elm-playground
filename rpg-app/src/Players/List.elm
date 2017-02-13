module Players.List exposing(..)

import Http
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Players.Messages exposing (..)
import Players.Models exposing (Player)

view : Result Http.Error (List Player) -> Html Msg
view playersResult =
  case playersResult of
    Ok players ->
      div []
            [ nav players
            , list players
            ]
    Err err ->
      div [] [ text ("Error occurred: " ++ (toString err)) ]

nav : List Player -> Html Msg
nav players =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]

list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]

playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player ]
        ]

editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
