module Update exposing(..)

import Messages exposing(..)
import Models exposing(..)
import Players.Update
import Players.Commands
import Routing exposing(parseLocation)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
          let
            ( updatedPlayers, cmd ) = Players.Update.update subMsg model.players
          in
            ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
        OnLocationChange location ->
          let
            newRoute = parseLocation location
          in
            ( { model | route = newRoute}, Cmd.map PlayersMsg Players.Commands.fetchAll )
