module Update exposing(..)

import Messages exposing(..)
import Models exposing(..)
import Players.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
          let
           ( updatedPlayers, cmd ) = Players.Update.update subMsg model.players
          in
           ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
