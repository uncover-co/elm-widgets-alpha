module Chapters.RadioButtons exposing (chapter_)

import ElmBook.Actions exposing (logActionWith)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Radio"
        |> renderComponentList
            [ ( "Default"
              , W.radioButtons
                    []
                    { id = "default"
                    , value = 1
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Disabled"
              , W.radioButtons
                    [ WA.disabled True ]
                    { id = "disabled"
                    , value = 2
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Read Only"
              , W.radioButtons
                    [ WA.readOnly True ]
                    { id = "read-only"
                    , value = 2
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Custom Colors"
              , W.radioButtons
                    [ WA.color "red" ]
                    { id = "custom-colors"
                    , value = 3
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Vertical"
              , W.radioButtons
                    [ WA.vertical True ]
                    { id = "vertical"
                    , value = 2
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            ]
