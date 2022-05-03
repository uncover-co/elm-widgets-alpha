module ElmWidgets exposing
    ( globalStyles
    , modal, ModalAttributes, dataRow, DataRowAttributes
    , field
    , dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes
    , autocomplete, AutocompleteAttributes
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


# Loading

@docs loadingCircle, loadingDots, loadingRipple, LoadingAttributes


# Layout

@docs modal, ModalAttributes, dataRow, DataRowAttributes


# Forms

@docs field


# Input

@docs dateInput, datetimeInput, emailInput, numberInput, passwordInput, searchInput, telephoneInput, textInput, timeInput, urlInput, InputAttributes


# Autocomplete

@docs autocomplete, AutocompleteAttributes


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
import ElmWidgets.Attributes as WA exposing (readOnly)
import ElmWidgets.Icons
import ElmWidgets.Styles
import Html as H exposing (Html, optgroup)
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import Svg as S
import Svg.Attributes as SA
import W.Loading



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


maybeHtml : (a -> H.Html msg) -> Maybe a -> H.Html msg
maybeHtml fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (H.text "")


applyAttrs : a -> List (a -> a) -> a
applyAttrs defaults fns =
    List.foldl (\fn a -> fn a) defaults fns


fillWidth : Bool -> String
fillWidth fill =
    if fill then
        "100%"

    else
        "auto"


onEnter : msg -> H.Attribute msg
onEnter msg =
    HE.on "keyup"
        (D.field "key" D.string
            |> D.andThen
                (\key ->
                    if key == "Enter" then
                        D.succeed msg

                    else
                        D.fail "Invalid key."
                )
        )



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
    , readOnly : Bool
    }


selectDefaults : SelectAttributes
selectDefaults =
    { id = Nothing
    , disabled = False
    , readOnly = False
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
            , HA.readonly attrs.readOnly
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
    , readOnly : Bool
    , required : Bool
    , pattern : Maybe String
    , placeholder : Maybe String
    , onFocus : Maybe msg
    , onBlur : Maybe msg
    , onEnter : Maybe msg
    , htmlAttrs : List (H.Attribute msg)
    }


inputDefaults : InputAttributes msg
inputDefaults =
    { id = Nothing
    , disabled = False
    , readOnly = False
    , required = False
    , pattern = Nothing
    , placeholder = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
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
               , HA.readonly attrs.readOnly
               , HA.value props.value
               , HE.onInput props.onInput
               , maybeAttr HA.placeholder attrs.placeholder
               , maybeAttr HA.pattern attrs.pattern
               , maybeAttr HE.onFocus attrs.onFocus
               , maybeAttr HE.onBlur attrs.onBlur
               , maybeAttr onEnter attrs.onEnter
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
    , readOnly : Bool
    }


checkboxDefaults : CheckboxAttributes
checkboxDefaults =
    { id = Nothing
    , color = "var(--tmspc-highlight-base)"
    , disabled = False
    , readOnly = False
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
    H.input
        [ maybeAttr HA.id attrs.id
        , HA.class "ew ew-focusable ew-checkbox"
        , HA.classList
            [ ( "ew-is-disabled", attrs.disabled && not attrs.readOnly )
            , ( "ew-is-read-only", attrs.readOnly )
            ]
        , styles [ ( "--color", attrs.color ) ]
        , HA.type_ "checkbox"
        , HA.checked props.value

        -- We also disable the checkbox plugin when it is readonly
        -- Since this property is not currently respect for checkboxes
        , HA.disabled (attrs.disabled || attrs.readOnly)
        , HA.readonly attrs.readOnly

        --
        , HE.onCheck props.onInput
        ]
        []



-- Radio


{-| -}
type alias RadioButtonsAttributes =
    { color : String
    , disabled : Bool
    , readOnly : Bool
    , vertical : Bool
    }


radioButtonsDefaults : RadioButtonsAttributes
radioButtonsDefaults =
    { color = "var(--tmspc-highlight-base)"
    , disabled = False
    , readOnly = False
    , vertical = False
    }


{-| -}
radioButtons :
    List (RadioButtonsAttributes -> RadioButtonsAttributes)
    ->
        { id : String
        , value : a
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
        [ HA.id props.id
        , HA.class "ew ew-radio-buttons"
        , HA.classList
            [ ( "ew-m-vertical", attrs.vertical )
            , ( "ew-is-disabled", attrs.disabled && not attrs.readOnly )
            , ( "ew-is-read-only", attrs.readOnly )
            ]
        , styles [ ( "--color", attrs.color ) ]
        ]
        (props.options
            |> List.map
                (\a ->
                    H.label
                        [ HA.name props.id
                        , HA.class "ew ew-radio-buttons--item"
                        ]
                        [ H.input
                            [ HA.class "ew ew-focusable ew-radio-buttons--item-input"
                            , HA.classList
                                [ ( "ew-is-disabled", attrs.disabled && not attrs.readOnly )
                                , ( "ew-is-read-only", attrs.readOnly )
                                ]
                            , HA.type_ "radio"
                            , HA.name props.id
                            , HA.value (props.toValue a)
                            , HA.checked (a == props.value)

                            -- Fallback since read only is not respected for radio inputs
                            , HA.disabled (attrs.disabled || attrs.readOnly)
                            , HA.readonly attrs.readOnly

                            --
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
    , readOnly : Bool
    , color : String
    , format : Float -> String
    }


rangeDefaults : RangeAttributes
rangeDefaults =
    { id = Nothing
    , disabled = False
    , readOnly = False
    , color = "var(--tmspc-highlight-base)"
    , format = String.fromFloat
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
    H.div [ HA.class "ew ew-range-wrapper" ]
        [ H.div [ HA.class "ew ew-range-value-wrapper" ]
            [ H.p
                [ HA.class "ew ew-range-bounds ew-m-min" ]
                [ H.text <| attrs.format props.min ]
            , H.p
                [ HA.class "ew ew-range-value"
                ]
                [ H.text <| attrs.format props.value ]
            , H.p
                [ HA.class "ew ew-range-bounds ew-m-max" ]
                [ H.text <| attrs.format props.max ]
            ]
        , H.input
            [ maybeAttr HA.id attrs.id
            , HA.class "ew ew-range"
            , HA.classList [ ( "ew-m-read-only", attrs.readOnly ) ]
            , HA.type_ "range"

            -- This is a fallback since range elements will not respect read only attributes
            , HA.disabled (attrs.disabled || attrs.readOnly)
            , HA.readonly attrs.readOnly

            --
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
        ]



-- Autocomplete


{-| -}
type alias AutocompleteAttributes msg =
    { disabled : Bool
    , readOnly : Bool
    , placeholder : Maybe String
    , onFocus : Maybe msg
    , onBlur : Maybe msg
    , onEnter : Maybe msg
    , htmlAttrs : List (H.Attribute msg)
    }


autocompleteDefaults : AutocompleteAttributes msg
autocompleteDefaults =
    { disabled = False
    , readOnly = False
    , placeholder = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttrs = []
    }


{-| -}
autocomplete :
    List (AutocompleteAttributes msg -> AutocompleteAttributes msg)
    ->
        { id : String
        , search : String
        , value : Maybe a
        , options : Maybe (List a)
        , toLabel : a -> String
        , onInput : String -> Maybe a -> msg
        }
    -> H.Html msg
autocomplete attrs_ props =
    let
        attrs =
            applyAttrs autocompleteDefaults attrs_

        options =
            props.options
                |> Maybe.withDefault []
                |> List.map (\o -> ( props.toLabel o, o ))

        optionsDict =
            Dict.fromList options
    in
    H.div [ HA.class "ew ew-autocomplete" ]
        [ H.input
            (attrs.htmlAttrs
                ++ [ maybeAttr HA.placeholder attrs.placeholder
                   , HA.disabled attrs.disabled
                   , HA.readonly attrs.readOnly
                   , HA.autocomplete False
                   , HA.id props.id
                   , HA.class "ew ew-input ew-focusable"
                   , HA.list (props.id ++ "-list")
                   , HA.value props.search
                   , maybeAttr HE.onFocus attrs.onFocus
                   , maybeAttr HE.onBlur attrs.onBlur
                   , maybeAttr onEnter attrs.onEnter
                   , HE.on "input"
                        (D.at [ "target", "value" ] D.string
                            |> D.andThen
                                (\value ->
                                    Dict.get value optionsDict
                                        |> props.onInput value
                                        |> D.succeed
                                )
                        )
                   ]
            )
            []
        , H.datalist
            [ HA.id (props.id ++ "-list") ]
            (options
                |> List.map
                    (\( label, _ ) ->
                        H.option [ HA.value label ] []
                    )
            )
        , if props.options == Nothing then
            H.div
                [ HA.class "ew ew-autocomplete-loading" ]
                [ W.Loading.circles [ W.Loading.size 28 ]
                ]

          else
            H.text ""
        ]



-- Modal


{-| -}
type alias ModalAttributes =
    { absolute : Bool
    }


modalDefaults : ModalAttributes
modalDefaults =
    { absolute = False
    }


{-| -}
modal :
    List (ModalAttributes -> ModalAttributes)
    ->
        { onClose : Maybe msg
        , content : Html msg
        }
    -> Html msg
modal attrs_ props =
    let
        attrs =
            applyAttrs modalDefaults attrs_
    in
    H.div
        [ HA.attribute "role" "dialog"
        , HA.class "ew ew-modal"
        , HA.classList
            [ ( "ew-m-absolute", attrs.absolute )
            , ( "ew-m-can-close", props.onClose /= Nothing )
            ]
        ]
        [ H.div
            [ HA.class "ew ew-modal-background"
            , maybeAttr HE.onClick props.onClose
            ]
            []
        , maybeHtml
            (\onClose ->
                H.button
                    [ HA.class "ew ew-modal-close"
                    , HE.onClick onClose
                    ]
                    [ ElmWidgets.Icons.close { size = 24 } ]
            )
            props.onClose
        , H.div
            [ HA.class "ew ew-modal-content"
            ]
            [ props.content
            ]
        ]



-- DataRow


{-| -}
type alias DataRowAttributes msg =
    { footer : Maybe (Html msg)
    , header : Maybe (Html msg)
    , left : Maybe (Html msg)
    , onClick : Maybe msg
    , href : Maybe String
    }


dataRowDefaults : DataRowAttributes msg
dataRowDefaults =
    { footer = Nothing
    , header = Nothing
    , left = Nothing
    , onClick = Nothing
    , href = Nothing
    }


{-| -}
dataRow :
    List (DataRowAttributes msg -> DataRowAttributes msg)
    ->
        { label : Html msg
        , actions : List (Html msg)
        }
    -> H.Html msg
dataRow attrs_ props =
    let
        attrs =
            applyAttrs dataRowDefaults attrs_

        main_ =
            case ( attrs.onClick, attrs.href ) of
                ( Just onClick, _ ) ->
                    H.button
                        [ HA.class "ew ew-focusable ew-data-row-main ew-m-button", HE.onClick onClick ]

                ( Nothing, Just href ) ->
                    H.a
                        [ HA.class "ew ew-focusable ew-data-row-main ew-m-link", HA.href href ]

                _ ->
                    H.div
                        [ HA.class "ew ew-data-row-main" ]
    in
    H.div [ HA.class "ew ew-data-row" ]
        [ main_
            [ maybeHtml (\left -> H.div [ HA.class "ew ew-data-row-left" ] [ left ]) attrs.left
            , H.div [ HA.class "ew ew-data-row-main-main" ]
                [ maybeHtml (\header -> H.div [ HA.class "ew ew-data-row-header" ] [ header ]) attrs.header
                , H.div [ HA.class "ew ew-data-row-label" ] [ props.label ]
                , maybeHtml (\footer -> H.div [ HA.class "ew ew-data-row-footer" ] [ footer ]) attrs.footer
                ]
            ]
        , if not (List.isEmpty props.actions) then
            H.div
                [ HA.class "ew ew-data-row-actions" ]
                props.actions

          else
            H.text ""
        ]
