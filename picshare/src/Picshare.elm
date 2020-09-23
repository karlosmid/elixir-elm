module Picshare exposing (main)
-- 1. we need Browser module
import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, src)
-- 2. rewrite main annotation type
main : Program () {url: String, caption: String, liked: Bool } Msg
-- 3. and main constant
main =
    Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }
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
update :
  Msg
    -> { url : String, caption : String, liked : Bool }
    -> { url : String, caption : String, liked : Bool }
update msg model =
  case msg of
    Like ->
      { model | liked = True }
    Unlike ->
      { model | liked = False }

baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
initialModel : { url : String, caption : String, liked : Bool }
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
      , liked = False
    }