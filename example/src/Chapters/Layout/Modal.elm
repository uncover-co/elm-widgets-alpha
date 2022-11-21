module Chapters.Layout.Modal exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import Theme
import W.Button
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
                    [ W.Modal.view [ W.Modal.absolute ]
                        { isOpen = True
                        , onClose = Nothing
                        , children = [ content ]
                        }
                    ]
              )
            , ( "Modal with onClose"
              , wrapper
                    [ W.Modal.view [ W.Modal.absolute ]
                        { isOpen = True
                        , onClose = Just (logAction "onClose")
                        , children = [ content ]
                        }
                    ]
              )
            , ( "Modal with toggle"
              , wrapper
                    [ W.Modal.viewToggable [ W.Modal.absolute ]
                        { id = "my-modal"
                        , children = [ content ]
                        }
                    , W.Modal.viewToggle "my-modal"
                        [ W.Button.viewDummy [] [ H.text "Toggle Modal" ] ]
                    ]
              )
            ]
