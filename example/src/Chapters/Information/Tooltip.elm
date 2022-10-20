module Chapters.Information.Tooltip exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import UI
import W.Tooltip


chapter_ : Chapter x
chapter_ =
    chapter "Tooltip"
        |> renderComponentList
            [ ( "Default"
              , UI.vSpacer
                    [ W.Tooltip.view [ W.Tooltip.alwaysVisible True ]
                        { tooltip = [ H.text "Tooltip!" ]
                        , children = [ H.text "Hello!" ]
                        }
                    , W.Tooltip.view []
                        { tooltip = [ H.text "Tooltip!" ]
                        , children = [ H.text "Hello!" ]
                        }
                    ]
              )
            ]
