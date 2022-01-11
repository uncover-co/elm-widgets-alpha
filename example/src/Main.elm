module Main exposing (fieldChapter, main)

import ElmBook exposing (Book, book, withChapterGroups, withThemeOptions)
import ElmBook.Actions exposing (logAction, logActionWith, logActionWithBool, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmBook.ThemeOptions
import ElmWidgets as W exposing (..)
import ElmWidgets.Attributes as WA
import ElmWidgets.Styles
import Html as H
import LogAction
import ThemeSpec
import UI


lightTheme : ThemeSpec.Theme
lightTheme =
    let
        baseTheme =
            ThemeSpec.lightTheme

        baseColor =
            baseTheme.color
    in
    { baseTheme | color = { baseColor | tint = "#efefef" } }


main : Book ()
main =
    book "Elm-Widgets"
        |> withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ ThemeSpec.globalProviderWithDarkMode
                    { light = lightTheme
                    , dark = ThemeSpec.darkTheme
                    , strategy = ThemeSpec.ClassStrategy "elm-book-dark-mode"
                    }
                , ElmWidgets.Styles.globalStyles
                ]
            ]
        |> withChapterGroups
            [ ( "Core"
              , [ buttonsChapter
                ]
              )
            , ( "Form"
              , [ fieldChapter
                , inputChapter
                , checkboxChapter
                , radioButtonsChapter
                , selectChapter
                ]
              )
            ]



-- Field


fieldChapter : Chapter x
fieldChapter =
    chapter "Field"
        |> renderComponentList
            [ ( "Default"
              , H.div []
                    [ W.field []
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field [ WA.hint "Try writing some text here." ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        , WA.warning "You know better than this."
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        , WA.warning "You know better than this."
                        , WA.danger "You're in trouble now…"
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    ]
              )
            ]



-- Checkbox


checkboxChapter : Chapter x
checkboxChapter =
    chapter "Checkbox"
        |> renderComponentList
            [ ( "Default"
              , W.checkbox
                    []
                    { value = False
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
            , ( "Custom Color"
              , W.checkbox
                    [ WA.color "red" ]
                    { value = False
                    , onInput = logActionWithBool "onInput"
                    }
              )
            ]



-- Radio Buttons


radioButtonsChapter : Chapter x
radioButtonsChapter =
    chapter "Radio"
        |> renderComponentList
            [ ( "Default"
              , W.radioButtons
                    []
                    { name = "radio"
                    , value = Nothing
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Disabled"
              , W.radioButtons
                    [ WA.disabled True ]
                    { name = "radio"
                    , value = Nothing
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Custom Colors"
              , W.radioButtons
                    [ WA.color "red" ]
                    { name = "radio"
                    , value = Nothing
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Vertical"
              , W.radioButtons
                    [ WA.vertical True ]
                    { name = "radio"
                    , value = Nothing
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            ]



-- Input


inputChapter : Chapter x
inputChapter =
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



-- Select


selectChapter : Chapter x
selectChapter =
    chapter "Select"
        |> renderComponentList
            [ ( "Simple"
              , W.select
                    []
                    { value = Just 1
                    , toString = String.fromInt
                    , onInput = LogAction.logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "first", 1 )
                        , ( "second", 2 )
                        ]
                    }
              )
            , ( "Disabled"
              , W.select
                    [ WA.disabled True ]
                    { value = Nothing
                    , toString = String.fromInt
                    , onInput = LogAction.logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "first", 1 )
                        , ( "second", 2 )
                        ]
                    }
              )
            , ( "With Placeholder"
              , W.select
                    [ WA.placeholder "Select a number" ]
                    { value = Nothing
                    , toString = String.fromInt
                    , onInput = LogAction.logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "first", 1 )
                        , ( "second", 2 )
                        ]
                    }
              )
            , ( "With Option Groups"
              , W.selectWithGroups
                    [ WA.placeholder "Select a year" ]
                    { value = Nothing
                    , toString = String.fromInt
                    , onInput = LogAction.logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "1900", 1900 )
                        , ( "2000", 2000 )
                        ]
                    , optionGroups =
                        [ ( "70's", [ ( "1978", 1978 ), ( "1979", 1979 ) ] )
                        , ( "80's", [ ( "1988", 1988 ), ( "1989", 1989 ) ] )
                        ]
                    }
              )
            ]



-- Buttons


buttonsChapter : Chapter x
buttonsChapter =
    chapter "Buttons"
        |> renderComponentList
            [ ( "primary button"
              , UI.hSpacer
                    [ W.primaryButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.primaryButton
                        [ WA.disabled True
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "danger button"
              , UI.hSpacer
                    [ W.dangerButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.dangerButton
                        [ WA.disabled True
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "confirm button"
              , UI.hSpacer
                    [ W.confirmButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.confirmButton
                        [ WA.disabled True
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "outline button"
              , UI.hSpacer
                    [ outlinedButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , outlinedButton [ WA.disabled True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "invisible button"
              , UI.hSpacer
                    [ invisibleButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , invisibleButton [ WA.disabled True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "custom colors"
              , UI.hSpacer
                    [ W.primaryButton
                        [ WA.color "var(--tmspc-warning-contrast)"
                        , WA.background "var(--tmspc-warning-base)"
                        , WA.shadow "var(--tmspc-warning-shadow)"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , outlinedButton
                        [ WA.color "var(--tmspc-warning-dark)"
                        , WA.shadow "var(--tmspc-warning-shadow)"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , invisibleButton
                        [ WA.color "var(--tmspc-warning-base)"
                        , WA.background "var(--tmspc-warning-tint)"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "fill containers"
              , UI.vSpacer
                    [ primaryButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , dangerButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , confirmButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , outlinedButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , invisibleButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "buttons as links"
              , UI.hSpacer
                    [ primaryButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , dangerButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , confirmButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , outlinedButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , invisibleButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    ]
              )
            ]
