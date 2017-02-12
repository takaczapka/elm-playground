module Players.Commands exposing(..)

import Http exposing (header, Request, Body)
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode exposing (..)
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)

fetchAll : Cmd Msg
fetchAll =
  Http.get fetchAllUrl collectionDecoder |> Http.send OnFetchAll

fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"

updatePlayer : Player -> Cmd Msg
updatePlayer player =
  put (updatePlayerUrl player.id) (Http.jsonBody (playerJson player)) |> Http.send OnPlayerUpdate

put : String -> Body -> Request Player
put url body =
  Http.request
    { method = "PUT"
    , headers = []
    , url = url
    , body = body
    , expect = Http.expectJson memberDecoder
    , timeout = Nothing
    , withCredentials = False
    }

playerJson : Player -> Value
playerJson player =
  Encode.object [
    ( "id", Encode.string player.id ),
    ( "name", Encode.string player.name ),
    ( "level", Encode.int player.level )
  ]

updatePlayerUrl : PlayerId -> String
updatePlayerUrl playerId =
  "http://localhost:4000/players/" ++ playerId

collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
  Decode.list memberDecoder

memberDecoder : Decode.Decoder Player
memberDecoder =
  Decode.map3 Player
    (field "id" Decode.string)
    (field "name" Decode.string)
    (field "level" Decode.int)
