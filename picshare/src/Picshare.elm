-- 8. temporary expose to test in elm repl
module Picshare exposing (main, photoDecoder)
import Browser
import Html exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Attributes exposing (class, src, placeholder, type_, disabled, value)
-- 1. import Json modules
import Json.Decode exposing (Decoder, bool, int, list, string, succeed)
import Json.Decode.Pipeline exposing (hardcoded, required)
type alias Id =
  Int
type alias Photo =
  { id : Id
  , url : String
  , caption : String
  , liked : Bool
  , comments : List String
  , newComment : String
  }
type alias Model =
  Photo
-- 2. start of photoDecoder function
photoDecoder : Decoder Photo
photoDecoder =
-- 3. return type Photo for successfull Json decoding
  succeed Photo
-- 4. you saw that in dogDecoder, in Json string, decode id into Elm int
    |> required "id" int
-- 5. url should be decoded into Elm string
    |> required "url" string
    |> required "caption" string
    |> required "liked" bool
-- 6. this is new because comments is list of strings
    |> required "comments" (list string)
-- 7. newComment is just a helper and it is not stored on server so we do not need it in Json string. Hardcode its value in Photo type to empty Elm string
    |> hardcoded ""

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
    | UpdateComment String
    | SaveComment

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
viewComment : String -> Html Msg
viewComment comment =
  li []
    [ strong [] [ text "Comment:" ]
    , text (" " ++ comment)
    ]
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
viewComments : Model -> Html Msg
viewComments model =
  div []
    [ viewCommentList model.comments
    , form [ class "new-comment", onSubmit SaveComment]
      [ input
        [ type_ "text"
        , placeholder "Add a comment..."
        , value model.newComment
        , onInput UpdateComment
        ]
        []
      , button
        [ disabled (String.isEmpty model.newComment) ]
        [ text "Save" ]
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
    UpdateComment comment ->
      {model | newComment = comment }
    SaveComment ->
      saveNewComment model
saveNewComment : Model -> Model
saveNewComment model =
  let
    comment =
      String.trim model.newComment
  in
    case comment of
      "" -> model
      _ ->
        { model
        | comments = model.comments ++ [ comment ]
        , newComment = ""
        }

baseUrl : String
baseUrl = "https://www.hps.hr/files/data/"
initialModel : Model
initialModel = 
    { id = 1
      , url = baseUrl ++ "27/kuce.folder/planinarska-kuca-picelj.jpg"
      , caption = "Picelj Park Near Zabok"
      , liked = False
      , comments = [ "Really nice place!" ]
      , newComment = ""
    }