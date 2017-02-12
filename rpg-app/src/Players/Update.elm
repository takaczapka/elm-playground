module Players.Update exposing(..)

import Players.Messages exposing (..)
import Players.Models exposing (Player)

update : Msg -> List Player -> ( List Player, Cmd Msg )
update msg players = case msg of
  OnFetchAll (Ok newPlayers) -> ( newPlayers, Cmd.none )
  OnFetchAll (Err error) -> (players, Cmd.none )
