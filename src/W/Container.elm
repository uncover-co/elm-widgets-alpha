module W.Container exposing
    ( view
    , inline, rounded, extraRounded, background, shadow, largeShadow
    , largeScreen
    , pad_0, pad_1, pad_2, pad_3, pad_4, pad_6, pad_8, pad_12, pad_16
    , padX_0, padX_1, padX_2, padX_3, padX_4, padX_6, padX_8, padX_12, padX_16
    , padY_0, padY_1, padY_2, padY_3, padY_4, padY_6, padY_8, padY_12, padY_16
    , padLeft_0, padLeft_1, padLeft_2, padLeft_3, padLeft_4, padLeft_6, padLeft_8, padLeft_12, padLeft_16
    , padRight_0, padRight_1, padRight_2, padRight_3, padRight_4, padRight_6, padRight_8, padRight_12, padRight_16
    , padTop_0, padTop_1, padTop_2, padTop_3, padTop_4, padTop_6, padTop_8, padTop_12, padTop_16
    , padBottom_0, padBottom_1, padBottom_2, padBottom_3, padBottom_4, padBottom_6, padBottom_8, padBottom_12, padBottom_16
    , spaceX_0, spaceX_1, spaceX_2, spaceX_4, spaceX_6, spaceX_8, spaceX_12, spaceX_16
    , spaceY_0, spaceY_1, spaceY_2, spaceY_4, spaceY_6, spaceY_8, spaceY_12, spaceY_16
    , node, noAttr, htmlAttrs, Attribute
    )

{-|

@docs view


# Styles

@docs inline, rounded, extraRounded, background, shadow, largeShadow


# Responsive

@docs largeScreen


# Padding

@docs pad_0, pad_1, pad_2, pad_3, pad_4, pad_6, pad_8, pad_12, pad_16
@docs padX_0, padX_1, padX_2, padX_3, padX_4, padX_6, padX_8, padX_12, padX_16
@docs padY_0, padY_1, padY_2, padY_3, padY_4, padY_6, padY_8, padY_12, padY_16
@docs padLeft_0, padLeft_1, padLeft_2, padLeft_3, padLeft_4, padLeft_6, padLeft_8, padLeft_12, padLeft_16
@docs padRight_0, padRight_1, padRight_2, padRight_3, padRight_4, padRight_6, padRight_8, padRight_12, padRight_16
@docs padTop_0, padTop_1, padTop_2, padTop_3, padTop_4, padTop_6, padTop_8, padTop_12, padTop_16
@docs padBottom_0, padBottom_1, padBottom_2, padBottom_3, padBottom_4, padBottom_6, padBottom_8, padBottom_12, padBottom_16


# Spacing

@docs spaceX_0, spaceX_1, spaceX_2, spaceX_4, spaceX_6, spaceX_8, spaceX_12, spaceX_16
@docs spaceY_0, spaceY_1, spaceY_2, spaceY_4, spaceY_6, spaceY_8, spaceY_12, spaceY_16


# Html

@docs node, noAttr, htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import Theme



-- Main


{-| -}
view : List (Attribute msg) -> List (H.Html msg) -> H.Html msg
view attrs_ children =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        displayClass : String
        displayClass =
            if attrs.inline then
                "ew-inline-block"

            else
                "ew-block"

        backgroundAttr : H.Attribute msg
        backgroundAttr =
            case attrs.background of
                Just background_ ->
                    Theme.styles [ ( "background", background_ ) ]

                Nothing ->
                    HA.class ""
    in
    H.node
        attrs.node
        (attrs.htmlAttributes
            ++ [ HA.class attrs.class
               , HA.class displayClass
               , backgroundAttr
               ]
        )
        children



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { node : String
    , class : String
    , background : Maybe String
    , inline : Bool
    , htmlAttributes : List (H.Attribute msg)
    }


defaultAttrs : Attributes msg
defaultAttrs =
    { node = "div"
    , class = ""
    , background = Nothing
    , inline = False
    , htmlAttributes = []
    }



-- Attributes : Helpers


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


{-| -}
node : String -> Attribute msg
node v =
    Attribute (\attr -> { attr | node = v })


{-| -}
inline : Attribute msg
inline =
    Attribute (\attr -> { attr | inline = True })


{-| -}
background : String -> Attribute msg
background v =
    Attribute (\attr -> { attr | background = Just v })


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute (\attr -> { attr | htmlAttributes = v })



-- Responsive


{-| -}
largeScreen : List (Attribute msg) -> Attribute msg
largeScreen largeAttr_ =
    Attribute
        (\attr ->
            let
                largeAttr : Attributes msg
                largeAttr =
                    applyAttrs largeAttr_

                padding : String
                padding =
                    largeAttr.class
                        |> String.replace " " " lg:"
            in
            { attr | class = attr.class ++ " " ++ padding }
        )



{- Space & Padding - Tailwind Dynamic Class Setup

   lg:ew-space-x-0 lg:ew-space-x-1 lg:ew-space-x-2 lg:ew-space-x-4 lg:ew-space-x-6 lg:ew-space-x-8 lg:ew-space-x-12 lg:ew-space-x-16
   lg:ew-space-y-0 lg:ew-space-y-1 lg:ew-space-y-2 lg:ew-space-y-4 lg:ew-space-y-6 lg:ew-space-y-8 lg:ew-space-y-12 lg:ew-space-y-16

   lg:ew-p-0   lg:ew-p-1   lg:ew-p-2  lg:ew-p-3   lg:ew-p-4   lg:ew-p-6  lg:ew-p-8   lg:ew-p-12   lg:ew-p-16
   lg:ew-px-0  lg:ew-px-1  lg:ew-px-2 lg:ew-px-3  lg:ew-px-4  lg:ew-px-6 lg:ew-px-8  lg:ew-px-12  lg:ew-px-16
   lg:ew-py-0  lg:ew-py-1  lg:ew-py-2 lg:ew-py-3  lg:ew-py-4  lg:ew-py-6 lg:ew-py-8  lg:ew-py-12  lg:ew-py-16
   lg:ew-pt-0  lg:ew-pt-1  lg:ew-pt-2 lg:ew-pt-3  lg:ew-pt-4  lg:ew-pt-6 lg:ew-pt-8  lg:ew-pt-12  lg:ew-pt-16
   lg:ew-pl-0  lg:ew-pl-1  lg:ew-pl-2 lg:ew-pl-3  lg:ew-pl-4  lg:ew-pl-6 lg:ew-pl-8  lg:ew-pl-12  lg:ew-pl-16
   lg:ew-pr-0  lg:ew-pr-1  lg:ew-pr-2 lg:ew-pr-3  lg:ew-pr-4  lg:ew-pr-6 lg:ew-pr-8  lg:ew-pr-12  lg:ew-pr-16
   lg:ew-pl-0  lg:ew-pl-1  lg:ew-pl-2 lg:ew-pl-3  lg:ew-pl-4  lg:ew-pl-6 lg:ew-pl-8  lg:ew-pl-12  lg:ew-pl-16

-}


addClass : String -> Attribute msg
addClass class =
    Attribute (\attr -> { attr | class = attr.class ++ " " ++ class })


{-| -}
spaceX_0 : Attribute msg
spaceX_0 =
    addClass "ew-space-x-0"


{-| -}
spaceX_1 : Attribute msg
spaceX_1 =
    addClass "ew-space-x-1"


{-| -}
spaceX_2 : Attribute msg
spaceX_2 =
    addClass "ew-space-x-2"


{-| -}
spaceX_4 : Attribute msg
spaceX_4 =
    addClass "ew-space-x-4"


{-| -}
spaceX_6 : Attribute msg
spaceX_6 =
    addClass "ew-space-x-6"


{-| -}
spaceX_8 : Attribute msg
spaceX_8 =
    addClass "ew-space-x-8"


{-| -}
spaceX_12 : Attribute msg
spaceX_12 =
    addClass "ew-space-x-12"


{-| -}
spaceX_16 : Attribute msg
spaceX_16 =
    addClass "ew-space-x-16"


{-| -}
spaceY_0 : Attribute msg
spaceY_0 =
    addClass "ew-space-y-0"


{-| -}
spaceY_1 : Attribute msg
spaceY_1 =
    addClass "ew-space-y-1"


{-| -}
spaceY_2 : Attribute msg
spaceY_2 =
    addClass "ew-space-y-2"


{-| -}
spaceY_4 : Attribute msg
spaceY_4 =
    addClass "ew-space-y-4"


{-| -}
spaceY_6 : Attribute msg
spaceY_6 =
    addClass "ew-space-y-6"


{-| -}
spaceY_8 : Attribute msg
spaceY_8 =
    addClass "ew-space-y-8"


{-| -}
spaceY_12 : Attribute msg
spaceY_12 =
    addClass "ew-space-y-12"


{-| -}
spaceY_16 : Attribute msg
spaceY_16 =
    addClass "ew-space-y-16"


{-| -}
pad_0 : Attribute msg
pad_0 =
    addClass "ew-p-0"


{-| -}
pad_1 : Attribute msg
pad_1 =
    addClass "ew-p-1"


{-| -}
pad_2 : Attribute msg
pad_2 =
    addClass "ew-p-2"


{-| -}
pad_3 : Attribute msg
pad_3 =
    addClass "ew-p-3"


{-| -}
pad_4 : Attribute msg
pad_4 =
    addClass "ew-p-4"


{-| -}
pad_6 : Attribute msg
pad_6 =
    addClass "ew-p-6"


{-| -}
pad_8 : Attribute msg
pad_8 =
    addClass "ew-p-8"


{-| -}
pad_12 : Attribute msg
pad_12 =
    addClass "ew-p-12"


{-| -}
pad_16 : Attribute msg
pad_16 =
    addClass "ew-p-16"


{-| -}
padX_0 : Attribute msg
padX_0 =
    addClass "ew-px-0"


{-| -}
padX_1 : Attribute msg
padX_1 =
    addClass "ew-px-1"


{-| -}
padX_2 : Attribute msg
padX_2 =
    addClass "ew-px-2"


{-| -}
padX_3 : Attribute msg
padX_3 =
    addClass "ew-px-3"


{-| -}
padX_4 : Attribute msg
padX_4 =
    addClass "ew-px-4"


{-| -}
padX_6 : Attribute msg
padX_6 =
    addClass "ew-px-6"


{-| -}
padX_8 : Attribute msg
padX_8 =
    addClass "ew-px-8"


{-| -}
padX_12 : Attribute msg
padX_12 =
    addClass "ew-px-12"


{-| -}
padX_16 : Attribute msg
padX_16 =
    addClass "ew-px-16"


{-| -}
padY_0 : Attribute msg
padY_0 =
    addClass "ew-py-0"


{-| -}
padY_1 : Attribute msg
padY_1 =
    addClass "ew-py-1"


{-| -}
padY_2 : Attribute msg
padY_2 =
    addClass "ew-py-2"


{-| -}
padY_3 : Attribute msg
padY_3 =
    addClass "ew-py-3"


{-| -}
padY_4 : Attribute msg
padY_4 =
    addClass "ew-py-4"


{-| -}
padY_6 : Attribute msg
padY_6 =
    addClass "ew-py-6"


{-| -}
padY_8 : Attribute msg
padY_8 =
    addClass "ew-py-8"


{-| -}
padY_12 : Attribute msg
padY_12 =
    addClass "ew-py-12"


{-| -}
padY_16 : Attribute msg
padY_16 =
    addClass "ew-py-16"


{-| -}
padTop_0 : Attribute msg
padTop_0 =
    addClass "ew-pt-0"


{-| -}
padTop_1 : Attribute msg
padTop_1 =
    addClass "ew-pt-1"


{-| -}
padTop_2 : Attribute msg
padTop_2 =
    addClass "ew-pt-2"


{-| -}
padTop_3 : Attribute msg
padTop_3 =
    addClass "ew-pt-3"


{-| -}
padTop_4 : Attribute msg
padTop_4 =
    addClass "ew-pt-4"


{-| -}
padTop_6 : Attribute msg
padTop_6 =
    addClass "ew-pt-6"


{-| -}
padTop_8 : Attribute msg
padTop_8 =
    addClass "ew-pt-8"


{-| -}
padTop_12 : Attribute msg
padTop_12 =
    addClass "ew-pt-12"


{-| -}
padTop_16 : Attribute msg
padTop_16 =
    addClass "ew-pt-16"


{-| -}
padLeft_0 : Attribute msg
padLeft_0 =
    addClass "ew-pl-0"


{-| -}
padLeft_1 : Attribute msg
padLeft_1 =
    addClass "ew-pl-1"


{-| -}
padLeft_2 : Attribute msg
padLeft_2 =
    addClass "ew-pl-2"


{-| -}
padLeft_3 : Attribute msg
padLeft_3 =
    addClass "ew-pl-3"


{-| -}
padLeft_4 : Attribute msg
padLeft_4 =
    addClass "ew-pl-4"


{-| -}
padLeft_6 : Attribute msg
padLeft_6 =
    addClass "ew-pl-6"


{-| -}
padLeft_8 : Attribute msg
padLeft_8 =
    addClass "ew-pl-8"


{-| -}
padLeft_12 : Attribute msg
padLeft_12 =
    addClass "ew-pl-12"


{-| -}
padLeft_16 : Attribute msg
padLeft_16 =
    addClass "ew-pl-16"


{-| -}
padRight_0 : Attribute msg
padRight_0 =
    addClass "ew-pr-0"


{-| -}
padRight_1 : Attribute msg
padRight_1 =
    addClass "ew-pr-1"


{-| -}
padRight_2 : Attribute msg
padRight_2 =
    addClass "ew-pr-2"


{-| -}
padRight_3 : Attribute msg
padRight_3 =
    addClass "ew-pr-3"


{-| -}
padRight_4 : Attribute msg
padRight_4 =
    addClass "ew-pr-4"


{-| -}
padRight_6 : Attribute msg
padRight_6 =
    addClass "ew-pr-6"


{-| -}
padRight_8 : Attribute msg
padRight_8 =
    addClass "ew-pr-8"


{-| -}
padRight_12 : Attribute msg
padRight_12 =
    addClass "ew-pr-12"


{-| -}
padRight_16 : Attribute msg
padRight_16 =
    addClass "ew-pr-16"


{-| -}
padBottom_0 : Attribute msg
padBottom_0 =
    addClass "ew-pb-0"


{-| -}
padBottom_1 : Attribute msg
padBottom_1 =
    addClass "ew-pb-1"


{-| -}
padBottom_2 : Attribute msg
padBottom_2 =
    addClass "ew-pb-2"


{-| -}
padBottom_3 : Attribute msg
padBottom_3 =
    addClass "ew-pb-3"


{-| -}
padBottom_4 : Attribute msg
padBottom_4 =
    addClass "ew-pb-4"


{-| -}
padBottom_6 : Attribute msg
padBottom_6 =
    addClass "ew-pb-6"


{-| -}
padBottom_8 : Attribute msg
padBottom_8 =
    addClass "ew-pb-8"


{-| -}
padBottom_12 : Attribute msg
padBottom_12 =
    addClass "ew-pb-12"


{-| -}
padBottom_16 : Attribute msg
padBottom_16 =
    addClass "ew-pb-16"


{-| -}
rounded : Attribute msg
rounded =
    addClass "ew-rounded"


{-| -}
extraRounded : Attribute msg
extraRounded =
    addClass "ew-rounded-lg"


{-| -}
shadow : Attribute msg
shadow =
    addClass "ew-shadow"


{-| -}
largeShadow : Attribute msg
largeShadow =
    addClass "ew-shadow-lg"
