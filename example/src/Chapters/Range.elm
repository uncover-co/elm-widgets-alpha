module Chapters.Range exposing (chapter_, init)

import ElmBook.Actions exposing (logActionWith, updateStateWith)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList, renderStatefulComponent, renderStatefulComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


type alias Model =
    { default : Float
    , customColor : Float
    }


init : Model
init =
    { default = 5
    , customColor = 5
    }


chapter_ : Chapter { m | range : Model }
chapter_ =
    chapter "Range"
        |> renderStatefulComponentList
            [ ( "Default"
              , \{ range } ->
                    W.rangeInput []
                        { min = 0
                        , max = 10
                        , step = 1
                        , value = range.default
                        , onInput =
                            updateStateWith
                                (\v model ->
                                    let
                                        range_ =
                                            model.range
                                    in
                                    { model | range = { range_ | default = v } }
                                )
                        }
              )
            , ( "Disabled"
              , \_ ->
                    W.rangeInput [ WA.disabled True ]
                        { min = 0
                        , max = 10
                        , step = 1
                        , value = 5
                        , onInput = logActionWith String.fromFloat "onInput"
                        }
              )
            , ( "Read Only"
              , \_ ->
                    W.rangeInput [ WA.readOnly True ]
                        { min = 0
                        , max = 10
                        , step = 1
                        , value = 5
                        , onInput = logActionWith String.fromFloat "onInput"
                        }
              )
            , ( "Custom Color"
              , \{ range } ->
                    W.rangeInput [ WA.color "red" ]
                        { min = 0
                        , max = 10
                        , step = 1
                        , value = range.customColor
                        , onInput =
                            updateStateWith
                                (\v model ->
                                    let
                                        range_ =
                                            model.range
                                    in
                                    { model | range = { range_ | customColor = v } }
                                )
                        }
              )
            ]
