module Picshare exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class, src)

main : Html msg
main =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
        -- 3. add viewPhoto calls with attributes
            [ viewPhoto (baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg") "Picelj Park Near Zabok", 
              viewPhoto (baseUrl ++ "69/_resized/dinara_475_0_withoutgrow.jpg") "Dinara Mountain"
            ]
    ]
-- 1. create viewPhoto function that takes two Stings, url and description, and returns VirtualDOM 
viewPhoto : String -> String -> Html msg
viewPhoto url description =
              div [ class "detaile-photo" ]
                [
                img [ src url ] [],
                div [ class "photo-info"]
                    [ h2 [ class "caption" ] [ text description] ]
                ]
-- 2. baseUrl is site from where we get phots.
baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
