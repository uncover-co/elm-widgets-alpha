module Chapters.Core.Container exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import W.Container


chapter_ : Chapter x
chapter_ =
    chapter "Container"
        |> renderComponentList
            [ ( "Default"
              , W.Container.view
                    [ W.Container.padX_2
                    , W.Container.padY_8
                    , W.Container.spaceX_2
                    , W.Container.largeScreen
                        [ W.Container.padY_2
                        ]
                    ]
                    [ H.span [] [ H.text "left" ]
                    , H.span [] [ H.text "right" ]
                    ]
              )
            ]
