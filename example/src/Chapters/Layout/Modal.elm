module Chapters.Layout.Modal exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import Theme
import W.Modal


chapter_ : Chapter x
chapter_ =
    let
        wrapper =
            H.div
                [ HA.style "position" "relative"
                , HA.style "height" "400px"
                , HA.style "background" Theme.baseBackground
                ]

        content =
            H.div
                [ HA.style "width" "100%"
                , HA.style "height" "600px"
                ]
                []
    in
    chapter "Modal"
        |> renderComponentList
            [ ( "Modal"
              , wrapper
                    [ W.Modal.view
                        [ W.Modal.absolute True ]
                        [ content ]
                    ]
              )
            , ( "Modal with onClose"
              , wrapper
                    [ W.Modal.view
                        [ W.Modal.absolute True 
                        , W.Modal.onClose (logAction "onClose")
                        ]
                        [ content ]
                    ]
              )
            ]
