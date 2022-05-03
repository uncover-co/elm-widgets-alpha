module Chapters.Form.InputText exposing (chapter_)

import ElmBook.Actions exposing (logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import W.InputText


chapter_ : Chapter x
chapter_ =
    chapter "Input Text"
        |> renderComponentList
            [ ( "Default"
              , W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Password"
              , W.InputText.viewPassword
                    [ W.InputText.placeholder "Type your password…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Search"
              , W.InputText.viewSearch
                    [ W.InputText.placeholder "Search…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Email"
              , W.InputText.viewEmail
                    [ W.InputText.placeholder "user@email.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Url"
              , W.InputText.viewUrl
                    [ W.InputText.placeholder "https://app.site.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "TextArea"
              , W.InputText.viewTextArea
                    [ W.InputText.placeholder "Type something longer…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            ]
