module W.InputDate exposing
    ( view
    , disabled, readOnly
    , prefix, suffix
    , min, max, step, required
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# States

@docs disabled, readOnly


# Styles

@docs prefix, suffix


# Validation Attributes

@docs min, max, step, required


# View & Validation

@docs viewWithValidation, errorToString, Error


# Actions

@docs onEnter, onFocus, onBlur


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Date
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import Time
import Time.Extra
import W.Internal.Helpers as WH
import W.Internal.Icons
import W.Internal.Input



-- Error


{-| -}
type Error
    = TooLow Time.Posix String
    | TooHigh Time.Posix String
    | StepMismatch Int String
    | ValueMissing String
    | BadInput


{-| -}
errorToString : Error -> String
errorToString error =
    case error of
        TooLow _ message ->
            message

        TooHigh _ message ->
            message

        StepMismatch _ message ->
            message

        ValueMissing message ->
            message

        BadInput ->
            "Value must be a valid time."



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { class : String
    , disabled : Bool
    , readOnly : Bool
    , required : Bool
    , min : Maybe Time.Posix
    , max : Maybe Time.Posix
    , step : Maybe Int
    , prefix : Maybe (H.Html msg)
    , suffix : Maybe (H.Html msg)
    , onFocus : Maybe msg
    , onBlur : Maybe msg
    , onEnter : Maybe msg
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { class = ""
    , disabled = False
    , readOnly = False
    , required = False
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
disabled : Bool -> Attribute msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute msg
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }


{-| -}
required : Bool -> Attribute msg
required v =
    Attribute <| \attrs -> { attrs | required = v }


{-| -}
min : Time.Posix -> Attribute msg
min v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
max : Time.Posix -> Attribute msg
max v =
    Attribute <| \attrs -> { attrs | max = Just v }


{-| -}
step : Int -> Attribute msg
step v =
    Attribute <| \attrs -> { attrs | step = Just v }


{-| -}
prefix : H.Html msg -> Attribute msg
prefix v =
    Attribute <| \attrs -> { attrs | prefix = Just v }


{-| -}
suffix : H.Html msg -> Attribute msg
suffix v =
    Attribute <| \attrs -> { attrs | suffix = Just v }


{-| -}
onBlur : msg -> Attribute msg
onBlur v =
    Attribute <| \attrs -> { attrs | onBlur = Just v }


{-| -}
onFocus : msg -> Attribute msg
onFocus v =
    Attribute <| \attrs -> { attrs | onFocus = Just v }


{-| -}
onEnter : msg -> Attribute msg
onEnter v =
    Attribute <| \attrs -> { attrs | onEnter = Just v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity



-- Main


baseAttrs : Attributes msg -> Time.Zone -> String -> List (H.Attribute msg)
baseAttrs attrs timeZone value =
    attrs.htmlAttributes
        ++ [ HA.type_ "date"
           , HA.class W.Internal.Input.baseClass
           , HA.required attrs.required
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
           , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
           , WH.maybeAttr HA.min (Maybe.map (valueFromDate timeZone) attrs.min)
           , WH.maybeAttr HA.max (Maybe.map (valueFromDate timeZone) attrs.max)
           , WH.maybeAttr HA.step (Maybe.map String.fromInt attrs.step)
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           , HA.value value
           ]


{-| -}
view :
    List (Attribute msg)
    ->
        { timeZone : Time.Zone
        , value : Maybe Time.Posix
        , onInput : Maybe Time.Posix -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        value : String
        value =
            props.value
                |> Maybe.map (valueFromDate props.timeZone)
                |> Maybe.withDefault ""
    in
    H.input
        (HE.on "input"
            (D.at [ "target", "valueAsNumber" ] D.float
                |> D.andThen
                    (\v ->
                        dateFromValue props.timeZone props.value v
                            |> props.onInput
                            |> D.succeed
                    )
            )
            :: baseAttrs attrs props.timeZone value
        )
        []
        |> W.Internal.Input.viewWithIcon
            { prefix = attrs.prefix
            , suffix = attrs.suffix
            , disabled = attrs.disabled
            , readOnly = attrs.readOnly
            , mask = Nothing
            , maskInput = value
            }
            (W.Internal.Icons.calendar { size = 24 })


{-| -}
viewWithValidation :
    List (Attribute msg)
    ->
        { timeZone : Time.Zone
        , value : Maybe Time.Posix
        , onInput : Result Error Time.Posix -> Maybe Time.Posix -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        value : String
        value =
            props.value
                |> Maybe.map (valueFromDate props.timeZone)
                |> Maybe.withDefault ""
    in
    H.input
        (HE.on "input"
            (D.map7
                (\value_ valid rangeOverflow rangeUnderflow stepMismatch valueMissing validationMessage ->
                    case dateFromValue props.timeZone props.value value_ of
                        Nothing ->
                            props.onInput (Err BadInput) Nothing

                        Just time ->
                            if valid then
                                props.onInput (Ok time) (Just time)

                            else if valueMissing then
                                props.onInput
                                    (Err (ValueMissing validationMessage))
                                    (Just time)

                            else if rangeUnderflow then
                                props.onInput
                                    (Err
                                        (TooLow
                                            (Maybe.withDefault (Time.millisToPosix 0) attrs.min)
                                            validationMessage
                                        )
                                    )
                                    (Just time)

                            else if rangeOverflow then
                                props.onInput
                                    (Err
                                        (TooHigh
                                            (Maybe.withDefault (Time.millisToPosix 0) attrs.max)
                                            validationMessage
                                        )
                                    )
                                    (Just time)

                            else if stepMismatch then
                                props.onInput
                                    (Err
                                        (StepMismatch
                                            (Maybe.withDefault 0 attrs.step)
                                            validationMessage
                                        )
                                    )
                                    (Just time)

                            else
                                props.onInput (Ok time) (Just time)
                )
                (D.at [ "target", "valueAsNumber" ] D.float)
                (D.at [ "target", "validity", "valid" ] D.bool)
                (D.at [ "target", "validity", "rangeOverflow" ] D.bool)
                (D.at [ "target", "validity", "rangeUnderflow" ] D.bool)
                (D.at [ "target", "validity", "stepMismatch" ] D.bool)
                (D.at [ "target", "validity", "valueMissing" ] D.bool)
                (D.at [ "target", "validationMessage" ] D.string)
            )
            :: baseAttrs attrs props.timeZone value
        )
        []
        |> W.Internal.Input.viewWithIcon
            { prefix = attrs.prefix
            , suffix = attrs.suffix
            , disabled = attrs.disabled
            , readOnly = attrs.readOnly
            , mask = Nothing
            , maskInput = value
            }
            (W.Internal.Icons.calendar { size = 24 })



-- Helpers


valueFromDate : Time.Zone -> Time.Posix -> String
valueFromDate timeZone timestamp =
    timestamp
        |> Date.fromPosix timeZone
        |> Date.format "yyyy-MM-dd"


dateFromValue : Time.Zone -> Maybe Time.Posix -> Float -> Maybe Time.Posix
dateFromValue timeZone currentValue value =
    if isNaN value then
        Nothing

    else
        let
            notAdjusted : Time.Posix
            notAdjusted =
                Time.millisToPosix (floor value)

            timezoneAdjusted : Int
            timezoneAdjusted =
                floor value - (Time.Extra.toOffset timeZone notAdjusted * 60 * 1000)

            timeOfDayOffset : Int
            timeOfDayOffset =
                currentValue
                    |> Maybe.map
                        (\userValue ->
                            Time.Extra.diff Time.Extra.Millisecond
                                timeZone
                                (Time.Extra.floor Time.Extra.Day timeZone userValue)
                                userValue
                        )
                    |> Maybe.withDefault 0
        in
        Just (Time.millisToPosix (timezoneAdjusted + timeOfDayOffset))
