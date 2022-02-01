module Chapters.Checkbox exposing (..)

import ElmBook.Actions exposing (logActionWithBool)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Checkbox"
        |> renderComponentList
            [ ( "Default"
              , W.checkbox
                    []
                    { value = True
                    , onInput = logActionWithBool "onInput"
                    }
              )
            , ( "Disabled"
              , W.checkbox
                    [ WA.disabled True ]
                    { value = False
                    , onInput = logActionWithBool "onInput"
                    }
              )
            , ( "Read Only"
              , W.checkbox
                    [ WA.readOnly True ]
                    { value = True
                    , onInput = logActionWithBool "onInput"
                    }
              )
            , ( "Custom Color"
              , W.checkbox
                    [ WA.color "red" ]
                    { value = False
                    , onInput = logActionWithBool "onInput"
                    }
              )
            ]
