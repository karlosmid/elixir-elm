module Picshare exposing (main)
-- 1. expose all Html Module functions
import Html exposing (..)
-- 2. expose additional attribute src that we use in img element 
import Html.Attributes exposing (class, src)

main : Html msg
main =
-- 3. add root div element that is start of virtual DOM tree.
-- Virtual DOM can have only one root element.
    div []
    [
        div [ class "header" ]
            [ h1 [] [text "Picshare"] ],
        -- 4. add div as child of root div with css class content-flow
        div [ class "content-flow"]
        -- 5. div with css class detailed-photo as child of div content-flow
            [ div [ class "detaile-photo" ]
                [
                -- 6. img as child of div detailed-photo,
                -- with src attribute to image url and no child elements
                img [ src "https://www.hps.hr/files/data/27/kuce.folder/planinarska-kuca-picelj.jpg" ] [],
                -- 7. div as second child of div detailed-photo with css class photo-info
                div [ class "photo-info"]
                    -- 8. h2 with css style captionn as child of photo-info
                    [ h2 [ class "aption" ] [ text "Picelj Park Near Zabok"] ]
                ]
            ]
        ]