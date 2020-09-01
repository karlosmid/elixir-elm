module Picshare exposing (main)
import Html exposing (..)
import Html.Attributes exposing (class, src)

-- 4. new main varialble that is using View
main : Html msg
main =
    view initialModel
-- 1. make main => view that has model as argument
view : { url : String, caption : String } -> Html msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
            [ viewDetailedPhoto model]
    ]
-- 2. accept model in viewDetailed photo function
viewDetailedPhoto : { url : String, caption : String } -> Html msg
viewDetailedPhoto  model =
              div [ class "detaile-photo" ]
                [
              -- 3. use model attribute url
                img [ src model.url ] [],
                div [ class "photo-info"]
                -- 4. use model attribute caption
                    [ h2 [ class "caption" ] [ text model.caption] ]
                ]
baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
initialModel : { url : String, caption : String }
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
    }