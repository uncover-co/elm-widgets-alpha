module Chapters.Loading exposing (chapter_)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Loading"
        |> renderComponentList
            [ ( "Circle"
              , W.loadingCircle []
              )
            , ( "Circle with Custom Size and Color"
              , W.loadingCircle
                    [ WA.size 40
                    , WA.color "red"
                    ]
              )
            , ( "Dots"
              , W.loadingDots []
              )
            , ( "Dots with Custom Size and Color"
              , W.loadingDots
                    [ WA.size 40
                    , WA.color "red"
                    ]
              )
            , ( "Ripple"
              , W.loadingRipple []
              )
            , ( "Ripple with Custom Size and Color"
              , W.loadingRipple
                    [ WA.size 40
                    , WA.color "red"
                    ]
              )
            ]
