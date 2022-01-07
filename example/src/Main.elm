module Main exposing (main)

import ElmBook exposing (Book, book, withChapters, withThemeOptions)
import ElmBook.Actions exposing (logAction, logActionWith, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmBook.ThemeOptions
import ElmWidgets as W exposing (..)
import ElmWidgets.Attributes as WA
import ElmWidgets.Styles
import ElmWidgets.Theme
import Html as H
import Html.Attributes as HA
import UI


main : Book ()
main =
    book "Elm-Widgets"
        |> withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ ElmWidgets.Theme.themeGlobalStyles
                , ElmWidgets.Styles.globalStyles
                ]
            ]
        |> withChapters
            [ buttonsChapter
            , inputsChapter
            ]



-- Inputs


logActionWithMaybeInt : String -> Maybe Int -> ElmBook.Msg x
logActionWithMaybeInt label i =
    i
        |> Maybe.map (logActionWith (\i_ -> "Just " ++ String.fromInt i_) label)
        |> Maybe.withDefault (logAction (label ++ ": Nothing"))


inputsChapter : Chapter x
inputsChapter =
    chapter "Inputs"
        |> renderComponentList
            [ ( "select"
              , W.select
                    []
                    { value = Just 1
                    , toString = String.fromInt
                    , onInput = logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "first", 1 )
                        , ( "second", 2 )
                        ]
                    }
              )
            , ( "select - with placeholder"
              , W.select
                    [ WA.placeholder "Select a number" ]
                    { value = Nothing
                    , toString = String.fromInt
                    , onInput = logActionWithMaybeInt "onInput"
                    , options =
                        [ ( "first", 1 )
                        , ( "second", 2 )
                        ]
                    }
              )
            , ( "select - with groups"
              , W.selectWithGroups
                    [ WA.placeholder "Select a year" ]
                    { value = Nothing
                    , toString = String.fromInt
                    , onInput = logActionWithMaybeInt "onInput"
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
                        [ WA.color "#fff"
                        , WA.background "#fa0"
                        , WA.shadow "#f4bd4f"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , outlinedButton
                        [ WA.color "#fa0"
                        , WA.shadow "#f4bd4f"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , invisibleButton
                        [ WA.color "#fa0"
                        , WA.background "#fff0d1"
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



-- Input
-- Checkbox
-- Radio
