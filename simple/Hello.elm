module Hello exposing (..)

import Html exposing (text)

main = text ("Hello Cruel World: " ++ toString (2 |> multiply 4 |> add 5 ) ++ " " ++
  toString(reverse [1, 2, 3]))


add : Int -> Int -> Int
add x y = x + y

multiply : Int -> Int -> Int
multiply x y = x * y

switch : (a, b) -> (b, a)
switch (a, b) = (b, a)

reverse : List a -> List a
reverse l = case l of
  h :: t -> (reverse t) ++ [h]
  []     -> []
