module Chapters.Input exposing (chapter_)

import ElmBook.Actions exposing (logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


chapter_ : Chapter x
chapter_ =
    chapter "Input"
        |> renderComponentList
            [ ( "Simple"
              , W.textInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Disabled"
              , W.textInput
                    [ WA.placeholder "…", WA.disabled True ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Read Only"
              , W.textInput
                    [ WA.placeholder "…", WA.readOnly True ]
                    { value = "Some value"
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Password"
              , W.passwordInput
                    [ WA.placeholder "…"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Date"
              , W.dateInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Time"
              , W.timeInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "Datetime"
              , W.datetimeInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "email"
              , W.emailInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "search"
              , W.searchInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "telephone"
              , W.telephoneInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "url"
              , W.urlInput
                    [ WA.placeholder "…" ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            , ( "with pattern"
              , W.textInput
                    [ WA.placeholder "(00) 00000 0000"
                    , WA.pattern "\\(\\d{2}\\)\\s\\d{5} \\d{4}"
                    ]
                    { value = ""
                    , onInput = logActionWithString "onInput"
                    }
              )
            ]
