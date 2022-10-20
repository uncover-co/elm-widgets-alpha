module Chapters.Core.Divider exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import W.Divider


chapter_ : Chapter x
chapter_ =
    chapter "Divider"
        |> renderComponentList
            [ ( "Horizontal"
              , H.div []
                    [ W.Divider.view [] []
                    , W.Divider.view [] [ H.text "or" ]
                    ]
              )
            , ( "Vertical"
              , H.div
                    [ HA.style "height" "40px"
                    , HA.style "display" "flex"
                    , HA.style "justify-content" "space-between"
                    ]
                    [ W.Divider.view [ W.Divider.vertical ] []
                    , W.Divider.view [ W.Divider.vertical ] []
                    , W.Divider.view [ W.Divider.vertical ] []
                    , W.Divider.view [ W.Divider.vertical ] [ H.text "or" ]
                    ]
              )
            ]
