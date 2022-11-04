module W.InputFloat exposing
    ( view
    , min, max, step
    , id, class, placeholder, mask, disabled, required, readOnly
    , prefix, suffix
    , viewWithValidation, errorToString, Error(..)
    , onEnter, onFocus, onBlur
    , htmlAttrs, Attribute
    )

{-|

@docs view
@docs min, max, step
@docs id, class, placeholder, mask, disabled, required, readOnly
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



-- Errors


{-| -}
type Error
    = TooLow Float String
    | TooHigh Float String
    | StepMismatch Float String
    | ValueMissing String


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
    , min : Maybe Float
    , max : Maybe Float
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
    , min = Nothing
    , max = Nothing
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
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
class : String -> Attribute msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


{-| -}
placeholder : String -> Attribute msg
placeholder v =
    Attribute <| \attrs -> { attrs | placeholder = Just v }


{-| -}
mask : (String -> String) -> Attribute msg
mask v =
    Attribute <| \attrs -> { attrs | mask = Just v }


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
min : Float -> Attribute msg
min v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
max : Float -> Attribute msg
max v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
step : Float -> Attribute msg
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



-- Main


{-| -}
baseAttrs : Attributes msg -> List (H.Attribute msg)
baseAttrs attrs =
    attrs.htmlAttributes
        ++ [ HA.type_ "number"
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
           , WH.maybeAttr HA.step (Maybe.map String.fromFloat attrs.step)
           , WH.maybeAttr HA.placeholder attrs.placeholder
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           ]


{-| -}
view :
    List (Attribute msg)
    ->
        { value : String
        , onInput : Float -> String -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    W.Internal.Input.view attrs
        (H.div [ HA.class "ew-group ew-w-full ew-relative" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value props.value
                       , HE.on "input"
                            (D.at [ "target", "value" ] D.string
                                |> D.map (toInputMsg props.onInput props.value)
                            )
                       ]
                )
                []
            , W.Internal.Input.mask attrs.mask props.value
            ]
        )


{-| -}
viewWithValidation :
    List (Attribute msg)
    ->
        { value : String
        , onInput : Result Error String -> Float -> String -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    W.Internal.Input.view attrs
        (H.div [ HA.class "ew-group ew-w-full ew-relative" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value props.value
                       , HE.on "input"
                            (D.map7
                                (\value_ valid rangeOverflow rangeUnderflow stepMismatch valueMissing validationMessage ->
                                    let
                                        result =
                                            if valid then
                                                Ok value_

                                            else if valueMissing then
                                                Err (ValueMissing validationMessage)

                                            else if rangeUnderflow then
                                                Err (TooLow (Maybe.withDefault 0 attrs.min) validationMessage)

                                            else if rangeOverflow then
                                                Err (TooHigh (Maybe.withDefault 0 attrs.max) validationMessage)

                                            else if stepMismatch then
                                                Err (StepMismatch (Maybe.withDefault 0 attrs.step) validationMessage)

                                            else
                                                Ok value_
                                    in
                                    toInputMsg (props.onInput result) props.value value_
                                )
                                (D.at [ "target", "value" ] D.string)
                                (D.at [ "target", "validity", "valid" ] D.bool)
                                (D.at [ "target", "validity", "rangeOverflow" ] D.bool)
                                (D.at [ "target", "validity", "rangeUnderflow" ] D.bool)
                                (D.at [ "target", "validity", "stepMismatch" ] D.bool)
                                (D.at [ "target", "validity", "valueMissing" ] D.bool)
                                (D.at [ "target", "validationMessage" ] D.string)
                            )
                       ]
                )
                []
            , W.Internal.Input.mask attrs.mask props.value
            ]
        )


toInputMsg : (Float -> String -> msg) -> String -> String -> msg
toInputMsg onInput previous value =
    case String.toFloat value of
        Just v ->
            onInput v value

        Nothing ->
            if value == "" then
                onInput 0 value

            else
                case String.toFloat previous of
                    Just v_ ->
                        onInput v_ value

                    Nothing ->
                        onInput 0 value
