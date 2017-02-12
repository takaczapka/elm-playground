module Players.Models exposing(..)

type alias PlayerId = String

type alias PerkId = String

type alias Player =
  {
    id : PlayerId,
    name : String,
    level : Int
  }

new : Player
new = Player "0" "" 1
--> { id = "1", name = "aa", level = 2 } == Player "1" "aa" 2
--True : Bool

-- addPerkToPlayer : PerkId -> PlayerId -> Player
-- addPerkToPlayer perkId playerId =
