module Main exposing (main)

import Chapters.Core.Buttons
import Chapters.Core.Loading
import Chapters.Form.Field
import Chapters.Form.InputAutocomplete
import Chapters.Form.InputCheckbox
import Chapters.Form.InputDate
import Chapters.Form.InputNumber
import Chapters.Form.InputRadio
import Chapters.Form.InputSelect
import Chapters.Form.InputSlider
import Chapters.Form.InputText
import Chapters.Form.InputTextArea
import Chapters.Form.InputTime
import Chapters.Information.DataRow
import Chapters.Information.Popover
import Chapters.Layout.Modal
import ElmBook exposing (Book, book, withChapterGroups, withStatefulOptions, withThemeOptions)
import ElmBook.StatefulOptions
import ElmBook.ThemeOptions
import ThemeProvider
import ThemeSpec
import W.Styles


type alias SharedState =
    { range :
        { default : Float
        , customColor : Float
        }
    , inputNumber : Chapters.Form.InputNumber.Model
    }


main : Book SharedState
main =
    book "elm-widgets"
        |> withStatefulOptions
            [ ElmBook.StatefulOptions.initialState
                { range = Chapters.Form.InputSlider.init
                , inputNumber = Chapters.Form.InputNumber.init
                }
            ]
        |> withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ ThemeProvider.globalProviderWithDarkMode
                    { light = ThemeSpec.theme ThemeSpec.lightTheme
                    , dark = ThemeSpec.theme ThemeSpec.darkTheme
                    , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                    }
                , W.Styles.globalStyles
                ]
            ]
        |> withChapterGroups
            [ ( "Core"
              , [ Chapters.Core.Buttons.chapter_
                , Chapters.Core.Loading.chapter_
                ]
              )
            , ( "Layout"
              , [ Chapters.Layout.Modal.chapter_
                ]
              )
            , ( "Information"
              , [ Chapters.Information.DataRow.chapter_
                , Chapters.Information.Popover.chapter_
                ]
              )
            , ( "Form"
              , [ Chapters.Form.Field.chapter_
                , Chapters.Form.InputText.chapter_
                , Chapters.Form.InputTextArea.chapter_
                , Chapters.Form.InputNumber.chapter_
                , Chapters.Form.InputTime.chapter_
                , Chapters.Form.InputDate.chapter_
                , Chapters.Form.InputAutocomplete.chapter_
                , Chapters.Form.InputCheckbox.chapter_
                , Chapters.Form.InputRadio.chapter_
                , Chapters.Form.InputSelect.chapter_
                , Chapters.Form.InputSlider.chapter_
                ]
              )
            ]
