module Chapters.Form.InputInt exposing (..)

import ElmBook.Actions exposing (updateState)
import ElmBook.Chapter exposing (Chapter, chapter, renderStatefulComponentList)
import Html as H
import W.InputInt


type alias Model =
    ( Int, String )


init : Model
init =
    ( 4, "4" )


chapter_ : Chapter { x | inputInt : Model }
chapter_ =
    chapter "Input Int"
        |> renderStatefulComponentList
            [ ( "Int"
              , \{ inputInt } ->
                    H.div []
                        [ W.InputInt.view
                            [ W.InputInt.placeholder "Type something…"
                            , W.InputInt.mask (\s -> s ++ s)
                            ]
                            { value = Tuple.second inputInt
                            , onInput =
                                \v vv ->
                                    updateState
                                        (\model ->
                                            { model | inputInt = (v, vv) }
                                        )
                            }
                        ]
              )
            ]
