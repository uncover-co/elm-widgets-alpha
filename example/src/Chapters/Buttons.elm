module Chapters.Buttons exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA
import Html as H
import UI


chapter_ : Chapter x
chapter_ =
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
                    [ W.outlinedButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.outlinedButton [ WA.disabled True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "invisible button"
              , UI.hSpacer
                    [ W.invisibleButton []
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.invisibleButton [ WA.disabled True ]
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
                    , W.outlinedButton
                        [ WA.color "var(--tmspc-warning-base)"
                        , WA.shadow "var(--tmspc-warning-shadow)"
                        ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.invisibleButton
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
                    [ W.primaryButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.dangerButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.confirmButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.outlinedButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    , W.invisibleButton [ WA.fill True ]
                        { label = H.text "Click me"
                        , onClick = logAction ""
                        }
                    ]
              )
            , ( "buttons as links"
              , UI.hSpacer
                    [ W.primaryButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , W.dangerButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , W.confirmButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , W.outlinedButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    , W.invisibleButtonLink []
                        { label = H.text "Click me"
                        , href = "logAction/#"
                        }
                    ]
              )
            ]
