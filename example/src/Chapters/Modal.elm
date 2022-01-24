module Chapters.Modal exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA
import Html as H
import Html.Attributes as HA
import ThemeSpec


chapter_ : Chapter x
chapter_ =
    let
        wrapper =
            H.div
                [ HA.style "position" "relative"
                , HA.style "height" "400px"
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
                    [ W.modal [ WA.absolute True ]
                        { onClose = Nothing
                        , content = content
                        }
                    ]
              )
            , ( "Modal with onClose"
              , wrapper
                    [ W.modal [ WA.absolute True ]
                        { onClose = Just (logAction "onClose")
                        , content = content
                        }
                    ]
              )
            , ( "Custom Colors"
              , wrapper
                    [ W.modal
                        [ WA.absolute True
                        , WA.background ThemeSpec.highlightDark
                        , WA.shadow ThemeSpec.highlightDark
                        , WA.color ThemeSpec.highlightTint
                        ]
                        { onClose = Just (logAction "onClose")
                        , content = content
                        }
                    ]
              )
            ]
