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
-- 1. our model is record with photo filed that Maybe Photo type.
  { photo : Maybe Photo }
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
    Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
init : () -> ( Model, Cmd Msg)
init () =
  (initialModel, fetchFeed )
-- 7. we need viewFeed to bridge 
viewFeed : Maybe Photo -> Html Msg
viewFeed maybePhoto =
    case maybePhoto of
        Just photo ->
            viewDetailedPhoto photo
        Nothing ->
            text ""
-- 8. use viewFeed function.
view : Model -> Html Msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
            [ viewFeed model.photo ]
    ]
type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment
    | LoadFeed (Result Http.Error Photo)
-- 3. Model => Photo because our Model could only have Photo value.
-- argument name model => photo is cosmetic, but would help us to have more readable code
viewLoveButton : Photo -> Html Msg
viewLoveButton photo =
  let
    buttonClass =
      if photo.liked then
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
-- 4. Model => Photo because our Model could only have Photo value.
-- argument name model => photo is cosmetic, but would help us to have more readable code
viewComments : Photo -> Html Msg
viewComments photo =
  div []
    [ viewCommentList photo.comments
    , form [ class "new-comment", onSubmit SaveComment]
      [ input
        [ type_ "text"
        , placeholder "Add a comment..."
        , value photo.newComment
        , onInput UpdateComment
        ]
        []
      , button
        [ disabled (String.isEmpty photo.newComment) ]
        [ text "Save" ]
      ]
    ]
-- 5. Model => Photo because our Model could only have Photo value.
-- argument name model => photo is cosmetic, but would help us to have more readable code
viewDetailedPhoto : Photo -> Html Msg
viewDetailedPhoto  photo =
    div [ class "detailed-photo" ]
        [ img [ src photo.url ] []
        , div [ class "photo-info" ]
            [ viewLoveButton photo 
            , h2 [ class "caption" ] [ text photo.caption]
            , viewComments photo 
          ]
        ]
-- 9. add toggleLike and updateComment functions in order to DRY your code
toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }
updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }
-- 10. updateFeed bridges to Maybe Photo type
updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed updatePhoto maybePhoto =
-- new trick is Maybe.map function, it maps first argument function to second type
-- it handles Just and Nothing out of the box
    Maybe.map updatePhoto maybePhoto
-- 11. use updateFeed to bridge model and Mybe type
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ToggleLike ->
      ( { model
          | photo = updateFeed toggleLike model.photo }
      , Cmd.none
      )
    UpdateComment comment ->
      ( { model
          | photo = updateFeed (updateComment comment) model.photo
        }
      , Cmd.none
      )
    SaveComment ->
      ( { model 
          | photo = updateFeed saveNewComment model.photo
      }
      , Cmd.none
      )
    LoadFeed _ ->
      ( model, Cmd.none )
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
-- 6. Model => Photo because our Model could only have Photo value.
-- argument name model => photo is cosmetic, but would help us to have more readable code
saveNewComment : Photo -> Photo
saveNewComment photo =
  let
    comment =
      String.trim photo.newComment
  in
    case comment of
      "" -> photo
      _ ->
        { photo
        | comments = photo.comments ++ [ comment ]
        , newComment = ""
        }

baseUrl : String
baseUrl = "https://programming-elm.com"
--2. as Model is of type Maybe, we need to add Just
initialModel : Model
initialModel = 
    { photo = 
    Just
      { id = 1
      , url = baseUrl ++ "/1.jpg"
      , caption = "Surfing"
      , liked = False
      , comments = [ "Really nice place!" ]
      , newComment = ""
      }
    }
fetchFeed : Cmd Msg
fetchFeed =
  Http.get
    { url = baseUrl ++ "/feed/1"
    , expect = Http.expectJson LoadFeed photoDecoder
    }