module ElmWidgets exposing
    ( globalStyles
    , primaryButton, primaryButtonLink, PrimaryButtonAttributes
    , dangerButton, dangerButtonLink, confirmButton, confirmButtonLink, StatusButtonAttributes
    , outlinedButton, outlinedButtonLink, OutlinedButtonAttributes
    , invisibleButton, invisibleButtonLink, InvisibleButtonAttributes
    , field
    , dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes
    , checkbox, CheckboxAttributes
    , radioButtons, RadioButtonsAttributes
    , select, selectWithGroups, SelectAttributes
    , rangeInput
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


# Forms

@docs field


# Input

@docs dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes


# Checkbox

@docs checkbox, CheckboxAttributes


# Radio

@docs radioButtons, RadioButtonsAttributes


# Select

@docs select, selectWithGroups, SelectAttributes


# Range

@docs rangeInput

-}

import Dict exposing (Dict)
import ElmWidgets.Styles
import Html as H exposing (Html, optgroup)
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D



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
    { id : Maybe String
    , color : String
    , background : String
    , shadow : String
    , disabled : Bool
    , fill : Bool
    }


primaryButtonDefaults : PrimaryButtonAttributes
primaryButtonDefaults =
    { id = Nothing
    , color = "var(--tmspc-highlight-contrast)"
    , background = "var(--tmspc-highlight-base)"
    , shadow = "var(--tmspc-highlight-shadow)"
    , disabled = False
    , fill = False
    }


primaryButtonAttrs : List (PrimaryButtonAttributes -> PrimaryButtonAttributes) -> List (H.Attribute msg)
primaryButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs primaryButtonDefaults attrs_
    in
    [ maybeAttr HA.id attrs.id
    , HA.disabled attrs.disabled
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
    { id : Maybe String
    , disabled : Bool
    , fill : Bool
    }


statusButtonDefaults : StatusButtonAttributes
statusButtonDefaults =
    { id = Nothing
    , disabled = False
    , fill = False
    }


dangerButtonAttrs : List (StatusButtonAttributes -> StatusButtonAttributes) -> List (H.Attribute msg)
dangerButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs statusButtonDefaults attrs_
    in
    [ maybeAttr HA.id attrs.id
    , HA.disabled attrs.disabled
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
    { id : Maybe String
    , color : String
    , shadow : String
    , disabled : Bool
    , fill : Bool
    }


outlinedButtonDefaults : OutlinedButtonAttributes
outlinedButtonDefaults =
    { id = Nothing
    , color = "var(--tmspc-color-base)"
    , shadow = "var(--tmspc-color-shadow)"
    , disabled = False
    , fill = False
    }


outlinedButtonAttrs : List (OutlinedButtonAttributes -> OutlinedButtonAttributes) -> List (H.Attribute msg)
outlinedButtonAttrs attrs_ =
    let
        attrs =
            applyAttrs outlinedButtonDefaults attrs_
    in
    [ maybeAttr HA.id attrs.id
    , HA.disabled attrs.disabled
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
    { id : Maybe String
    , color : String
    , background : String
    , disabled : Bool
    , fill : Bool
    }


invisibleButtonDefaults : InvisibleButtonAttributes
invisibleButtonDefaults =
    { id = Nothing
    , color = "var(--tmspc-color-base)"
    , background = "var(--tmspc-color-tint)"
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
    ( [ maybeAttr HA.id attrs.id
      , HA.style "color" attrs.color
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



-- Form


type alias FieldAttributes msg =
    { id : Maybe String
    , footer : Maybe (Html msg)
    , alignRight : Bool
    , hint : Maybe String
    , warning : Maybe String
    , danger : Maybe String
    , success : Maybe String
    }


fieldDefaults : FieldAttributes msg
fieldDefaults =
    { id = Nothing
    , footer = Nothing
    , alignRight = False
    , hint = Nothing
    , warning = Nothing
    , danger = Nothing
    , success = Nothing
    }


{-| -}
field :
    List (FieldAttributes msg -> FieldAttributes msg)
    ->
        { label : H.Html msg
        , input : H.Html msg
        }
    -> H.Html msg
field attrs_ props =
    let
        attrs =
            applyAttrs fieldDefaults attrs_
    in
    H.section
        [ maybeAttr HA.id attrs.id
        , HA.class "ew ew-field"
        ]
        [ H.div
            [ HA.class "ew ew-field-main"
            , HA.classList [ ( "ew-m-align-right", attrs.alignRight ) ]
            ]
            [ H.div [ HA.class "ew ew-field-label-wrapper" ]
                [ H.h1 [ HA.class "ew ew-field-label" ] [ props.label ]
                , attrs.footer
                    |> Maybe.map (\f -> H.p [ HA.class "ew ew-field-label-footer" ] [ f ])
                    |> Maybe.withDefault (H.text "")
                ]
            , H.div [ HA.class "ew ew-field-input" ] [ props.input ]
            ]
        , case ( attrs.danger, attrs.warning, attrs.success ) of
            ( Just danger, _, _ ) ->
                H.p [ HA.class "ew ew-field-message ew-m-danger" ] [ H.text danger ]

            ( Nothing, Just warning, _ ) ->
                H.p [ HA.class "ew ew-field-message ew-m-warning" ] [ H.text warning ]

            ( Nothing, Nothing, Just success ) ->
                H.p [ HA.class "ew ew-field-message ew-m-success" ] [ H.text success ]

            ( Nothing, Nothing, Nothing ) ->
                case attrs.hint of
                    Just hint ->
                        H.p [ HA.class "ew ew-field-message" ] [ H.text hint ]

                    Nothing ->
                        H.text ""
        ]



-- Select


{-| -}
type alias SelectAttributes =
    { id : Maybe String
    , disabled : Bool
    }


selectDefaults : SelectAttributes
selectDefaults =
    { id = Nothing
    , disabled = False
    }


{-| -}
selectWithGroups :
    List (SelectAttributes -> SelectAttributes)
    ->
        { value : a
        , options : List a
        , optionGroups : List ( String, List a )
        , toValue : a -> String
        , toLabel : a -> String
        , onInput : a -> msg
        }
    -> H.Html msg
selectWithGroups attrs_ props =
    let
        attrs =
            applyAttrs selectDefaults attrs_

        values : Dict String a
        values =
            props.optionGroups
                |> List.concatMap Tuple.second
                |> List.append props.options
                |> List.map (\a -> ( props.toValue a, a ))
                |> Dict.fromList
    in
    H.div [ HA.class "ew ew-select-wrapper" ]
        [ H.select
            [ maybeAttr HA.id attrs.id
            , HA.class "ew ew-focusable ew-input ew-select"
            , HA.disabled attrs.disabled
            , HA.placeholder "Select"
            , HE.onInput
                (\s ->
                    Dict.get s values
                        |> Maybe.withDefault props.value
                        |> props.onInput
                )
            ]
            (List.concat
                [ props.options
                    |> List.map
                        (\a ->
                            H.option
                                [ HA.selected (a == props.value)
                                , HA.value (props.toValue a)
                                ]
                                [ H.text (props.toLabel a) ]
                        )
                , props.optionGroups
                    |> List.map
                        (\( l, options_ ) ->
                            optgroup [ HA.attribute "label" l ]
                                (options_
                                    |> List.map
                                        (\a ->
                                            H.option
                                                [ HA.selected (a == props.value)
                                                , HA.value (props.toValue a)
                                                ]
                                                [ H.text (props.toLabel a) ]
                                        )
                                )
                        )
                ]
            )
        , H.div [ HA.class "ew ew-select-icon" ] []
        ]


{-| -}
select :
    List (SelectAttributes -> SelectAttributes)
    ->
        { value : a
        , options : List a
        , toValue : a -> String
        , toLabel : a -> String
        , onInput : a -> msg
        }
    -> H.Html msg
select attrs_ props =
    selectWithGroups attrs_
        { value = props.value
        , options = props.options
        , optionGroups = []
        , toValue = props.toValue
        , toLabel = props.toLabel
        , onInput = props.onInput
        }



-- Input


{-| -}
type alias InputAttributes msg =
    { id : Maybe String
    , disabled : Bool
    , required : Bool
    , pattern : Maybe String
    , placeholder : Maybe String
    , htmlAttrs : List (H.Attribute msg)
    }


inputDefaults : InputAttributes msg
inputDefaults =
    { id = Nothing
    , disabled = False
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
            ++ [ maybeAttr HA.id attrs.id
               , HA.class "ew ew-input ew-focusable"
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
    { id : Maybe String
    , color : String
    , disabled : Bool
    }


checkboxDefaults : CheckboxAttributes
checkboxDefaults =
    { id = Nothing
    , color = "var(--tmspc-highlight-base)"
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
            [ maybeAttr HA.id attrs.id
            , HA.class "ew ew-focusable ew-checkbox-input"
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
    { id : Maybe String
    , color : String
    , disabled : Bool
    , vertical : Bool
    }


radioButtonsDefaults : RadioButtonsAttributes
radioButtonsDefaults =
    { id = Nothing
    , color = "var(--tmspc-highlight-base)"
    , disabled = False
    , vertical = False
    }


{-| -}
radioButtons :
    List (RadioButtonsAttributes -> RadioButtonsAttributes)
    ->
        { value : a
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

        name =
            case attrs.id of
                Just id ->
                    id

                Nothing ->
                    props.options
                        |> List.map props.toLabel
                        |> String.join "-"
    in
    H.div
        [ maybeAttr HA.id attrs.id
        , HA.class "ew ew-radio-buttons"
        , HA.classList [ ( "m-vertical", attrs.vertical ), ( "is-disabled", attrs.disabled ) ]
        , styles [ ( "--color", attrs.color ) ]
        ]
        (props.options
            |> List.map
                (\a ->
                    H.label
                        [ HA.name name
                        , HA.class "ew ew-radio-buttons--item"
                        ]
                        [ H.input
                            [ HA.class "ew ew-focusable ew-radio-buttons--item-input"
                            , HA.type_ "radio"
                            , HA.name name
                            , HA.value (props.toValue a)
                            , HA.checked (a == props.value)
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


{-| -}
type alias RangeAttributes =
    { id : Maybe String
    , disabled : Bool
    , color : String
    }


rangeDefaults : RangeAttributes
rangeDefaults =
    { id = Nothing
    , disabled = False
    , color = "var(--tmspc-highlight-base)"
    }


{-| -}
rangeInput :
    List (RangeAttributes -> RangeAttributes)
    ->
        { min : Float
        , max : Float
        , step : Float
        , value : Float
        , onInput : Float -> msg
        }
    -> H.Html msg
rangeInput attrs_ props =
    let
        attrs =
            applyAttrs rangeDefaults attrs_
    in
    H.input
        [ maybeAttr HA.id attrs.id
        , HA.class "ew ew-range"
        , HA.type_ "range"
        , HA.disabled attrs.disabled
        , HA.value <| String.fromFloat props.value
        , HA.min <| String.fromFloat props.min
        , HA.max <| String.fromFloat props.max
        , HA.step <| String.fromFloat props.step
        , HE.on "input"
            (D.at [ "target", "value" ] D.string
                |> D.andThen
                    (\v ->
                        case String.toFloat v of
                            Just v_ ->
                                D.succeed v_

                            Nothing ->
                                D.fail "Invalid value."
                    )
                |> D.map props.onInput
            )
        , stylesList
            [ ( "--color", attrs.color, not attrs.disabled )
            , ( "--color", "var(--tmspc-background-dark)", attrs.disabled )
            ]
        ]
        []
