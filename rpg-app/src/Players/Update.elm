module Players.Update exposing(..)

import Http
import Navigation
import Players.Messages exposing (..)
import Players.Models exposing (Player)
import Players.Commands

update : Msg -> Result Http.Error (List Player) -> ( Result Http.Error (List Player), Cmd Msg )
update msg playersResult = case msg of
  OnFetchAll (Ok newPlayers) -> ( Ok newPlayers, Cmd.none )
  OnFetchAll (Err error) -> ( Err error, Cmd.none )
  ShowPlayers -> ( playersResult, Navigation.newUrl "#players" ) -- TODO could this be done nicer - with no hardcoded string?
  ShowPlayer id -> ( playersResult, Navigation.newUrl ("#players/" ++ id) )
  ChangeLevel id howMuch ->
    case playersResult of
      Ok players ->
        let
          maybePlayer = players |> List.filter(\player -> player.id == id) |> List.head
        in
          case maybePlayer of
            Just player ->
              let
                updatedPlayer = { player | level = player.level + howMuch }
              in
               ( Ok players, Players.Commands.updatePlayer updatedPlayer )
            Nothing -> ( Ok players, Cmd.none )
      Err error -> ( Err error, Cmd.none )
  OnPlayerUpdate (Ok player) -> ( Result.map (\players -> (updatePlayerInPlayers player players)) playersResult, Cmd.none )
  OnPlayerUpdate (Err error) -> ( Err error, Cmd.none )


updatePlayerInPlayers : Player -> List Player -> List Player
updatePlayerInPlayers updatedPlayer players =
  let
    select existingPlayer = if existingPlayer.id == updatedPlayer.id then updatedPlayer else existingPlayer -- smart!
  in
    List.map select players
