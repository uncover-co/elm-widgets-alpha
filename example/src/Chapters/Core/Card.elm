module Chapters.Core.Card exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import W.Card
import Theme


chapter_ : Chapter x
chapter_ =
    chapter "Card"
        |> renderComponentList
            [ ( "Default"
              , H.div [ HA.style "padding" "20px"
            , HA.style "background" Theme.baseBackground ] 
                [ W.Card.view [] [ H.text "Inside Card" ]
                ]
              )
            , ( "With Paddings"
              , W.Card.view
                    [ W.Card.extraRounded ]
                    [ H.text "Inside Card" ]
              )
            , ( "With Custom Background"
              , W.Card.view
                    [ W.Card.background "red" ]
                    [ H.text "Inside Card" ]
              )
            , ( "Without Shadow"
              , W.Card.view
                    [ W.Card.noShadow ]
                    [ H.text "Inside Card" ]
              )
            , ( "With Large Shadow"
              , W.Card.view
                    [ W.Card.largeShadow ]
                    [ H.text "Inside Card" ]
              )
            ]
