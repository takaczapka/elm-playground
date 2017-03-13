module Players.Messages exposing(..)

import Http
import Players.Models exposing(Player, PlayerId)

type Msg
  = OnFetchAll (Result Http.Error (List Player))
  | ShowPlayers
  | ShowPlayer PlayerId
  | ChangeLevel PlayerId Int
  | ChangeName PlayerId String
  | UpdatePlayer PlayerId
  | OnPlayerUpdate (Result Http.Error Player)
