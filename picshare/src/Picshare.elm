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
-- 1. new Feed alias
type alias Feed =
  List Photo
-- 2. update Model alias to use new Feed alias
type alias Model =
  { feed : Maybe Feed }

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
--12. viewFeed must handle Photo Feed
viewFeed : Maybe Feed -> Html Msg
viewFeed maybePhoto =
    case maybePhoto of
--13. iterate over List of Photos and add place photos to div as container
        Just feed ->
            div [] (List.map viewDetailedPhoto feed)
        Nothing ->
--14. for now photos show loadig icon
            div [ class "loading-feed" ]
                [ text "Loading Feed..." ]
view : Model -> Html Msg
view model =
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        div [ class "content-flow"]
-- 15. photo => feed
            [ viewFeed model.feed ]
    ]
  --5. LoadFeed functions returns Http error or Feed
type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment
    | LoadFeed (Result Http.Error Feed)
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
-- 6. comment out so we can load multiply photos without breaking application
--    , onClick ToggleLike 
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
viewComments : Photo -> Html Msg
viewComments photo =
  div []
    [ viewCommentList photo.comments
  -- 7. comment out onSubmit with inline comment feature, 
    , form [ class "new-comment" {- , onSubmit SaveComment -}]
      [ input
        [ type_ "text"
        , placeholder "Add a comment..."
        , value photo.newComment
  -- 8. comment out onInput
 --       , onInput UpdateComment
        ]
        []
      , button
        [ disabled (String.isEmpty photo.newComment) ]
        [ text "Save" ]
      ]
    ]
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
toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }
updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }
updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed updatePhoto maybePhoto =
    Maybe.map updatePhoto maybePhoto
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
--9. comment out pattern matches for all messages except for LoadFeed
{-
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
      )-}
--10. photo => feed
    LoadFeed (Ok feed) ->
      ( { model | feed = Just feed }
      , Cmd.none
      )
    LoadFeed (Err _) ->
      ( model, Cmd.none )
-- 11. add match all because we removed matches for valid Picshare messages
    _ ->
      ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
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
--3. photo => feed
initialModel : Model
initialModel = 
    { feed = Nothing }
fetchFeed : Cmd Msg
--4. update url to receive feed endpoint that has multiply photos and LoadFeed takes list of json decoded photos
fetchFeed =
  Http.get
    { url = baseUrl ++ "/feed"
    , expect = Http.expectJson LoadFeed (list photoDecoder)
    }