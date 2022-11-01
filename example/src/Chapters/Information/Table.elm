module Chapters.Information.Table exposing (..)

import ElmBook.Actions exposing (logActionWithString, logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import Html.Attributes as HA
import W.Table


data :
    List
        { age : Int
        , score : Float
        , ready : Bool
        , picture : String
        , name : String
        }
data =
    [ { name = "Georges Alphonse Prado Boris"
      , age = 33
      , score = 85
      , ready = False
      , picture = "https://picsum.photos/100"
      }
    , { name = "Janine Bonfadini"
      , age = 35
      , score = 904.6
      , ready = True
      , picture = "https://picsum.photos/120"
      }
    ]
        |> List.repeat 10
        |> List.concat


chapter_ : Chapter x
chapter_ =
    chapter "Table"
        |> renderComponentList
            [ ( "Default"
              , W.Table.view
                    [ W.Table.onClick (logActionWithString "onClick" << .name)
                    , W.Table.onMouseEnter (logActionWithString "onMouseEnter" << .name)
                    , W.Table.onMouseLeave (logAction "onMouseLeave")
                    , W.Table.highlight (.age >> (==) 35)
                    ]
                    [ W.Table.html "Image" .picture 
                        [ W.Table.size 72 ] (\s -> H.img [ HA.src s, HA.height 60 ] [])
                    , W.Table.string "Name" .name []
                    , W.Table.int "Age" .age []
                    , W.Table.float "Score" .score []
                    , W.Table.bool "Ready" .ready []
                    ]
                    data
              )
            , ( "Groups"
              , W.Table.view
                    [ W.Table.onClick (logActionWithString "onClick" << .name)
                    , W.Table.groups [ .name, .age >> String.fromInt ]
                    , W.Table.htmlAttrs [ HA.style "max-height" "400px" ]
                    ]
                    [ W.Table.html "Image" .picture 
                        [ W.Table.size 72 ]
                        (\s -> H.img [ HA.src s, HA.height 60 ] [])
                    , W.Table.string "Name" .name []
                    , W.Table.int "Age" .age []
                    , W.Table.float "Score" .score []
                    , W.Table.bool "Ready" .ready []
                    ]
                    data
              )
            ]
