module Main exposing (main)

import Chapters.Autocomplete
import Chapters.Buttons
import Chapters.DataRow
import Chapters.Field
import Chapters.Loading
import Chapters.Modal
import Chapters.Range
import ElmBook exposing (Book, book, withChapterGroups, withThemeOptions)
import ElmBook.Actions exposing (logActionWith, logActionWithBool, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmBook.ThemeOptions
import ElmWidgets as W exposing (..)
import ElmWidgets.Attributes as WA
import ElmWidgets.Styles
import ThemeSpec


main : Book ()
main =
    book "Elm-Widgets"
        |> withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ ThemeSpec.globalProviderWithDarkMode
                    { light = ThemeSpec.lightTheme
                    , dark = ThemeSpec.darkTheme
                    , strategy = ThemeSpec.ClassStrategy "elm-book-dark-mode"
                    }
                , ElmWidgets.Styles.globalStyles
                ]
            ]
        |> withChapterGroups
            [ ( "Core"
              , [ Chapters.Buttons.chapter_
                , Chapters.Loading.chapter_
                ]
              )
            , ( "Layout"
              , [ Chapters.Modal.chapter_
                , Chapters.DataRow.chapter_
                ]
              )
            , ( "Form"
              , [ Chapters.Field.chapter_
                , inputChapter
                , Chapters.Autocomplete.chapter_
                , checkboxChapter
                , radioButtonsChapter
                , selectChapter
                , Chapters.Range.chapter_
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
                    { value = 1
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Disabled"
              , W.radioButtons
                    [ WA.disabled True ]
                    { value = 2
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Custom Colors"
              , W.radioButtons
                    [ WA.color "red" ]
                    { value = 3
                    , toLabel = String.fromInt
                    , toValue = String.fromInt
                    , options = [ 1, 2, 3 ]
                    , onInput = logActionWith String.fromInt "onInput"
                    }
              )
            , ( "Vertical"
              , W.radioButtons
                    [ WA.vertical True ]
                    { value = 2
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



-- Select


selectChapter : Chapter x
selectChapter =
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
