module Picshare exposing (main)
import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
-- 3. expose from Html.Attributes modeul placeholder and type_ functions
import Html.Attributes exposing (class, src, placeholder, type_)
type alias Model = 
  { url : String
  , caption : String
  , liked : Bool
  -- 1. add list of comments and newComments currently typed by the user.
  , comments : List String
  , newComment : String
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
type Msg
    = ToggleLike
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
-- 3. add function that displays one comment
viewComment : String -> Html Msg
viewComment comment =
  li []
    [ strong [] [ text "Comment:" ]
    , text (" " ++ comment)
    ]
-- 4. add function that displays list of comments
viewCommentList : List String -> Html Msg
viewCommentList comments =
  case comments of
    [] ->
      text ""
    _ ->
        div [ class "comments" ]
          [ ul []
            (List.map viewComment comments)
          ]
-- 5. add viewComments view function that will display comments and input comment
viewComments : Model -> Html Msg
viewComments model =
  div []
    [ viewCommentList model.comments
    , form [ class "new-comment" ]
      [ input
        [ type_ "text"
        , placeholder "Add a comment..."
        ]
        []
      , button [] [ text "Save" ]
      ]
    ]
viewDetailedPhoto : Model -> Html Msg
viewDetailedPhoto  model =
    div [ class "detailed-photo" ]
        [
        img [ src model.url ] []
        , div [ class "photo-info"]
            [ viewLoveButton model
            , h2 [ class "caption" ] [ text model.caption]
            -- 6. add viewCommets to display comments and input comment text filed.
            , viewComments model
          ]
        ]
update :
  Msg
    -> Model
    -> Model
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
  -- 2. add two Model attributes to initial model.
      , comments = [ "Really nice place!" ]
      , newComment = ""
    }