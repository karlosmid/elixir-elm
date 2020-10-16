module Picshare exposing (main)
import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, src)
type alias Model = 
  { url : String
  , caption : String
  , liked : Bool
  }
main : Program () Model Msg
main =
    Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }
view : Model -> Html Msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
            [ viewDetailedPhoto model]
    ]
-- 1. refactor constructor of Msg type
type Msg
    = ToggleLike
-- 2. extract view logic in separate function
viewLoveButton : Model -> Html Msg
viewLoveButton model =
  let
    buttonClass =
      if model.liked then
        "fa-heart"
      else
        "fa-heart-o"
  in
  div [ class "like-button" ]
  [ i
    [ class "fa fa-2x"
    , class buttonClass
    , onClick ToggleLike 
    ]
    []
  ]
viewDetailedPhoto : Model -> Html Msg
viewDetailedPhoto  model =
    div [ class "detaile-photo" ]
        [
        img [ src model.url ] []
        , div [ class "photo-info"]
  -- 3. call viewLoveButton with model as argument
            [ viewLoveButton model
            , h2 [ class "caption" ] [ text model.caption]
          ]
        ]
update :
  Msg
    -> Model
    -> Model
  --4. update function handles ToggleLike logic
update msg model =
  case msg of
    ToggleLike ->
      { model | liked = not model.liked }

baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
initialModel : Model
initialModel = 
    { url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
      , liked = False
    }