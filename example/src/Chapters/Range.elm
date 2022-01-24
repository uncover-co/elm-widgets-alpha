module Chapters.Range exposing (chapter_)

import ElmBook.Actions exposing (logActionWith)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Range"
        |> renderComponentList
            [ ( "Default"
              , W.rangeInput []
                    { min = 0
                    , max = 10
                    , step = 1
                    , value = 5
                    , onInput = logActionWith String.fromFloat "onInput"
                    }
              )
            , ( "Disabled"
              , W.rangeInput [ WA.disabled True ]
                    { min = 0
                    , max = 10
                    , step = 1
                    , value = 5
                    , onInput = logActionWith String.fromFloat "onInput"
                    }
              )
            , ( "Custom Color"
              , W.rangeInput [ WA.color "red" ]
                    { min = 0
                    , max = 10
                    , step = 1
                    , value = 5
                    , onInput = logActionWith String.fromFloat "onInput"
                    }
              )
            ]
