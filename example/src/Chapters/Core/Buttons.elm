module Chapters.Core.Buttons exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ThemeSpec
import UI
import W.Button


chapter_ : Chapter x
chapter_ =
    chapter "Buttons"
        |> renderComponentList
            ([ [ ( "Default", W.Button.theme ThemeSpec.base )
               , ( "Accent", W.Button.accent )
               , ( "Success", W.Button.success )
               , ( "Warning", W.Button.warning )
               , ( "Danger", W.Button.danger )
               , ( "Custom"
                 , W.Button.theme
                    { base = "#ef67ef"
                    , light = "#f6e1f6"
                    , lighter = "#ffedff"
                    , shadow = "#ef67ef"
                    }
                 )
               ]
                |> List.map
                    (\( name, theme_ ) ->
                        ( name
                        , UI.vSpacer
                            [ UI.hSpacer
                                [ W.Button.view
                                    [ theme_ ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    [ theme_
                                    , W.Button.outlined
                                    ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    [ theme_
                                    , W.Button.invisible
                                    ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                ]
                            , UI.hSpacer
                                [ W.Button.view
                                    [ theme_
                                    , W.Button.disabled True
                                    ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    [ theme_
                                    , W.Button.outlined
                                    , W.Button.disabled True
                                    ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    [ theme_
                                    , W.Button.invisible
                                    , W.Button.disabled True
                                    ]
                                    { label = "button"
                                    , onClick = logAction ""
                                    }
                                ]
                            ]
                        )
                    )
             , [ ( "As Link"
                 , UI.vSpacer
                    [ UI.hSpacer
                        [ W.Button.viewLink
                            []
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.outlined
                            ]
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.invisible
                            ]
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        ]
                    , UI.hSpacer
                        [ W.Button.viewLink
                            [ W.Button.disabled True
                            ]
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.outlined
                            , W.Button.disabled True
                            ]
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.invisible
                            , W.Button.disabled True
                            ]
                            { label = "link"
                            , href = "/logAction/#"
                            }
                        ]
                    ]
                 )
               , ( "Full width"
                 , W.Button.view
                    [ W.Button.fill ]
                    { label = "button"
                    , onClick = logAction ""
                    }
                 )
               ]
             ]
                |> List.concat
            )
