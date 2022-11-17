module W.InputInt exposing
    ( view, init, toInt, toString, Value
    , min, max, minLength, maxLength
    , id, class, placeholder, mask, disabled, required, readOnly, validation
    , prefix, suffix
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, Attribute
    )

{-|

@docs view, init, toInt, toString, Value
@docs min, max, minLength, maxLength
@docs id, class, placeholder, mask, disabled, required, readOnly, validation
@docs prefix, suffix
@docs viewWithValidation, errorToString, Error
@docs onEnter, onFocus, onBlur
@docs htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import W.Internal.Helpers as WH
import W.Internal.Input



-- Value


type Value
    = Value String Int


init : Maybe Int -> Value
init value =
    case value of
        Just v ->
            Value (String.fromInt v) v

        Nothing ->
            Value "" 0


toInt : Value -> Int
toInt (Value _ v) =
    v


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
type Attribute customError msg
    = Attribute (Attributes customError msg -> Attributes customError msg)


type alias Attributes customError msg =
    { id : Maybe String
    , class : String
    , disabled : Bool
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


applyAttrs : List (Attribute customError msg) -> Attributes customError msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes customError msg
defaultAttrs =
    { id = Nothing
    , class = ""
    , disabled = False
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
id : String -> Attribute customError msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
class : String -> Attribute customError msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


{-| -}
placeholder : String -> Attribute customError msg
placeholder v =
    Attribute <| \attrs -> { attrs | placeholder = Just v }


{-| -}
mask : (String -> String) -> Attribute customError msg
mask v =
    Attribute <| \attrs -> { attrs | mask = Just v }


{-| -}
disabled : Bool -> Attribute customError msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute customError msg
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }


{-| -}
required : Bool -> Attribute customError msg
required v =
    Attribute <| \attrs -> { attrs | required = v }


{-| -}
min : Float -> Attribute customError msg
min v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
max : Float -> Attribute customError msg
max v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
minLength : Int -> Attribute customError msg
minLength v =
    Attribute <| \attrs -> { attrs | minLength = Just v }


{-| -}
maxLength : Int -> Attribute customError msg
maxLength v =
    Attribute <| \attrs -> { attrs | maxLength = Just v }


{-| -}
validation : (Int -> String -> Maybe customError) -> Attribute customError msg
validation v =
    Attribute <| \attrs -> { attrs | validation = Just v }


{-| -}
prefix : H.Html msg -> Attribute customError msg
prefix v =
    Attribute <| \attrs -> { attrs | prefix = Just v }


{-| -}
suffix : H.Html msg -> Attribute customError msg
suffix v =
    Attribute <| \attrs -> { attrs | suffix = Just v }


{-| -}
onBlur : msg -> Attribute customError msg
onBlur v =
    Attribute <| \attrs -> { attrs | onBlur = Just v }


{-| -}
onFocus : msg -> Attribute customError msg
onFocus v =
    Attribute <| \attrs -> { attrs | onFocus = Just v }


{-| -}
onEnter : msg -> Attribute customError msg
onEnter v =
    Attribute <| \attrs -> { attrs | onEnter = Just v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute customError msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }



-- Main


{-| -}
baseAttrs : Attributes customError msg -> List (H.Attribute msg)
baseAttrs attrs =
    attrs.htmlAttributes
        ++ [ HA.type_ "number"
           , HA.step "1"
           , WH.maybeAttr HA.id attrs.id
           , HA.class W.Internal.Input.baseClass
           , HA.class attrs.class
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
    List (Attribute customError msg)
    ->
        { value : Value
        , onInput : Value -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes customError msg
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
    List (Attribute customError msg)
    ->
        { value : String
        , onInput : Result (Error customError) Int -> Value -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes customError msg
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
