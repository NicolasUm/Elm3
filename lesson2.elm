module Lessons.Lesson2 exposing (..)

import Html exposing (Html, Attribute, text, div, input, br)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)

---tout mettre dans Lessons
--- vérifier tous les TU
----ne pas prévir msg erreur mais justea fficher 0 si erreur
-----tests html
----compliquer fonction
-----Elixi
----Elm testable
totalPackPrice : Int -> Int -> Result String Int
totalPackPrice quantity price =
 if quantity > 0 && price > 0  then
   let
     numberOfPacks = quantity // 3
     numberOfNotPacked = rem quantity 3
     paidQuantity = numberOfPacks * 2 + numberOfNotPacked
   in
     Ok (price * paidQuantity)
 else
    Err "Erreur !"

main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }

type alias Model =
    { price : Result String Int
      , quantity : Int
    }



initialModel : (Model, Cmd Msg)
initialModel 
 = ({ price = Ok 0
      , quantity = 0
     }
   , Cmd.none)
 
type Msg
  = Quantitysend String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
 case msg of 
  Quantitysend quantity ->
   let
     quantity_ = Result.withDefault 0 (String.toInt quantity)
     
   in  
     ({model | price = totalPackPrice quantity_ 1}, Cmd.none)

display : Result String Int -> String
display priceresult = 
 case priceresult of
   Ok value ->
       toString value
   
   Err error ->
       error 

view : Model -> Html Msg
view model =
    div [] 
      [ Html.h1 [title "Prix"]
       [ text ("Le prix total est de : "  ++ display model.price)
        , br [] []
        , input 
            [ type_ "Quantity"
             , placeholder "Quantité"
             , onInput Quantitysend
            ]
            []
       ]
      ]

-- ----------------------with let

--makeOdd : Int -> Int
--makeOdd number =
--  let double n = n * 2
--  in
--    (double number) + 1

---- all top-level functions

--double : Int -> Int
--double n =
--  n * 2

--makeOdd : Int -> Int
--makeOdd n =
--  (double n) + 1
------------------------------

--double : Int -> Int
--double n =
--  n * 2

--increment : Int -> Int
--increment n =
--  n + 1

--makeOdd : Int -> Int
--makeOdd =
--  increment << double
----------------------