module Picshare exposing (main)
import Browser
import Html exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Attributes exposing (class, src, placeholder, type_, disabled, value)
import Json.Decode exposing (Decoder, bool, int, list, string, succeed)
import Json.Decode.Pipeline exposing (hardcoded, required)
import Http
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
photoDecoder : Decoder Photo
photoDecoder =
  succeed Photo
    |> required "id" int
    |> required "url" string
    |> required "caption" string
    |> required "liked" bool
    |> required "comments" (list string)
    |> hardcoded ""

main : Program () Model Msg
main =
-- 1. replace sendbox wih element
    Browser.element
-- 2. replace init with init method. This method is first called when we start the application.
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
-- 3. init method takes no any parameter and returns tuple of Model and Cmd
init : () -> ( Model, Cmd Msg)
init () =
  (initialModel, fetchFeed )
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
-- 4. add message for HTTP get
    | LoadFeed (Result Http.Error Photo)

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
    -> ( Model, Cmd Msg )
-- 5. update should return tuple with Model and Cmd
update msg model =
  case msg of
    ToggleLike ->
      ( { model | liked = not model.liked }
      , Cmd.none
      )
    UpdateComment comment ->
      ( {model | newComment = comment }
      , Cmd.none
      )
    SaveComment ->
      ( saveNewComment model
      , Cmd.none
      )
-- 6. this is new message
    LoadFeed _ ->
      ( model, Cmd.none )
-- 7. no operation subscription method
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
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
-- 8. update baseUrl
baseUrl = "https://programming-elm.com"
initialModel : Model
initialModel = 
    { id = 1
-- 9. update image sub url
      , url = baseUrl ++ "/feed/1"
      , caption = "Picelj Park Near Zabok"
      , liked = False
      , comments = [ "Really nice place!" ]
      , newComment = ""
    }
fetchFeed : Cmd Msg
fetchFeed =
  Http.get
-- 10. update image sub url
    { url = baseUrl ++ "/feed/1"
    , expect = Http.expectJson LoadFeed photoDecoder
    }