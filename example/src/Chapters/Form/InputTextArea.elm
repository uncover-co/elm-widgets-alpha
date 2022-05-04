module Chapters.Form.InputTextArea exposing (chapter_)

import ElmBook.Actions exposing (logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import W.InputTextArea


chapter_ : Chapter x
chapter_ =
    chapter "Input TextArea"
        |> renderComponentList
            [ ( "Default"
              , W.InputTextArea.view
                    [ W.InputTextArea.placeholder "Type something…"
                    , W.InputTextArea.rows 20
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Resizable"
              , W.InputTextArea.view
                    [ W.InputTextArea.placeholder "Type something…"
                    , W.InputTextArea.rows 4
                    , W.InputTextArea.resizable True
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            ]
