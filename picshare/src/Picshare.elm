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
            [ viewPhoto (baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg") "Picelj Park Near Zabok", 
              viewPhoto (baseUrl ++ "69/_resized/dinara_475_0_withoutgrow.jpg") "Dinara Mountain"
            ]
    ]
viewPhoto : String -> String -> Html msg
viewPhoto url description =
              div [ class "detaile-photo" ]
                [
                img [ src url ] [],
                div [ class "photo-info"]
                    [ h2 [ class "caption" ] [ text description] ]
                ]
baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
-- 1. add initial model that describes a picture with record type annotation 
initialModel : { url : String, caption : String }
-- 2. add record instance that represents picture for Park Picelj
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
    }