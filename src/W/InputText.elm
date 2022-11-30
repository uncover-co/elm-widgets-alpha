module W.InputText exposing
    ( view
    , email, password, search, telephone, url
    , placeholder, mask, prefix, suffix, unstyled
    , disabled, readOnly
    , onEnter, onFocus, onBlur
    , required, minLength, maxLength, exactLength, pattern, validation
    , viewWithValidation, errorToString, Error(..)
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Types

@docs email, password, search, telephone, url


# Styles

@docs placeholder, mask, prefix, suffix, unstyled


# States

@docs disabled, readOnly


# Actions

@docs onEnter, onFocus, onBlur


# Validation

@docs required, minLength, maxLength, exactLength, pattern, validation


# View With Validation

@docs viewWithValidation, errorToString, Error


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import W.Internal.Helpers as WH
import W.Internal.Input as WI



-- Attributes


{-| -}
type InputType
    = Text
    | Telephone
    | Password
    | Search
    | Email
    | Url


inputInputTypeToString : InputType -> String
inputInputTypeToString t =
    case t of
        Text ->
            "text"

        Telephone ->
            "tel"

        Password ->
            "password"

        Search ->
            "search"

        Email ->
            "email"

        Url ->
            "url"


{-| -}
type Error customError
    = PatternMismatch String
    | InputTypeMismatch InputType String
    | TooLong Int String
    | TooShort Int String
    | ValueMissing String
    | Custom customError


{-| -}
errorToString : Error customError -> String
errorToString error =
    case error of
        PatternMismatch message ->
            message

        InputTypeMismatch _ message ->
            message

        TooLong _ message ->
            message

        TooShort _ message ->
            message

        ValueMissing message ->
            message

        Custom _ ->
            "Value must follow the expected format."


{-| -}
type Attribute msg customError
    = Attribute (Attributes msg customError -> Attributes msg customError)


type alias Attributes msg customError =
    { type_ : InputType
    , unstyled : Bool
    , disabled : Bool
    , readOnly : Bool
    , required : Bool
    , minLength : Maybe Int
    , maxLength : Maybe Int
    , pattern : Maybe String
    , placeholder : Maybe String
    , validation : Maybe (String -> Maybe customError)
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
    { type_ = Text
    , unstyled = False
    , disabled = False
    , readOnly = False
    , required = False
    , minLength = Nothing
    , maxLength = Nothing
    , pattern = Nothing
    , validation = Nothing
    , placeholder = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , mask = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
password : Attribute msg customError
password =
    Attribute <| \attrs -> { attrs | type_ = Password }


{-| -}
search : Attribute msg customError
search =
    Attribute <| \attrs -> { attrs | type_ = Search }


{-| -}
url : Attribute msg customError
url =
    Attribute <| \attrs -> { attrs | type_ = Url }


{-| -}
email : Attribute msg customError
email =
    Attribute <| \attrs -> { attrs | type_ = Email }


{-| -}
telephone : Attribute msg customError
telephone =
    Attribute <| \attrs -> { attrs | type_ = Telephone }


{-| -}
unstyled : Attribute msg customError
unstyled =
    Attribute <| \attrs -> { attrs | unstyled = True }


{-| -}
placeholder : String -> Attribute msg customError
placeholder v =
    Attribute <| \attrs -> { attrs | placeholder = Just v }


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
exactLength : Int -> Attribute msg customError
exactLength v =
    Attribute <| \attrs -> { attrs | minLength = Just v, maxLength = Just v }


{-| -}
minLength : Int -> Attribute msg customError
minLength v =
    Attribute <| \attrs -> { attrs | minLength = Just v }


{-| -}
maxLength : Int -> Attribute msg customError
maxLength v =
    Attribute <| \attrs -> { attrs | maxLength = Just v }


{-| -}
pattern : String -> Attribute msg customError
pattern v =
    Attribute <| \attrs -> { attrs | pattern = Just v }


{-| -}
validation : (String -> Maybe customError) -> Attribute msg customError
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
mask : (String -> String) -> Attribute msg customError
mask v =
    Attribute <| \attrs -> { attrs | mask = Just v }


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


baseAttrs : Attributes msg customError -> List (H.Attribute msg)
baseAttrs attrs =
    attrs.htmlAttributes
        ++ [ HA.type_ (inputInputTypeToString attrs.type_)
           , HA.classList [ ( WI.baseClass, not attrs.unstyled ) ]
           , WI.maskClass attrs.mask
           , WH.attrIf attrs.readOnly HA.tabindex -1
           , HA.required attrs.required
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
           , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
           , WH.maybeAttr HA.placeholder attrs.placeholder
           , WH.maybeAttr HA.minlength attrs.minLength
           , WH.maybeAttr HA.maxlength attrs.maxLength
           , WH.maybeAttr HA.pattern attrs.pattern
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           ]


{-| -}
view :
    List (Attribute msg customError)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg customError
        attrs =
            applyAttrs attrs_
    in
    WI.view attrs
        (H.div [ HA.class "ew-group ew-w-full ew-relative" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value (limitString attrs.maxLength props.value)
                       , HE.onInput (props.onInput << limitString attrs.maxLength)
                       ]
                )
                []
            , WI.mask attrs.mask props.value
            ]
        )


{-| -}
viewWithValidation :
    List (Attribute msg customError)
    ->
        { value : String
        , onInput : Result (Error customError) String -> String -> msg
        }
    -> H.Html msg
viewWithValidation attrs_ props =
    let
        attrs : Attributes msg customError
        attrs =
            applyAttrs attrs_
    in
    WI.view attrs
        (H.div [ HA.class "ew-group ew-relative ew-w-full" ]
            [ H.input
                (baseAttrs attrs
                    ++ [ HA.value (limitString attrs.maxLength props.value)
                       , HE.on "input"
                            (D.map8
                                (\value__ valid patternMismatch typeMismatch tooLong tooShort valueMissing validationMessage ->
                                    let
                                        value_ : String
                                        value_ =
                                            limitString attrs.maxLength value__

                                        customError : Maybe customError
                                        customError =
                                            attrs.validation
                                                |> Maybe.map (\fn -> fn value_)
                                                |> Maybe.withDefault Nothing

                                        result : Result (Error customError) String
                                        result =
                                            if valid && customError == Nothing then
                                                Ok value_

                                            else if valueMissing then
                                                Err (ValueMissing validationMessage)

                                            else if tooShort then
                                                Err (TooShort (Maybe.withDefault 0 attrs.minLength) validationMessage)

                                            else if typeMismatch then
                                                Err (InputTypeMismatch attrs.type_ validationMessage)

                                            else if tooLong then
                                                Err (TooLong (Maybe.withDefault 0 attrs.maxLength) validationMessage)

                                            else if patternMismatch then
                                                Err (PatternMismatch validationMessage)

                                            else
                                                customError
                                                    |> Maybe.map (Err << Custom)
                                                    |> Maybe.withDefault (Ok value_)
                                    in
                                    props.onInput result value_
                                )
                                (D.at [ "target", "value" ] D.string)
                                (D.at [ "target", "validity", "valid" ] D.bool)
                                (D.at [ "target", "validity", "patternMismatch" ] D.bool)
                                (D.at [ "target", "validity", "typeMismatch" ] D.bool)
                                (D.at [ "target", "validity", "tooLong" ] D.bool)
                                (D.at [ "target", "validity", "tooShort" ] D.bool)
                                (D.at [ "target", "validity", "valueMissing" ] D.bool)
                                (D.at [ "target", "validationMessage" ] D.string)
                            )
                       ]
                )
                []
            , WI.mask attrs.mask props.value
            ]
        )


limitString : Maybe Int -> String -> String
limitString limit str =
    limit
        |> Maybe.map (\l -> String.left l str)
        |> Maybe.withDefault str
