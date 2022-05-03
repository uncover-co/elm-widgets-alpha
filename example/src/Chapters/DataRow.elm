module Chapters.DataRow exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA
import Html as H
import Html.Attributes as HA
import W.Button
import W.Loading


chapter_ : Chapter x
chapter_ =
    chapter "DataRow"
        |> renderComponentList
            [ ( "Simple"
              , W.dataRow []
                    { label = H.text "Label"
                    , actions = []
                    }
              )
            , ( "As Button"
              , W.dataRow [ WA.onClick (logAction "onClick") ]
                    { label = H.text "Label"
                    , actions = []
                    }
              )
            , ( "As Link"
              , W.dataRow [ WA.href "/logAction/#" ]
                    { label = H.text "Label"
                    , actions = []
                    }
              )
            , ( "With Actions"
              , W.dataRow [ WA.href "/logAction/#" ]
                    { label = H.text "Label"
                    , actions =
                        [ W.Button.view [ W.Button.accent ]
                            { label = "Click me"
                            , onClick = logAction "onClick Action"
                            }
                        ]
                    }
              )
            , ( "With Actions + Footer"
              , W.dataRow
                    [ WA.href "/logAction/#"
                    , WA.footer (H.text "user@email.com")
                    ]
                    { label = H.text "Label"
                    , actions =
                        [ W.Button.view [ W.Button.accent ]
                            { label = "Click me"
                            , onClick = logAction "onClick Action"
                            }
                        ]
                    }
              )
            , ( "With Actions + Header + Footer"
              , W.dataRow
                    [ WA.href "/logAction/#"
                    , WA.header (H.text "Admin")
                    , WA.footer (H.text "user@email.com")
                    ]
                    { label = H.text "Label"
                    , actions =
                        [ W.Button.view [ W.Button.accent ]
                            { label = "Click me"
                            , onClick = logAction "onClick Action"
                            }
                        ]
                    }
              )
            , ( "With Actions + Header + Footer + Left"
              , W.dataRow
                    [ WA.href "/logAction/#"
                    , WA.header (H.text "Admin")
                    , WA.footer (H.text "user@email.com")
                    , WA.left (W.Loading.ripples [])
                    ]
                    { label = H.text "Label"
                    , actions =
                        [ W.Button.view [ W.Button.accent ]
                            { label = "Click me"
                            , onClick = logAction "onClick Action"
                            }
                        ]
                    }
              )
            , ( "With Actions + Header + Footer + Left (Other)"
              , W.dataRow
                    [ WA.href "/logAction/#"
                    , WA.header (H.text "Admin")
                    , WA.footer (H.text "user@email.com")
                    , WA.left
                        (H.div
                            [ HA.style "background" "#f5f5f5"
                            , HA.style "border-radius" "50%"
                            , HA.style "border" "3px solid #dadada"
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            ]
                            []
                        )
                    ]
                    { label = H.text "Label"
                    , actions =
                        [ W.Button.view [ W.Button.accent ]
                            { label = "Click me"
                            , onClick = logAction "onClick Action"
                            }
                        ]
                    }
              )
            ]
