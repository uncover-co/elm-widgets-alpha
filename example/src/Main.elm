module Main exposing (main)

import Chapters.Autocomplete
import Chapters.Buttons
import Chapters.Checkbox
import Chapters.DataRow
import Chapters.Field
import Chapters.Input
import Chapters.Loading
import Chapters.Modal
import Chapters.RadioButtons
import Chapters.Range
import Chapters.Select
import ElmBook exposing (Book, book, withChapterGroups, withStatefulOptions, withThemeOptions)
import ElmBook.StatefulOptions
import ElmBook.ThemeOptions
import ElmWidgets.Styles
import ThemeSpec


type alias SharedState =
    { range :
        { default : Float
        , customColor : Float
        }
    }


main : Book SharedState
main =
    book "Elm-Widgets"
        |> withStatefulOptions
            [ ElmBook.StatefulOptions.initialState
                { range = Chapters.Range.init
                }
            ]
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
                , Chapters.Input.chapter_
                , Chapters.Autocomplete.chapter_
                , Chapters.Checkbox.chapter_
                , Chapters.RadioButtons.chapter_
                , Chapters.Select.chapter_
                , Chapters.Range.chapter_
                ]
              )
            ]
