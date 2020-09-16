module Picshare exposing (main)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, src)
main : Html Msg
main =
    view initialModel
view : { url : String, caption : String, liked: Bool } -> Html Msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
            [ viewDetailedPhoto model]
    ]
type Msg
    = Like
    | Unlike

viewDetailedPhoto : { url : String, caption : String, liked: Bool } -> Html Msg
viewDetailedPhoto  model =
    let
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
          [ div [ class "like-button" ]
            [ i --
              [ class "fa fa-2x" --
              , class buttonClass --
              , onClick msg --
              ]
              []
            ]
            , h2 [ class "caption" ] [ text model.caption]
          ]
        ]
-- 1. type annotation for update function
update :
-- 2. input is Msg Uniton Type
  Msg
-- 3. output are two same annotations for record models 
    -> { url : String, caption : String, liked : Bool }
    -> { url : String, caption : String, liked : Bool }
update msg model =
-- 4. welcome to pattern matching, case keyword, input is message
  case msg of
-- 5. if message is Like, update in record model liked to value True
    Like ->
      { model | liked = True }
-- 6. if message is Unlike, update in record model liked to value False
-- 7.   Unlike ->
-- 7.   { model | liked = False }

baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
initialModel : { url : String, caption : String, liked : Bool }
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
      , liked = False
    }