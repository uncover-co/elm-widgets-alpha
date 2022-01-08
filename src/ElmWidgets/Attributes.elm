module ElmWidgets.Attributes exposing
    ( color, background, shadow
    , fill, vertical, alignRight
    , disabled, placeholder, pattern, required
    , htmlAttrs
    )

{-|


## Colors

@docs color, background, shadow


## Layout

@docs fill, vertical, alignRight


## Forms

@docs disabled, placeholder, pattern, required


## General

@docs htmlAttrs

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



-- Forms


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
required : Bool -> { a | required : Bool } -> { a | required : Bool }
required v a =
    { a | required = v }



-- General


{-| -}
htmlAttrs : List (H.Attribute msg) -> { a | htmlAttrs : List (H.Attribute msg) } -> { a | htmlAttrs : List (H.Attribute msg) }
htmlAttrs v a =
    { a | htmlAttrs = v }
