module ElmWidgets exposing
    ( globalStyles
    , primaryButton, primaryButtonLink, PrimaryButtonAttributes
    , dangerButton, dangerButtonLink, confirmButton, confirmButtonLink, StatusButtonAttributes
    , outlinedButton, outlinedButtonLink, OutlinedButtonAttributes
    , invisibleButton, invisibleButtonLink, InvisibleButtonAttributes
    , dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes
    , checkbox, CheckboxAttributes
    , radioButtons, RadioButtonsAttributes
    , select, selectWithGroups, SelectAttributes
    )

{-|


# Setup

@docs globalStyles


# Buttons


### Primary Button

@docs primaryButton, primaryButtonLink, PrimaryButtonAttributes


### Status Buttons

@docs dangerButton, dangerButtonLink, confirmButton, confirmButtonLink, StatusButtonAttributes


### Outlined Button

@docs outlinedButton, outlinedButtonLink, OutlinedButtonAttributes


### Invisible Button

@docs invisibleButton, invisibleButtonLink, InvisibleButtonAttributes


# Input

@docs dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes


# Checkbox

@docs checkbox, CheckboxAttributes


# Radio

@docs radioButtons, RadioButtonsAttributes


# Select

@docs select, selectWithGroups, SelectAttributes

-}

import Dict
import ElmWidgets.Styles
import Html as H exposing (Html, optgroup)
import Html.Attributes as HA
import Html.Events as HE



-- Helpers


{-| Setup all styles needed for ElmWidgets.
-}
globalStyles : Html msg
globalStyles =
    ElmWidgets.Styles.globalStyles


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


maybeAttr : (a -> H.Attribute msg) -> Maybe a -> H.Attribute msg
maybeAttr fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (HA.class "")


applyAttrs : a -> List (a -> a) -> a
applyAttrs defaults fns =
    List.foldl (\fn a -> fn a) defaults fns


fillWidth : Bool -> String
fillWidth fill =
    if fill then
        "100%"

    else
        "auto"



-- Primary Button


{-| -}
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
        , ( "width", fillWidth attrs.fill )
        ]
    ]


{-| -}
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


{-| -}
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


{-| -}
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
    , HA.style "width" (fillWidth attrs.fill)
    ]


{-| -}
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


{-| -}
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
    , HA.style "width" (fillWidth attrs.fill)
    ]


{-| -}
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


{-| -}
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


{-| -}
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
        , ( "width", fillWidth attrs.fill )
        ]
    ]


{-| -}
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


{-| -}
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


{-| -}
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
            , ( "width", fillWidth attrs.fill )
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


{-| -}
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


{-| -}
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



-- Select


{-| -}
type alias SelectAttributes =
    { placeholder : Maybe String
    , disabled : Bool
    }


selectDefaults : SelectAttributes
selectDefaults =
    { placeholder = Nothing
    , disabled = False
    }


{-| -}
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
        [ HA.class "ew ew-input ew-select"
        , HA.classList [ ( "ew-is-empty", props.value == Nothing ) ]
        , HA.disabled attrs.disabled
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


{-| -}
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



-- Input


{-| -}
type alias InputAttributes msg =
    { disabled : Bool
    , required : Bool
    , pattern : Maybe String
    , placeholder : Maybe String
    , htmlAttrs : List (H.Attribute msg)
    }


inputDefaults : InputAttributes msg
inputDefaults =
    { disabled = False
    , required = False
    , pattern = Nothing
    , placeholder = Nothing
    , htmlAttrs = []
    }


input_ :
    String
    -> List (InputAttributes msg -> InputAttributes msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> Html msg
input_ type_ attrs_ props =
    let
        attrs =
            applyAttrs inputDefaults attrs_
    in
    H.input
        (attrs.htmlAttrs
            ++ [ HA.class "ew ew-input ew-focusable"
               , HA.type_ type_
               , HA.disabled attrs.disabled
               , HA.value props.value
               , HE.onInput props.onInput
               , maybeAttr HA.placeholder attrs.placeholder
               , maybeAttr HA.pattern attrs.pattern
               ]
        )
        []


{-| -}
textInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
textInput =
    input_ "text"


{-| -}
passwordInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
passwordInput =
    input_ "password"


{-| -}
numberInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
numberInput =
    input_ "number"


{-| -}
dateInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
dateInput =
    input_ "date"


{-| -}
timeInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
timeInput =
    input_ "time"


{-| -}
datetimeInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
datetimeInput =
    input_ "datetime-local"


{-| -}
emailInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
emailInput =
    input_ "email"


{-| -}
searchInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
searchInput =
    input_ "search"


{-| -}
telephoneInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
telephoneInput =
    input_ "tel"


{-| -}
urlInput : List (InputAttributes msg -> InputAttributes msg) -> { onInput : String -> msg, value : String } -> Html msg
urlInput =
    input_ "url"



-- Checkbox


{-| -}
type alias CheckboxAttributes =
    { color : String
    , disabled : Bool
    }


checkboxDefaults : CheckboxAttributes
checkboxDefaults =
    { color = "var(--uc-ts-btn-background)"
    , disabled = False
    }


{-| -}
checkbox :
    List (CheckboxAttributes -> CheckboxAttributes)
    -> { value : Bool, onInput : Bool -> msg }
    -> Html msg
checkbox attrs_ props =
    let
        attrs =
            applyAttrs checkboxDefaults attrs_
    in
    H.div [ HA.class "ew ew-checkbox" ]
        [ H.input
            [ HA.class "ew ew-focusable ew-checkbox-input"
            , styles [ ( "--color", attrs.color ) ]
            , HA.type_ "checkbox"
            , HA.checked props.value
            , HA.disabled attrs.disabled
            , HE.onCheck props.onInput
            ]
            []
        ]



-- Radio


{-| -}
type alias RadioButtonsAttributes =
    { color : String
    , disabled : Bool
    , vertical : Bool
    }


radioButtonsDefaults : RadioButtonsAttributes
radioButtonsDefaults =
    { color = "var(--uc-ts-btn-background"
    , disabled = False
    , vertical = False
    }


{-| -}
radioButtons :
    List (RadioButtonsAttributes -> RadioButtonsAttributes)
    ->
        { name : String
        , value : Maybe a
        , options : List a
        , toValue : a -> String
        , toLabel : a -> String
        , onInput : a -> msg
        }
    -> Html msg
radioButtons attrs_ props =
    let
        attrs =
            applyAttrs radioButtonsDefaults attrs_
    in
    H.div
        [ HA.class "ew ew-radio-buttons"
        , HA.classList [ ( "m-vertical", attrs.vertical ), ( "is-disabled", attrs.disabled ) ]
        , styles [ ( "--color", attrs.color ) ]
        ]
        (props.options
            |> List.map
                (\a ->
                    H.label
                        [ HA.name props.name
                        , HA.class "ew ew-radio-buttons--item"
                        ]
                        [ H.input
                            [ HA.class "ew ew-focusable ew-radio-buttons--item-input"
                            , HA.type_ "radio"
                            , HA.name props.name
                            , HA.value (props.toValue a)
                            , HA.checked (Just a == props.value)
                            , HA.disabled attrs.disabled
                            , HE.onCheck (\_ -> props.onInput a)
                            ]
                            []
                        , H.span
                            [ HA.class "ew ew-radio-buttons--item-label"
                            ]
                            [ H.text (props.toLabel a) ]
                        ]
                )
        )
