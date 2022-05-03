module W.InputDate exposing
    ( viewTime, viewDate, viewDateTime
    , min, max
    , id, class, disabled, required, readOnly
    , onEnter, onFocus, onBlur
    , htmlAttrs, Attribute
    )

{-|

@docs viewTime, viewDate, viewDateTime
@docs min, max
@docs id, class, disabled, required, readOnly
@docs onEnter, onFocus, onBlur
@docs htmlAttrs, Attribute

-}

import Date
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import Time
import Time.Extra
import W.Internal.Helpers as WH



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
min : Time.Posix -> Attribute msg
min v =
    Attribute <| \attrs -> { attrs | min = Just v }


{-| -}
max : Time.Posix -> Attribute msg
max v =
    Attribute <| \attrs -> { attrs | min = Just v }


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


attributes : Attributes msg -> List (H.Attribute msg)
attributes attrs =
    attrs.htmlAttributes
        ++ [ WH.maybeAttr HA.id attrs.id
           , HA.class "ew ew-input ew-focusable"
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           ]



-- Main


viewTime :
    List (Attribute msg)
    ->
        { onInput : Int -> msg
        , value : Int
        }
    -> H.Html msg
viewTime attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.input
        ([ HA.type_ "time"
         , HA.value (String.fromInt props.value)
         , HE.onInput (Debug.todo "")
         ]
            ++ attributes attrs
        )
        []


viewDate :
    List (Attribute msg)
    ->
        { onInput : Maybe Time.Posix -> msg
        , value : Maybe Time.Posix
        }
    -> H.Html msg
viewDate attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        value : String
        value =
            props.value
                |> Maybe.map
                    (\timestamp ->
                        timestamp
                            |> Date.fromPosix attrs.timeZone
                            |> Date.format "yyyy-MM-dd"
                    )
                |> Maybe.withDefault ""

        decoder : D.Decoder msg
        decoder =
            D.oneOf
                [ D.field "target" (D.field "valueAsNumber" D.int)
                    |> D.andThen
                        (\v_ ->
                            let
                                v : Int
                                v =
                                    v_ + Time.Extra.toOffset attrs.timeZone (Time.millisToPosix v_)
                            in
                            case ( Maybe.map Time.posixToMillis attrs.min, Maybe.map Time.posixToMillis attrs.max ) of
                                ( Just min_, Just max_ ) ->
                                    if v >= min_ && v < max_ then
                                        D.succeed (Time.millisToPosix v)

                                    else
                                        D.fail <| "Timestamp should be between " ++ String.fromInt min_ ++ " and " ++ String.fromInt max_

                                ( Just min_, Nothing ) ->
                                    if v >= min_ then
                                        D.succeed (Time.millisToPosix v)

                                    else
                                        D.fail <| "Timestamp should be after than " ++ String.fromInt min_

                                ( Nothing, Just max_ ) ->
                                    if v < max_ then
                                        D.succeed (Time.millisToPosix v)

                                    else
                                        D.fail <| "Timestamp should be before than " ++ String.fromInt max_

                                ( Nothing, Nothing ) ->
                                    D.succeed (Time.millisToPosix v)
                        )
                    |> D.map Just
                , D.succeed Nothing
                ]
                |> D.map props.onInput
    in
    H.input
        ([ HA.type_ "date"
         , HA.value value
         , HE.on "input" decoder
         ]
            ++ attributes attrs
        )
        []


viewDateTime :
    List (Attribute msg)
    ->
        { onInput : Float -> msg
        , value : Float
        }
    -> H.Html msg
viewDateTime attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.input
        ([ HA.type_ "datetime-local"
         , HA.value (String.fromFloat props.value)
         , HE.onInput (Debug.todo "")
         ]
            ++ attributes attrs
        )
        []



-- validationMessage
-- validity.badInput
-- validity.customError
-- validity.patternMismatch
-- validity.rangeOverflow
-- validity.rangeUnderflow
-- validity.stepMismatch
-- validity.tooLong
-- validity.tooShort
-- validity.typeMismatch
-- validity.valid
-- validity.valueMissing
