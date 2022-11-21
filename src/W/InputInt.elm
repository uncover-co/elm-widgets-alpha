module W.InputInt exposing
    ( view
    , init, toInt, toString, Value
    , placeholder, mask, prefix, suffix
    , disabled, readOnly
    , required, min, max, minLength, maxLength, validation
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Value

@docs init, toInt, toString, Value


# Styles

@docs placeholder, mask, prefix, suffix


# States

@docs disabled, readOnly


# Validation

@docs required, min, max, minLength, maxLength, validation


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
    = Value String Int


{-| -}
init : Maybe Int -> Value
init value =
    case value of
        Just v ->
            Value (String.fromInt v) v

        Nothing ->
            Value "" 0


{-| -}
toInt : Value -> Int
toInt (Value _ v) =
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
    , validation : Maybe (Int -> String -> Maybe customError)
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
    , placeholder = Nothing
    , validation = Nothing
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
validation : (Int -> String -> Maybe customError) -> Attribute msg customError
validation v =
    Attribute <| \attrs -> { attrs | validation = Just v }


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
           , HA.step "1"
           , HA.class W.Internal.Input.baseClass
           , W.Internal.Input.maskClass attrs.mask
           , HA.required attrs.required
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
           , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
           , WH.maybeAttr HA.min (Maybe.map String.fromFloat attrs.min)
           , WH.maybeAttr HA.max (Maybe.map String.fromFloat attrs.max)
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
    in
    W.Internal.Input.view attrs
        (H.div [ HA.class "ew-group ew-w-full ew-relative" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value (toString props.value)
                       , HE.on "input"
                            (D.at [ "target", "value" ] D.string
                                |> D.map (props.onInput << toValue)
                            )
                       ]
                )
                []
            , W.Internal.Input.mask attrs.mask (toString props.value)
            ]
        )


{-| -}
viewWithValidation :
    List (Attribute msg customError)
    ->
        { value : String
        , onInput : Result (Error customError) Int -> Value -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg customError
        attrs =
            applyAttrs attrs_
    in
    W.Internal.Input.view attrs
        (H.div [ HA.class "ew-group ew-w-full ew-relative" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value props.value
                       , HE.on "input"
                            (D.map8
                                (\value_ valid rangeOverflow rangeUnderflow tooLong tooShort valueMissing validationMessage ->
                                    let
                                        value__ : Value
                                        value__ =
                                            toValue value_

                                        customError : Maybe customError
                                        customError =
                                            attrs.validation
                                                |> Maybe.map (\fn -> fn (toInt value__) value_)
                                                |> Maybe.withDefault Nothing

                                        result : Result (Error customError) Int
                                        result =
                                            if valid && customError == Nothing then
                                                Ok (toInt value__)

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

                                            else
                                                customError
                                                    |> Maybe.map (Err << Custom)
                                                    |> Maybe.withDefault (Ok (toInt value__))
                                    in
                                    props.onInput result value__
                                )
                                (D.at [ "target", "value" ] D.string)
                                (D.at [ "target", "validity", "valid" ] D.bool)
                                (D.at [ "target", "validity", "rangeOverflow" ] D.bool)
                                (D.at [ "target", "validity", "rangeUnderflow" ] D.bool)
                                (D.at [ "target", "validity", "tooLong" ] D.bool)
                                (D.at [ "target", "validity", "tooShort" ] D.bool)
                                (D.at [ "target", "validity", "valueMissing" ] D.bool)
                                (D.at [ "target", "validationMessage" ] D.string)
                            )
                       ]
                )
                []
            , W.Internal.Input.mask attrs.mask props.value
            ]
        )


toValue : String -> Value
toValue value_ =
    case String.toInt value_ of
        Just v ->
            Value value_ v

        Nothing ->
            let
                parsedString : String
                parsedString =
                    value_
                        |> String.filter Char.isDigit

                parsedValue : Int
                parsedValue =
                    String.toInt parsedString
                        |> Maybe.withDefault 0
            in
            Value parsedString parsedValue
