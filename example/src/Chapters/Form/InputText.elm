module Chapters.Form.InputText exposing (Model, init, chapter_)

import ElmBook.Actions exposing (updateStateWith, updateState, logAction, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderStatefulComponentList)
import W.InputText
import W.Button
import Html as H



type alias Model =
    { value : String
    , validated : String
    }


init : Model
init =
    { value = "Some text"
    , validated = "Some text"
    }


chapter_ : Chapter { x | inputText : Model }
chapter_ =
    chapter "Input Text"
        |> renderStatefulComponentList
            [ ( "Default"
              , \{ inputText } -> W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.mask (\s -> "R$ " ++ s)
                    , W.InputText.prefix (H.text "$")
                    ]
                    { value = inputText.value
                    , onInput =
                            updateStateWith
                                (\v model ->
                                    let
                                        inputText_ =
                                            model.inputText
                                    in
                                    { model | inputText = { inputText_ | value = v } }
                                )
                    }
              )
            , ( "Disabled"
              , \_ -> W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.suffix (H.text "Email")
                    , W.InputText.disabled True
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Read Only"
              , \_ -> W.InputText.view
                    [ W.InputText.placeholder "Type something…"
                    , W.InputText.readOnly True
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Password"
              , \_ -> W.InputText.view
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
              , \_ -> W.InputText.view
                    [ W.InputText.search
                    , W.InputText.placeholder "Search…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Email"
              , \_ -> W.InputText.view
                    [ W.InputText.email
                    , W.InputText.placeholder "user@email.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Url"
              , \_ -> W.InputText.view
                    [ W.InputText.url
                    , W.InputText.placeholder "https://app.site.com"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Validation"
              , \{ inputText } -> W.InputText.viewWithValidation
                    [ W.InputText.url
                    , W.InputText.minLength 2
                    , W.InputText.mask (\s -> "Validated: " ++ s)
                    , W.InputText.placeholder "https://app.site.com"
                    ]
                    { value = inputText.validated
                    , onInput = \v r ->
                        updateState
                            (\model ->
                                let
                                    inputText_ =
                                        model.inputText
                                in
                                { model | inputText = { inputText_ | validated = v } }
                            )
                    }
              )
            ]
