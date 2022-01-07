module Main exposing (main)

import ElmBook exposing (Book, book, withChapters, withThemeOptions)
import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmBook.ThemeOptions
import ElmWidgets as W exposing (..)
import ElmWidgets.Attributes as WA
import ElmWidgets.Styles
import Html as H
import UI


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
                        , WA.background "#09f"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , outlinedButton [ WA.color "#09f" ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , invisibleButton [ WA.color "#09f" ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            ]


main : Book ()
main =
    book "Elm-Widgets"
        |> withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ ElmWidgets.Styles.themeGlobal
                , ElmWidgets.Styles.globalStyles
                ]
            ]
        |> withChapters
            [ buttonsChapter
            ]
