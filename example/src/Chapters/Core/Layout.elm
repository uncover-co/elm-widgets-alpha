module Chapters.Core.Layout exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import W.Layout


chapter_ : Chapter x
chapter_ =
    chapter "Layout"
        |> renderComponentList
            [ ( "Default"
              , W.Layout.view
                    [ W.Layout.padX_2
                    , W.Layout.padY_8
                    , W.Layout.horizontal
                    , W.Layout.alignTop
                    , W.Layout.gap_2
                    , W.Layout.largeScreen
                        [ W.Layout.padY_2
                        , W.Layout.spaceAround
                        ]
                    ]
                    [ H.span [] [ H.text "left" ]
                    , H.span [] [ H.text "right" ]
                    ]
              )
            ]
