module ElmWidgets exposing
    ( confirmButton
    , confirmButtonLink
    , dangerButton
    , dangerButtonLink
    , iconButton
    , invisibleButton
    , invisibleButtonLink
    , outlinedButton
    , outlinedButtonLink
    , primaryButton
    , primaryButtonLink
    , select
    , selectWithGroups
    )

import Dict
import Html as H exposing (Html, optgroup)
import Html.Attributes as HA
import Html.Events as HE



-- Helpers


styles : List ( String, String ) -> H.Attribute msg
styles xs =
    xs
        |> List.map (\( k, v ) -> k ++ ":" ++ v)
        |> String.join ";"
        |> HA.attribute "style"


stylesList : List ( String, String, Bool ) -> H.Attribute msg
stylesList xs =
    xs
        |> List.filterMap
            (\( k, v, f ) ->
                if f then
                    Just (k ++ ":" ++ v)

                else
                    Nothing
            )
        |> String.join ";"
        |> HA.attribute "style"


applyAttrs : a -> List (a -> a) -> a
applyAttrs defaults fns =
    List.foldl (\fn a -> fn a) defaults fns



-- Button Helpers


buttonWidth : Bool -> String
buttonWidth fill =
    if fill then
        "100%"

    else
        "auto"



-- Button as Links


textButtonLink : Html msg
textButtonLink =
    H.button [] []


iconButtonLink : Html msg
iconButtonLink =
    H.button [] []



-- Primary Button


type alias PrimaryButtonAttributes =
    { color : String
    , background : String
    , shadow : String
    , disabled : Bool
    , fill : Bool
    }


primaryButtonDefaults : PrimaryButtonAttributes
primaryButtonDefaults =
    { color = "var(--uc-ts-btn-color)"
    , background = "var(--uc-ts-btn-background)"
    , shadow = "var(--uc-ts-btn-shadow)"
    , disabled = False
    , fill = False
    }


primaryButtonAttrs : List (PrimaryButtonAttributes -> PrimaryButtonAttributes) -> List (H.Attribute msg)
primaryButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs primaryButtonDefaults attrs_
    in
    [ HA.disabled attrs.disabled
    , HA.class "ew ew-focusable ew-btn ew-m-primary"
    , styles
        [ ( "--color", attrs.color )
        , ( "--background", attrs.background )
        , ( "--shadow", attrs.shadow )
        , ( "width", buttonWidth attrs.fill )
        ]
    ]


primaryButton :
    List (PrimaryButtonAttributes -> PrimaryButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
primaryButton attrs props =
    H.button
        (HE.onClick props.onClick :: primaryButtonAttrs attrs)
        [ props.label ]


primaryButtonLink :
    List (PrimaryButtonAttributes -> PrimaryButtonAttributes)
    ->
        { label : Html msg
        , href : String
        }
    -> Html msg
primaryButtonLink attrs props =
    H.a
        (HA.href props.href :: primaryButtonAttrs attrs)
        [ props.label ]



-- Status Buttons


type alias StatusButtonAttributes =
    { disabled : Bool
    , fill : Bool
    }


statusButtonDefaults : StatusButtonAttributes
statusButtonDefaults =
    { disabled = False
    , fill = False
    }


dangerButtonAttrs : List (StatusButtonAttributes -> StatusButtonAttributes) -> List (H.Attribute msg)
dangerButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs statusButtonDefaults attrs_
    in
    [ HA.disabled attrs.disabled
    , HA.class "ew ew-focusable ew-btn ew-m-primary ew-is-danger"
    , HA.style "width" (buttonWidth attrs.fill)
    ]


dangerButton :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
dangerButton attrs props =
    H.button
        (HE.onClick props.onClick :: dangerButtonAttrs attrs)
        [ props.label ]


dangerButtonLink :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , href : String
        }
    -> Html msg
dangerButtonLink attrs props =
    H.a
        (HA.href props.href :: dangerButtonAttrs attrs)
        [ props.label ]


confirmButtonAttrs : List (StatusButtonAttributes -> StatusButtonAttributes) -> List (H.Attribute msg)
confirmButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs statusButtonDefaults attrs_
    in
    [ HA.disabled attrs.disabled
    , HA.class "ew ew-focusable ew-btn ew-m-primary ew-is-confirm"
    , HA.style "width" (buttonWidth attrs.fill)
    ]


confirmButton :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
confirmButton attrs props =
    H.button
        (HE.onClick props.onClick :: confirmButtonAttrs attrs)
        [ props.label ]


confirmButtonLink :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , href : String
        }
    -> Html msg
confirmButtonLink attrs props =
    H.a
        (HA.href props.href :: confirmButtonAttrs attrs)
        [ props.label ]



-- Outline Button


type alias OutlinedButtonAttributes =
    { color : String
    , shadow : String
    , disabled : Bool
    , fill : Bool
    }


outlinedButtonDefaults : OutlinedButtonAttributes
outlinedButtonDefaults =
    { color = "var(--uc-ts-color)"
    , shadow = "var(--uc-ts-color-faded)"
    , disabled = False
    , fill = False
    }


outlinedButtonAttrs : List (OutlinedButtonAttributes -> OutlinedButtonAttributes) -> List (H.Attribute msg)
outlinedButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs outlinedButtonDefaults attrs_
    in
    [ HA.disabled attrs.disabled
    , HA.class "ew ew-focusable ew-btn ew-m-outlined"
    , styles
        [ ( "--color", attrs.color )
        , ( "--shadow", attrs.shadow )
        , ( "width", buttonWidth attrs.fill )
        ]
    ]


outlinedButton :
    List (OutlinedButtonAttributes -> OutlinedButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
outlinedButton attrs props =
    H.button
        (HE.onClick props.onClick :: outlinedButtonAttrs attrs)
        [ props.label ]


outlinedButtonLink :
    List (OutlinedButtonAttributes -> OutlinedButtonAttributes)
    ->
        { label : Html msg
        , href : String
        }
    -> Html msg
outlinedButtonLink attrs props =
    H.a
        (HA.href props.href :: outlinedButtonAttrs attrs)
        [ props.label ]



-- Invisible Button


type alias InvisibleButtonAttributes =
    { color : String
    , background : String
    , disabled : Bool
    , fill : Bool
    }


invisibleButtonDefaults : InvisibleButtonAttributes
invisibleButtonDefaults =
    { color = "var(--uc-ts-color)"
    , background = "var(--uc-ts-background-faded)"
    , disabled = False
    , fill = False
    }


invisibleButtonAttrs :
    List (InvisibleButtonAttributes -> InvisibleButtonAttributes)
    -> Html msg
    -> ( List (H.Attribute msg), List (Html msg) )
invisibleButtonAttrs attrs_ label =
    let
        attrs =
            applyAttrs invisibleButtonDefaults attrs_
    in
    ( [ HA.style "color" attrs.color
      , HA.disabled attrs.disabled
      , HA.class "ew ew-focusable ew-btn ew-m-invisible"
      , styles
            [ ( "--color", attrs.color )
            , ( "--background", attrs.background )
            , ( "width", buttonWidth attrs.fill )
            ]
      ]
    , [ H.div
            [ HA.class "ew ew-bg"
            , HA.style "background-color" attrs.background
            ]
            []
      , H.span
            [ HA.class "ew ew-relative"
            ]
            [ label ]
      ]
    )


invisibleButton :
    List (InvisibleButtonAttributes -> InvisibleButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
invisibleButton attrs_ props =
    let
        ( attrs, children ) =
            invisibleButtonAttrs attrs_ props.label
    in
    H.button
        (HE.onClick props.onClick :: attrs)
        children


invisibleButtonLink :
    List (InvisibleButtonAttributes -> InvisibleButtonAttributes)
    ->
        { label : Html msg
        , href : String
        }
    -> Html msg
invisibleButtonLink attrs_ props =
    let
        ( attrs, children ) =
            invisibleButtonAttrs attrs_ props.label
    in
    H.a
        (HA.href props.href :: attrs)
        children


iconButton : Html msg
iconButton =
    H.button [] []



-- Select


type alias SelectAttributes =
    { placeholder : Maybe String }


selectDefaults : SelectAttributes
selectDefaults =
    { placeholder = Nothing
    }


selectWithGroups :
    List (SelectAttributes -> SelectAttributes)
    ->
        { value : Maybe a
        , options : List ( String, a )
        , optionGroups : List ( String, List ( String, a ) )
        , toString : a -> String
        , onInput : Maybe a -> msg
        }
    -> H.Html msg
selectWithGroups attrs_ props =
    let
        attrs =
            applyAttrs selectDefaults attrs_

        options =
            case attrs.placeholder of
                Nothing ->
                    props.options
                        |> List.map (Tuple.mapSecond Just)

                Just placeholder_ ->
                    ( placeholder_, Nothing )
                        :: (props.options
                                |> List.map (Tuple.mapSecond Just)
                           )

        values =
            props.optionGroups
                |> List.concatMap Tuple.second
                |> List.append props.options
                |> Dict.fromList
    in
    H.select
        [ HA.class "ew ew-focusable ew-select"
        , HA.classList [ ( "ew-is-empty", props.value == Nothing ) ]
        , HA.placeholder "Select"
        , HE.onInput
            (\s ->
                Dict.get s values
                    |> props.onInput
            )
        ]
        (List.concat
            [ options
                |> List.map
                    (\( k, v ) ->
                        case v of
                            Just v_ ->
                                H.option
                                    [ HA.selected (v == props.value)
                                    , HA.value k
                                    ]
                                    [ H.text (props.toString v_) ]

                            Nothing ->
                                H.option
                                    [ HA.selected (v == props.value)
                                    , HA.value ""
                                    , HA.disabled True
                                    ]
                                    [ H.text k ]
                    )
            , props.optionGroups
                |> List.map
                    (\( l, options_ ) ->
                        optgroup [ HA.attribute "label" l ]
                            (options_
                                |> List.map
                                    (\( k, v ) ->
                                        H.option
                                            [ HA.selected (Just v == props.value)
                                            , HA.value k
                                            ]
                                            [ H.text (props.toString v) ]
                                    )
                            )
                    )
            ]
        )


select :
    List (SelectAttributes -> SelectAttributes)
    ->
        { value : Maybe a
        , options : List ( String, a )
        , toString : a -> String
        , onInput : Maybe a -> msg
        }
    -> H.Html msg
select attrs_ props =
    selectWithGroups attrs_
        { value = props.value
        , options = props.options
        , optionGroups = []
        , toString = props.toString
        , onInput = props.onInput
        }
