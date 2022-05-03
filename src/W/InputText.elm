module W.InputText exposing
    ( view, viewTextArea, viewPassword, viewEmail, viewUrl, viewSearch
    , id, class, placeholder, disabled, required, readOnly, pattern
    , onEnter, onFocus, onBlur
    , htmlAttrs, Attribute
    , resizable, rows
    )

{-|

@docs view, viewTextArea, viewPassword, viewEmail, viewUrl, viewSearch
@docs id, class, placeholder, disabled, required, readOnly, pattern
@docs onEnter, onFocus, onBlur
@docs htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
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
    , resizable : Bool
    , rows : Int
    , pattern : Maybe String
    , placeholder : Maybe String
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
    , resizable = False
    , rows = 4
    , pattern = Nothing
    , placeholder = Nothing
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
resizable : Bool -> Attribute msg
resizable v =
    Attribute <| \attrs -> { attrs | resizable = v }


{-| -}
rows : Int -> Attribute msg
rows v =
    Attribute <| \attrs -> { attrs | rows = v }


{-| -}
pattern : String -> Attribute msg
pattern v =
    Attribute <| \attrs -> { attrs | pattern = Just v }


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


attributes_ : Attributes msg -> { value : String, onInput : String -> msg } -> List (H.Attribute msg)
attributes_ attrs props =
    attrs.htmlAttributes
        ++ [ WH.maybeAttr HA.id attrs.id
           , HA.class "ew ew-input ew-focusable"
           , HA.disabled attrs.disabled
           , HA.readonly attrs.readOnly
           , HA.value props.value
           , HE.onInput props.onInput
           , WH.maybeAttr HA.placeholder attrs.placeholder
           , WH.maybeAttr HA.pattern attrs.pattern
           , WH.maybeAttr HE.onFocus attrs.onFocus
           , WH.maybeAttr HE.onBlur attrs.onBlur
           , WH.maybeAttr WH.onEnter attrs.onEnter
           ]


attributes :
    List (Attribute msg)
    -> { value : String, onInput : String -> msg }
    -> List (H.Attribute msg)
attributes attrs_ props =
    attributes_ (applyAttrs attrs_) props


view :
    List (Attribute msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
view attrs_ props =
    H.input (attributes attrs_ props) []


viewTextArea :
    List (Attribute msg)
    ->
        { value : String
        , onInput : String -> msg
        }
    -> H.Html msg
viewTextArea attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        resizeStyle : String
        resizeStyle =
            WH.stringIf attrs.resizable "vertical" "none"
    in
    H.textarea
        (HA.style "resize" resizeStyle
            :: HA.rows attrs.rows
            :: attributes_ attrs props
        )
        []


viewEmail :
    List (Attribute msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
viewEmail attrs_ props =
    H.input (HA.type_ "email" :: attributes attrs_ props) []


viewPassword :
    List (Attribute msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
viewPassword attrs_ props =
    H.input (HA.type_ "password" :: attributes attrs_ props) []


viewUrl :
    List (Attribute msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
viewUrl attrs_ props =
    H.input (HA.type_ "url" :: attributes attrs_ props) []


viewSearch :
    List (Attribute msg)
    ->
        { onInput : String -> msg
        , value : String
        }
    -> H.Html msg
viewSearch attrs_ props =
    H.input (HA.type_ "search" :: attributes attrs_ props) []



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
