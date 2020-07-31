module Picshare exposing (main)
-- 3. expose from Html Module h1 function
import Html exposing (Html, div, text, h1)
-- 1. import Html.Attributes module function class. class html attribute
-- tells browser which css to use for element owner of class attribute
import Html.Attributes exposing (class)

main : Html msg
main =
-- 2. use class header for our root div element
    div [ class "header" ]
-- 4. make text function child of h1 function, note that h1 attribute list is empty
    [ h1 [] [text "Picshare"] ]