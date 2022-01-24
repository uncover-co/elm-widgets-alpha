module Chapters.Field exposing (chapter_)

import ElmBook.Actions exposing (logActionWithBool, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA
import Html as H


chapter_ : Chapter x
chapter_ =
    chapter "Field"
        |> renderComponentList
            [ ( "Single"
              , W.field []
                    { label = H.text "Label"
                    , input =
                        W.textInput
                            [ WA.placeholder "…" ]
                            { value = ""
                            , onInput = logActionWithString "onInput"
                            }
                    }
              )
            , ( "Group + Status"
              , H.div []
                    [ W.field []
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                [ WA.placeholder "…" ]
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field [ WA.hint "Try writing some text here." ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                [ WA.disabled True ]
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        , WA.warning "You know better than this."
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.hint "Try writing some text here."
                        , WA.success "Pretty good text you wrote there!"
                        , WA.warning "You know better than this."
                        , WA.danger "You're in trouble now…"
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    ]
              )
            , ( "Right aligned"
              , H.div []
                    [ W.field
                        [ WA.alignRight True
                        ]
                        { label = H.text "Label"
                        , input =
                            W.textInput
                                []
                                { value = ""
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    , W.field
                        [ WA.alignRight True
                        , WA.footer (H.text "Some description")
                        , WA.warning "You know better than this."
                        ]
                        { label = H.text "Label"
                        , input =
                            W.checkbox
                                []
                                { value = True
                                , onInput = logActionWithBool "onInput"
                                }
                        }
                    , W.field
                        [ WA.alignRight True
                        , WA.footer (H.text "Some description")
                        , WA.success "You did it!"
                        ]
                        { label = H.text "Label"
                        , input =
                            W.radioButtons
                                [ WA.vertical True ]
                                { value = "Something"
                                , options = [ "Something", "In the way", "She moves", "Attracts me" ]
                                , toLabel = identity
                                , toValue = identity
                                , onInput = logActionWithString "onInput"
                                }
                        }
                    ]
              )
            ]
