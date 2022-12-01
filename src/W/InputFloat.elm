module W.InputFloat exposing
    ( view
    , init, toFloat, toString, Value
    , placeholder, mask, prefix, suffix
    , disabled, readOnly
    , required, min, max, step, minLength, maxLength, validation
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Value

@docs init, toFloat, toString, Value


# Styles

@docs placeholder, mask, prefix, suffix


# States

@docs disabled, readOnly


# Validation

@docs required, min, max, step, minLength, maxLength, validation


# View With Validation

@docs viewWithValidation, errorToString, Error


# Actions

@docs onEnter, onFocus, onBlur


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import W.Internal.Helpers as WH
import W.Internal.Input



-- Value


{-| -}
type Value
    = Value String Float


{-| -}
init : Maybe Float -> Value
init value =
    case value of
        Just v ->
            Value (String.fromFloat v) v

        Nothing ->
            Value "" 0


{-| -}
toFloat : Value -> Float
toFloat (Value _ v) =
    v


{-| -}
toString : Value -> String
toString (Value v _) =
    v



-- Errors


{-| -}
type Error customError
    = TooLow Float String
    | TooHigh Float String
    | TooLong Int String
    | TooShort Int String
    | StepMismatch Float String
    | ValueMissing String
    | Custom customError


{-| -}
errorToString : Error customError -> String
errorToString error =
    case error of
        TooLow _ message ->
            message

        TooHigh _ message ->
            message

        TooLong _ message ->
            message

        TooShort _ message ->
            message

        StepMismatch _ message ->
            message

        ValueMissing message ->
            message

        Custom _ ->
            "Value must follow the expected format."



-- Attributes


{-| -}
type Attribute msg customError
    = Attribute (Attributes msg customError -> Attributes msg customError)


type alias Attributes msg customError =
    { disabled : Bool
    , readOnly : Bool
    , required : Bool
    , min : Maybe Float
    , max : Maybe Float
    , minLength : Maybe Int
    , maxLength : Maybe Int
    , validation : Maybe (Float -> String -> Maybe customError)
    , step : Maybe Float
    , placeholder : Maybe String
    , mask : Maybe (String -> String)
    , prefix : Maybe (H.Html msg)
    , suffix : Maybe (H.Html msg)
    , onFocus : Maybe msg
    , onBlur : Maybe msg
    , onEnter : Maybe msg
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg customError) -> Attributes msg customError
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg customError
defaultAttrs =
    { disabled = False
    , readOnly = False
    , required = False
    , min = Nothing
    , max = Nothing
    , minLength = Nothing
    , maxLength = Nothing
    , validation = Nothing
    , step = Nothing
    , placeholder = Nothing
    , mask = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
placeholder : String -> Attribute msg customError
placeholder v =
    Attribute <| \attrs -> { attrs | placeholder = Just v }


{-| -}
mask : (String -> String) -> Attribute msg customError
mask v =
    Attribute <| \attrs -> { attrs | mask = Just v }


{-| -}
disabled : Bool -> Attribute msg customError
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute msg customError
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }


{-| -}
required : Bool -> Attribute msg customError
required v =
    Attribute <| \attrs -> { attrs | required = v }


{-| -}
min : Float -> Attribute msg customError
min v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
max : Float -> Attribute msg customError
max v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
minLength : Int -> Attribute msg customError
minLength v =
    Attribute <| \attrs -> { attrs | minLength = Just v }


{-| -}
maxLength : Int -> Attribute msg customError
maxLength v =
    Attribute <| \attrs -> { attrs | maxLength = Just v }


{-| -}
validation : (Float -> String -> Maybe customError) -> Attribute msg customError
validation v =
    Attribute <| \attrs -> { attrs | validation = Just v }


{-| -}
step : Float -> Attribute msg customError
step v =
    Attribute <| \attrs -> { attrs | step = Just v }


{-| -}
prefix : H.Html msg -> Attribute msg customError
prefix v =
    Attribute <| \attrs -> { attrs | prefix = Just v }


{-| -}
suffix : H.Html msg -> Attribute msg customError
suffix v =
    Attribute <| \attrs -> { attrs | suffix = Just v }


{-| -}
onBlur : msg -> Attribute msg customError
onBlur v =
    Attribute <| \attrs -> { attrs | onBlur = Just v }


{-| -}
onFocus : msg -> Attribute msg customError
onFocus v =
    Attribute <| \attrs -> { attrs | onFocus = Just v }


{-| -}
onEnter : msg -> Attribute msg customError
onEnter v =
    Attribute <| \attrs -> { attrs | onEnter = Just v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg customError
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg customError
noAttr =
    Attribute identity



-- Main


{-| -}
baseAttrs : Attributes msg customError -> List (H.Attribute msg)
baseAttrs attrs =
    attrs.htmlAttributes
        ++ [ HA.type_ "number"
           , HA.class W.Internal.Input.baseClass
           , HA.required attrs.required
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
           , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
           , WH.maybeAttr HA.min (Maybe.map String.fromFloat attrs.min)
           , WH.maybeAttr HA.max (Maybe.map String.fromFloat attrs.max)
           , WH.maybeAttr HA.step (Maybe.map String.fromFloat attrs.step)
           , WH.maybeAttr HA.placeholder attrs.placeholder
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           ]


{-| -}
view :
    List (Attribute msg customError)
    ->
        { value : Value
        , onInput : Value -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg customError
        attrs =
            applyAttrs attrs_

        value : String
        value =
            toString props.value
    in
    W.Internal.Input.view
        { disabled = attrs.disabled
        , readOnly = attrs.readOnly
        , prefix = attrs.prefix
        , suffix = attrs.suffix
        , mask = attrs.mask
        , maskInput = value
        }
        (H.input
            (baseAttrs attrs
                ++ [ HA.value value
                   , HE.on "input"
                        (D.at [ "target", "value" ] D.string
                            |> D.map (props.onInput << toValue props.value)
                        )
                   ]
            )
            []
        )


{-| -}
viewWithValidation :
    List (Attribute msg customError)
    ->
        { value : Value
        , onInput : Result (Error customError) Float -> Value -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg customError
        attrs =
            applyAttrs attrs_

        value : String
        value =
            toString props.value
    in
    W.Internal.Input.view
        { disabled = attrs.disabled
        , readOnly = attrs.readOnly
        , prefix = attrs.prefix
        , suffix = attrs.suffix
        , mask = attrs.mask
        , maskInput = value
        }
        (H.input
            (baseAttrs attrs
                ++ [ HA.value value
                   , HE.on "input"
                        (D.map8
                            (\( value_, valid ) rangeOverflow rangeUnderflow tooLong tooShort stepMismatch valueMissing validationMessage ->
                                let
                                    value__ : Value
                                    value__ =
                                        toValue props.value value_

                                    customError : Maybe customError
                                    customError =
                                        attrs.validation
                                            |> Maybe.map (\fn -> fn (toFloat value__) value_)
                                            |> Maybe.withDefault Nothing

                                    result : Result (Error customError) Float
                                    result =
                                        if valid && customError == Nothing then
                                            Ok (toFloat value__)

                                        else if valueMissing then
                                            Err (ValueMissing validationMessage)

                                        else if rangeUnderflow then
                                            Err (TooLow (Maybe.withDefault 0 attrs.min) validationMessage)

                                        else if rangeOverflow then
                                            Err (TooHigh (Maybe.withDefault 0 attrs.max) validationMessage)

                                        else if tooShort then
                                            Err (TooShort (Maybe.withDefault 0 attrs.minLength) validationMessage)

                                        else if tooLong then
                                            Err (TooLong (Maybe.withDefault 0 attrs.maxLength) validationMessage)

                                        else if stepMismatch then
                                            Err (StepMismatch (Maybe.withDefault 0 attrs.step) validationMessage)

                                        else
                                            customError
                                                |> Maybe.map (Err << Custom)
                                                |> Maybe.withDefault (Ok (toFloat value__))
                                in
                                props.onInput result value__
                            )
                            (D.map2 Tuple.pair
                                (D.at [ "target", "value" ] D.string)
                                (D.at [ "target", "validity", "valid" ] D.bool)
                            )
                            (D.at [ "target", "validity", "rangeOverflow" ] D.bool)
                            (D.at [ "target", "validity", "rangeUnderflow" ] D.bool)
                            (D.at [ "target", "validity", "tooLong" ] D.bool)
                            (D.at [ "target", "validity", "tooShort" ] D.bool)
                            (D.at [ "target", "validity", "stepMismatch" ] D.bool)
                            (D.at [ "target", "validity", "valueMissing" ] D.bool)
                            (D.at [ "target", "validationMessage" ] D.string)
                        )
                   ]
            )
            []
        )


toValue : Value -> String -> Value
toValue previous value =
    case String.toFloat value of
        Just v ->
            Value value v

        Nothing ->
            if value == "" then
                Value value 0

            else
                case String.toFloat (toString previous) of
                    Just v_ ->
                        Value value v_

                    Nothing ->
                        Value value 0
