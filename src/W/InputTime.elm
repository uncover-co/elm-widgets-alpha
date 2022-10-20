module W.InputTime exposing
    ( view
    , min, max, step, timeZone
    , id, class, disabled, required, readOnly
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, Attribute
    )

{-|

@docs view
@docs min, max, step, timeZone
@docs id, class, disabled, required, readOnly
@docs viewWithValidation, errorToString, Error
@docs onEnter, onFocus, onBlur
@docs htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import Time
import Time.Extra
import W.Internal.Helpers as WH
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
    { id : Maybe String
    , class : String
    , disabled : Bool
    , readOnly : Bool
    , required : Bool
    , timeZone : Time.Zone
    , min : Maybe Time.Posix
    , max : Maybe Time.Posix
    , step : Maybe Int
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
    { id = Nothing
    , class = ""
    , disabled = False
    , readOnly = False
    , required = False
    , timeZone = Time.utc
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
class : String -> Attribute msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


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
timeZone : Time.Zone -> Attribute msg
timeZone v =
    Attribute <| \attrs -> { attrs | timeZone = v }


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



-- Main


baseAttrs : Attributes msg -> Maybe Time.Posix -> List (H.Attribute msg)
baseAttrs attrs value =
    attrs.htmlAttributes
        ++ [ HA.type_ "time"
           , WH.maybeAttr HA.id attrs.id
           , HA.class W.Internal.Input.baseClass
           , HA.class attrs.class
           , HA.required attrs.required
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.maybeAttr HA.min (Maybe.map (valueFromTime attrs) attrs.min)
           , WH.maybeAttr HA.max (Maybe.map (valueFromTime attrs) attrs.max)
           , WH.maybeAttr HA.step (Maybe.map String.fromInt attrs.step)
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           , HA.value
                (value
                    |> Maybe.map (valueFromTime attrs)
                    |> Maybe.withDefault ""
                )
           ]


{-| -}
view :
    List (Attribute msg)
    ->
        { onInput : Maybe Time.Posix -> msg
        , value : Maybe Time.Posix
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.input
        (HE.onInput (props.onInput << timeFromValue attrs props.value)
            :: baseAttrs attrs props.value
        )
        []


{-| -}
viewWithValidation :
    List (Attribute msg)
    ->
        { onInput : Maybe Time.Posix -> Result Error Time.Posix -> msg
        , value : Maybe Time.Posix
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.input
        (HE.on "input"
            (D.map7
                (\value_ valid rangeOverflow rangeUnderflow stepMismatch valueMissing validationMessage ->
                    case timeFromValue attrs props.value value_ of
                        Nothing ->
                            props.onInput Nothing (Err BadInput)

                        Just time ->
                            if valid then
                                props.onInput (Just time) (Ok time)

                            else if valueMissing then
                                props.onInput
                                    (Just time)
                                    (Err (ValueMissing validationMessage))

                            else if rangeUnderflow then
                                props.onInput (Just time)
                                    (Err
                                        (TooLow
                                            (Maybe.withDefault (Time.millisToPosix 0) attrs.min)
                                            validationMessage
                                        )
                                    )

                            else if rangeOverflow then
                                props.onInput (Just time)
                                    (Err
                                        (TooHigh
                                            (Maybe.withDefault (Time.millisToPosix 0) attrs.max)
                                            validationMessage
                                        )
                                    )

                            else if stepMismatch then
                                props.onInput
                                    (Just time)
                                    (Err
                                        (StepMismatch
                                            (Maybe.withDefault 0 attrs.step)
                                            validationMessage
                                        )
                                    )

                            else
                                props.onInput (Just time) (Ok time)
                )
                (D.at [ "target", "value" ] D.string)
                (D.at [ "target", "validity", "valid" ] D.bool)
                (D.at [ "target", "validity", "rangeOverflow" ] D.bool)
                (D.at [ "target", "validity", "rangeUnderflow" ] D.bool)
                (D.at [ "target", "validity", "stepMismatch" ] D.bool)
                (D.at [ "target", "validity", "valueMissing" ] D.bool)
                (D.at [ "target", "validationMessage" ] D.string)
            )
            :: baseAttrs attrs props.value
        )
        []


valueFromTime : Attributes msg -> Time.Posix -> String
valueFromTime attrs value =
    let
        hour : String
        hour =
            Time.toHour attrs.timeZone value
                |> String.fromInt
                |> String.padLeft 2 '0'

        minute : String
        minute =
            Time.toMinute attrs.timeZone value
                |> String.fromInt
                |> String.padLeft 2 '0'
    in
    hour ++ ":" ++ minute


timeFromValue : Attributes msg -> Maybe Time.Posix -> String -> Maybe Time.Posix
timeFromValue attrs currentValue value =
    let
        currentStartOfDay : Int
        currentStartOfDay =
            currentValue
                |> Maybe.map (Time.Extra.floor Time.Extra.Day attrs.timeZone)
                |> Maybe.map Time.posixToMillis
                |> Maybe.withDefault 0

        hours : String -> String -> Int
        hours h1 h2 =
            String.toInt (h1 ++ h2)
                |> Maybe.map ((*) (60 * 60 * 1000))
                |> Maybe.withDefault 0

        minutes : String -> String -> Int
        minutes m1 m2 =
            String.toInt (m1 ++ m2)
                |> Maybe.map ((*) (60 * 1000))
                |> Maybe.withDefault 0

        seconds : String -> String -> Int
        seconds s1 s2 =
            String.toInt (s1 ++ s2)
                |> Maybe.map ((*) 1000)
                |> Maybe.withDefault 0
    in
    case String.split "" value of
        h1 :: h2 :: ":" :: m1 :: m2 :: [] ->
            hours h1 h2
                + minutes m1 m2
                + currentStartOfDay
                |> Time.millisToPosix
                |> Just

        h1 :: h2 :: ":" :: m1 :: m2 :: ":" :: s1 :: s2 :: [] ->
            hours h1 h2
                + minutes m1 m2
                + seconds s1 s2
                + currentStartOfDay
                |> Time.millisToPosix
                |> Just

        _ ->
            Nothing
