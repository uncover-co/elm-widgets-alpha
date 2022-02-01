module Chapters.Select exposing (chapter_)

import ElmBook.Actions exposing (logActionWith)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Select"
        |> renderComponentList
            [ ( "Simple"
              , W.select
                    []
                    { value = 1
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , onInput = logActionWith String.fromInt "onInput"
                    , options = [ 1, 2 ]
                    }
              )
            , ( "Disabled"
              , W.select
                    [ WA.disabled True ]
                    { value = 1
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , onInput = logActionWith String.fromInt "onInput"
                    , options = [ 1, 2 ]
                    }
              )
            , ( "With Placeholder"
              , W.select
                    []
                    { value = 2
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , onInput = logActionWith String.fromInt "onInput"
                    , options = [ 1, 2 ]
                    }
              )
            , ( "With Option Groups"
              , W.selectWithGroups
                    []
                    { value = 2000
                    , toValue = String.fromInt
                    , toLabel = String.fromInt
                    , onInput = logActionWith String.fromInt "onInput"
                    , options = [ 1900, 2000 ]
                    , optionGroups =
                        [ ( "70's", [ 1978, 1979 ] )
                        , ( "80's", [ 1988, 1989 ] )
                        ]
                    }
              )
            ]
