module Players.Update exposing(..)

import Navigation
import Players.Messages exposing (..)
import Players.Models exposing (Player)
import Players.Commands

update : Msg -> List Player -> ( List Player, Cmd Msg )
update msg players = case msg of
  OnFetchAll (Ok newPlayers) -> ( newPlayers, Cmd.none )
  OnFetchAll (Err error) -> (players, Cmd.none )
  ShowPlayers -> ( players, Navigation.newUrl "#players" ) -- TODO could this be done nicer - with no hardcoded string?
  ShowPlayer id -> ( players, Navigation.newUrl ("#players/" ++ id) )
  ChangeLevel id howMuch ->
    let
      maybePlayer = players |> List.filter(\player -> player.id == id) |> List.head
    in
      case maybePlayer of
        Just player ->
          let
            updatedPlayer = { player | level = player.level + howMuch }
          in
           ( players, Players.Commands.updatePlayer updatedPlayer )
        Nothing -> ( players, Cmd.none )
  OnPlayerUpdate (Ok player) -> ( (updatePlayerInPlayers player players), Cmd.none )
  OnPlayerUpdate (Err error) -> ( players, Cmd.none ) -- TODO how to do error handling nice?


updatePlayerInPlayers : Player -> List Player -> List Player
updatePlayerInPlayers updatedPlayer players =
  let
    select existingPlayer = if existingPlayer.id == updatedPlayer.id then updatedPlayer else existingPlayer -- smart!
  in
    List.map select players
