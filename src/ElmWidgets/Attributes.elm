module ElmWidgets.Attributes exposing
    ( color, background, shadow
    , href, onClick, onBlur, onFocus, onEnter
    , size, fill, vertical, alignRight, absolute
    , footer, header, left
    , readOnly, disabled, required, placeholder, pattern, hint, success, warning, danger
    , none, id, htmlAttrs
    )

{-|


## Colors

@docs color, background, shadow


## Actions

@docs href, onClick, onBlur, onFocus, onEnter


## Layout

@docs size, fill, vertical, alignRight, absolute


## Content

@docs footer, header, left


## Forms

@docs readOnly, disabled, required, placeholder, pattern, hint, success, warning, danger


## General

@docs none, id, htmlAttrs

-}

import Html as H



-- Colors


{-| -}
color : String -> { a | color : String } -> { a | color : String }
color v a =
    { a | color = v }


{-| -}
background : String -> { a | background : String } -> { a | background : String }
background v a =
    { a | background = v }


{-| -}
shadow : String -> { a | shadow : String } -> { a | shadow : String }
shadow v a =
    { a | shadow = v }



-- Layout


{-| -}
absolute : Bool -> { a | absolute : Bool } -> { a | absolute : Bool }
absolute v a =
    { a | absolute = v }


{-| -}
size : Float -> { a | size : Float } -> { a | size : Float }
size v a =
    { a | size = v }


{-| -}
fill : Bool -> { a | fill : Bool } -> { a | fill : Bool }
fill v a =
    { a | fill = v }


{-| -}
vertical : Bool -> { a | vertical : Bool } -> { a | vertical : Bool }
vertical v a =
    { a | vertical = v }


{-| -}
alignRight : Bool -> { a | alignRight : Bool } -> { a | alignRight : Bool }
alignRight v a =
    { a | alignRight = v }



-- Actions


{-| -}
href : String -> { a | href : Maybe String } -> { a | href : Maybe String }
href v a =
    { a | href = Just v }


{-| -}
onClick : msg -> { a | onClick : Maybe msg } -> { a | onClick : Maybe msg }
onClick v a =
    { a | onClick = Just v }


{-| -}
onFocus : msg -> { a | onFocus : Maybe msg } -> { a | onFocus : Maybe msg }
onFocus v a =
    { a | onFocus = Just v }


{-| -}
onBlur : msg -> { a | onBlur : Maybe msg } -> { a | onBlur : Maybe msg }
onBlur v a =
    { a | onBlur = Just v }


{-| -}
onEnter : msg -> { a | onEnter : Maybe msg } -> { a | onEnter : Maybe msg }
onEnter v a =
    { a | onEnter = Just v }



-- Content


{-| -}
footer : H.Html msg -> { a | footer : Maybe (H.Html msg) } -> { a | footer : Maybe (H.Html msg) }
footer v a =
    { a | footer = Just v }


{-| -}
header : H.Html msg -> { a | header : Maybe (H.Html msg) } -> { a | header : Maybe (H.Html msg) }
header v a =
    { a | header = Just v }


{-| -}
left : H.Html msg -> { a | left : Maybe (H.Html msg) } -> { a | left : Maybe (H.Html msg) }
left v a =
    { a | left = Just v }



-- Forms


{-| -}
required : Bool -> { a | required : Bool } -> { a | required : Bool }
required v a =
    { a | required = v }


{-| -}
disabled : Bool -> { a | disabled : Bool } -> { a | disabled : Bool }
disabled v a =
    { a | disabled = v }


{-| -}
readOnly : Bool -> { a | readOnly : Bool } -> { a | readOnly : Bool }
readOnly v a =
    { a | readOnly = v }


{-| -}
placeholder : String -> { a | placeholder : Maybe String } -> { a | placeholder : Maybe String }
placeholder v a =
    { a | placeholder = Just v }


{-| -}
pattern : String -> { a | pattern : Maybe String } -> { a | pattern : Maybe String }
pattern v a =
    { a | pattern = Just v }


{-| -}
hint : String -> { a | hint : Maybe String } -> { a | hint : Maybe String }
hint v a =
    { a | hint = Just v }


{-| -}
success : String -> { a | success : Maybe String } -> { a | success : Maybe String }
success v a =
    { a | success = Just v }


{-| -}
warning : String -> { a | warning : Maybe String } -> { a | warning : Maybe String }
warning v a =
    { a | warning = Just v }


{-| -}
danger : String -> { a | danger : Maybe String } -> { a | danger : Maybe String }
danger v a =
    { a | danger = Just v }



-- General


{-| -}
none : a -> a
none =
    identity


{-| -}
id : String -> { a | id : Maybe String } -> { a | id : Maybe String }
id v a =
    { a | id = Just v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> { a | htmlAttrs : List (H.Attribute msg) } -> { a | htmlAttrs : List (H.Attribute msg) }
htmlAttrs v a =
    { a | htmlAttrs = v }
