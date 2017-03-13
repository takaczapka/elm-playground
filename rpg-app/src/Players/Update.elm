module Players.Update exposing(..)

import Http
import Navigation
import Players.Messages exposing (..)
import Players.Models exposing (Player, PlayerId)
import Players.Commands

update : Msg -> Result Http.Error (List Player) -> ( Result Http.Error (List Player), Cmd Msg )
update msg playersResult = case msg of
  OnFetchAll (Ok newPlayers) -> ( Ok newPlayers, Cmd.none )
  OnFetchAll (Err error) -> ( Err error, Cmd.none )
  ShowPlayers -> ( playersResult, Navigation.newUrl "#players" )
  -- TODO 1) could this be done nicer - with no hardcoded string?
  -- TODO 2) I wanna a fresh set of players
  ShowPlayer id -> ( playersResult, Navigation.newUrl ("#players/" ++ id) )
  ChangeLevel id howMuch -> case playersResult of
      Ok players ->
        updatePlayer players id (\player -> { player | level = player.level + howMuch } )
      Err error -> ( Err error, Cmd.none )
  ChangeName id newName -> case playersResult of
      Ok players ->
        case (findPlayer players id) of
          Just player ->
            let
              updatedPlayer = { player | name = newName }
            in
              ( Ok (updatePlayerInPlayers updatedPlayer players), Cmd.none )
          Nothing -> ( Ok players, Cmd.none )
      Err error -> ( Err error, Cmd.none )
  UpdatePlayer id -> case playersResult of
      Ok players ->
        case (findPlayer players id) of
          Just player -> ( Ok players, Players.Commands.updatePlayer player )
          Nothing -> ( Ok players, Cmd.none )
      Err error -> ( Err error, Cmd.none )
  OnPlayerUpdate (Ok player) -> ( Result.map (\players -> (updatePlayerInPlayers player players)) playersResult, Cmd.none )
  OnPlayerUpdate (Err error) -> ( Err error, Cmd.none )

updatePlayer: (List Player) -> PlayerId -> (Player -> Player) -> ( Result Http.Error (List Player), Cmd Msg )
updatePlayer players id update =
          let
            maybePlayer = players |> List.filter(\player -> player.id == id) |> List.head
          in
            case maybePlayer of
              Just player ->
                let
                  updatedPlayer = update player
                in
                 ( Ok players, Players.Commands.updatePlayer updatedPlayer )
              Nothing -> ( Ok players, Cmd.none )

findPlayer: (List Player) -> PlayerId -> Maybe Player
findPlayer players id =
  players |> List.filter(\player -> player.id == id) |> List.head

updatePlayerInPlayers : Player -> List Player -> List Player
updatePlayerInPlayers updatedPlayer players =
  let
    select existingPlayer = if existingPlayer.id == updatedPlayer.id then updatedPlayer else existingPlayer -- smart!
  in
    List.map select players
