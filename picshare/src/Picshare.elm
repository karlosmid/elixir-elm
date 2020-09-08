module Picshare exposing (main)
import Html exposing (..)
-- 8. import Events module
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, src)
-- 10 . msg => Msg
main : Html Msg
main =
    view initialModel
-- 2. change view function annotation by adding liked and changing msg => Msg type
view : { url : String, caption : String, liked: Bool } -> Html Msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
            [ viewDetailedPhoto model]
    ]
-- 9. define message type
type Msg
    = Like
    | Unlike

-- 3. change annotation because view function annotation changed
viewDetailedPhoto : { url : String, caption : String, liked: Bool } -> Html Msg
viewDetailedPhoto  model =
    let
    -- 4. create button class value based on model liked attribute value
        buttonClass = --
            if model.liked then
                "fa-heart"
            else
                "fa-heart-o"
        msg = --
            if model.liked then
              Unlike
            else
              Like
    in
    div [ class "detaile-photo" ]
        [
        img [ src model.url ] []
        , div [ class "photo-info"]
        -- 5. this is html for like button
          [ div [ class "like-button" ]
            -- 6. heart icon that is changed on click like/unlike
            [ i --
              [ class "fa fa-2x" --
              , class buttonClass --
              -- 7. we use onClick function from Events module
              , onClick msg --
              ]
              []
            ]
            , h2 [ class "caption" ] [ text model.caption]
          ]
        ]
baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
-- 1. add liked as Bool and set default to False. This is where we store like/unlike button clicks
initialModel : { url : String, caption : String, liked : Bool }
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
      , liked = False
    }