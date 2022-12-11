module W.Heading exposing
    ( view
    , primary, secondary, neutral, color
    , small, large, extraLarge
    , h2, h3, h4, h5, h6
    , alignLeft, alignRight, alignCenter
    , noAttr, Attribute
    )

{-|

@docs view


# Colors

@docs primary, secondary, neutral, color


# Sizes

@docs small, large, extraLarge


# Semantic

@docs h2, h3, h4, h5, h6


# Alignment

@docs alignLeft, alignRight, alignCenter


# Html

@docs noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Theme
import W.Internal.Helpers as WH



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes -> Attributes)


type alias Attributes =
    { element : String
    , fontSize : String
    , fontFamily : String
    , textAlign : String
    , color : String
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { element = "h1"
    , fontSize = "ew-text-2xl"
    , fontFamily = "ew-font-heading"
    , textAlign = "ew-text-left"
    , color = Theme.baseForeground
    }



-- Attributes : Setters


{-| -}
h2 : Attribute msg
h2 =
    Attribute (\attrs -> { attrs | element = "h2" })


{-| -}
h3 : Attribute msg
h3 =
    Attribute (\attrs -> { attrs | element = "h3" })


{-| -}
h4 : Attribute msg
h4 =
    Attribute (\attrs -> { attrs | element = "h4" })


{-| -}
h5 : Attribute msg
h5 =
    Attribute (\attrs -> { attrs | element = "h5" })


{-| -}
h6 : Attribute msg
h6 =
    Attribute (\attrs -> { attrs | element = "h6" })


{-| -}
small : Attribute msg
small =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-xl" })


{-| -}
large : Attribute msg
large =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-4xl" })


{-| -}
extraLarge : Attribute msg
extraLarge =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-5xl" })


{-| -}
alignLeft : Attribute msg
alignLeft =
    Attribute (\attrs -> { attrs | textAlign = "ew-text-left" })


{-| -}
alignCenter : Attribute msg
alignCenter =
    Attribute (\attrs -> { attrs | textAlign = "ew-text-center" })


{-| -}
alignRight : Attribute msg
alignRight =
    Attribute (\attrs -> { attrs | textAlign = "ew-text-right" })


{-| -}
color : String -> Attribute msg
color v =
    Attribute (\attrs -> { attrs | color = v })


{-| -}
primary : Attribute msg
primary =
    Attribute (\attrs -> { attrs | color = Theme.primaryForeground })


{-| -}
secondary : Attribute msg
secondary =
    Attribute (\attrs -> { attrs | color = Theme.secondaryForeground })


{-| -}
neutral : Attribute msg
neutral =
    Attribute (\attrs -> { attrs | color = Theme.neutralForeground })


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity



-- Main


{-| -}
view : List (Attribute msg) -> List (H.Html msg) -> H.Html msg
view attrs_ children =
    let
        attrs : Attributes
        attrs =
            applyAttrs attrs_
    in
    H.node attrs.element
        [ HA.class "ew-m-0"
        , HA.class attrs.fontSize
        , HA.class attrs.fontFamily
        , HA.class attrs.textAlign
        , WH.styles
            [ ( "color", attrs.color )
            ]
        ]
        children
