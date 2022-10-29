module Chapters.Form.InputText exposing (chapter_)

import ElmBook.Actions exposing (logAction, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import W.InputText
import W.Button
import Html as H


chapter_ : Chapter x
chapter_ =
    chapter "Input Text"
        |> renderComponentList
            [ ( "Default"
              , W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.prefix (H.text "$")
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Disabled"
              , W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.suffix (H.text "Email")
                    , W.InputText.disabled True
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Read Only"
              , W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.readOnly True
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Password"
              , W.InputText.view
                    [ W.InputText.password
                    , W.InputText.placeholder "Type your password…"
                    , W.InputText.suffix
                        (W.Button.view 
                            [ W.Button.small, W.Button.invisible ]
                            { label = H.text "Show"
                            , onClick = logAction "onClick" 
                        })
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Search"
              , W.InputText.view
                    [ W.InputText.search
                    , W.InputText.placeholder "Search…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Email"
              , W.InputText.view
                    [ W.InputText.email
                    , W.InputText.placeholder "user@email.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Url"
              , W.InputText.view
                    [ W.InputText.url
                    , W.InputText.placeholder "https://app.site.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Validation"
              , W.InputText.viewWithValidation
                    [ W.InputText.url
                    , W.InputText.minLength 2
                    , W.InputText.placeholder "https://app.site.com"
                    ]
                    { value = ""
                    , onInput = \value result ->
                        logActionWithString "onInput" (Debug.toString (value, result))
                    }
              )
            ]
