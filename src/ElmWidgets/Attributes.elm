module ElmWidgets.Attributes exposing
    ( color, background, shadow
    , fill, vertical, alignRight
    , footer
    , required, disabled, placeholder, pattern, hint, success, warning, danger
    , none, id, htmlAttrs
    , absolute, size
    )

{-|


## Colors

@docs color, background, shadow


## Layout

@docs fill, vertical, alignRight


## Content

@docs footer


## Forms

@docs required, disabled, placeholder, pattern, hint, success, warning, danger


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



-- Content


{-| -}
footer : H.Html msg -> { a | footer : Maybe (H.Html msg) } -> { a | footer : Maybe (H.Html msg) }
footer v a =
    { a | footer = Just v }



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
