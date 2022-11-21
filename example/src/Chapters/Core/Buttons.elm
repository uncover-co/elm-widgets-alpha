module Chapters.Core.Buttons exposing (chapter_)

import ElmBook.Actions exposing (logAction)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import Html as H
import UI
import W.Button


chapter_ : Chapter x
chapter_ =
    chapter "Button"
        |> renderComponentList
            ([ [ ( "Default", [] )
               , ( "Primary", [ W.Button.primary ] )
               , ( "Secondary", [ W.Button.secondary ] )
               , ( "Success", [ W.Button.success ] )
               , ( "Warning", [ W.Button.warning ] )
               , ( "Danger", [ W.Button.danger ] )
               , ( "Custom"
                 , [ W.Button.theme
                        { background = "#ef67ef"
                        , foreground = "#ef67ef"
                        , aux = "#ffffff"
                        }
                   ]
                 )
               ]
                |> List.map
                    (\( name, attrs ) ->
                        ( name
                        , UI.vSpacer
                            [ UI.hSpacer
                                [ W.Button.view attrs
                                    { label = [ H.text "Button" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.outlined :: attrs)
                                    { label = [ H.text "Outlined" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.invisible :: attrs)
                                    { label = [ H.text "Invisible" ]
                                    , onClick = logAction ""
                                    }
                                ]
                            , UI.hSpacer
                                [ W.Button.view
                                    (W.Button.disabled True :: attrs)
                                    { label = [ H.text "Button" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.outlined :: W.Button.disabled True :: attrs)
                                    { label = [ H.text "Outlined" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.invisible :: W.Button.disabled True :: attrs)
                                    { label = [ H.text "Invisible" ]
                                    , onClick = logAction ""
                                    }
                                ]
                            , UI.hSpacer
                                [ W.Button.view (W.Button.rounded :: attrs)
                                    { label = [ H.text "Button" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.outlined :: W.Button.rounded :: attrs)
                                    { label = [ H.text "Outlined" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.invisible :: W.Button.rounded :: attrs)
                                    { label = [ H.text "Invisible" ]
                                    , onClick = logAction ""
                                    }
                                ]
                            , UI.hSpacer
                                [ W.Button.view (W.Button.large :: attrs)
                                    { label = [ H.text "Button" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.outlined :: W.Button.large :: attrs)
                                    { label = [ H.text "Outlined" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.invisible :: W.Button.large :: attrs)
                                    { label = [ H.text "Invisible" ]
                                    , onClick = logAction ""
                                    }
                                ]
                            , UI.hSpacer
                                [ W.Button.view (W.Button.small :: attrs)
                                    { label = [ H.text "Button" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.outlined :: W.Button.small :: attrs)
                                    { label = [ H.text "Outlined" ]
                                    , onClick = logAction ""
                                    }
                                , W.Button.view
                                    (W.Button.invisible :: W.Button.small :: attrs)
                                    { label = [ H.text "Invisible" ]
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
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.outlined
                            ]
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.invisible
                            ]
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        ]
                    , UI.hSpacer
                        [ W.Button.viewLink
                            [ W.Button.disabled True
                            ]
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.outlined
                            , W.Button.disabled True
                            ]
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        , W.Button.viewLink
                            [ W.Button.invisible
                            , W.Button.disabled True
                            ]
                            { label = [ H.text "link" ]
                            , href = "/logAction/#"
                            }
                        ]
                    ]
                 )
               , ( "Full width"
                 , W.Button.view
                    [ W.Button.full ]
                    { label = [ H.text "button" ]
                    , onClick = logAction ""
                    }
                 )
               , ( "Icons"
                 , UI.vSpacer
                    [ UI.hSpacer
                        [ W.Button.view [ W.Button.small, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.small, W.Button.rounded, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.small, W.Button.invisible, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        ]
                    , UI.hSpacer
                        [ W.Button.view [ W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.rounded, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.invisible, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        ]
                    , UI.hSpacer
                        [ W.Button.view [ W.Button.large, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.large, W.Button.rounded, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        , W.Button.view [ W.Button.large, W.Button.invisible, W.Button.icon ]
                            { label = [ UI.viewIcon ]
                            , onClick = logAction ""
                            }
                        ]
                    ]
                 )
               ]
             ]
                |> List.concat
            )
