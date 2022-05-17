module Chapters.Information.Popover exposing (chapter_)

import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import UI
import W.Button
import W.Popover


children :
    { content : List (H.Html msg)
    , children : List (H.Html msg)
    }
children =
    { content =
        [ H.text "Boo!" ]
    , children =
        [ W.Button.viewLink []
            { href = "/logAction/"
            , label = "Click me"
            }
        ]
    }


chapter_ : Chapter x
chapter_ =
    chapter "Popover"
        |> renderComponentList
            ([ ( "Default", [] )
             , ( "Top", [ W.Popover.top ] )
             , ( "Left", [ W.Popover.left ] )
             , ( "Right", [ W.Popover.right ] )
             , ( "Over", [ W.Popover.over ] )
             ]
                |> List.map
                    (\( label, attrs ) ->
                        ( label
                        , UI.hSpacer
                            [ W.Popover.view attrs children
                            , W.Popover.view (W.Popover.offset 4 :: attrs) children
                            , W.Popover.view (W.Popover.full True :: attrs) children
                            ]
                        )
                    )
            )
