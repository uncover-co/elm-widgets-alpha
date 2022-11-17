module Chapters.Form.InputFloat exposing (..)

import ElmBook.Actions exposing (updateState)
import ElmBook.Chapter exposing (Chapter, chapter, renderStatefulComponentList)
import Html as H
import W.InputFloat


type alias Model =
    W.InputFloat.Value


init : Model
init =
    W.InputFloat.init (Just 1.2)


chapter_ : Chapter { x | inputFloat : Model }
chapter_ =
    chapter "Input Float"
        |> renderStatefulComponentList
            [ ( "Float"
              , \{ inputFloat } ->
                    H.div []
                        [ W.InputFloat.view
                            [ W.InputFloat.placeholder "Type something…"
                            ]
                            { value = inputFloat
                            , onInput =
                                \v ->
                                    updateState
                                        (\model ->
                                            { model | inputFloat = v }
                                        )
                            }
                        ]
              )
            ]
