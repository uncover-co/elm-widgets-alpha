module W.Text exposing
    ( view
    , inline, light, color, small, large, extraLarge
    , alignLeft, alignRight, alignCenter
    , noAttr, Attribute
    )

{-|

@docs view


# Styles

@docs inline, light, color, small, large, extraLarge


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
    , textAlign : String
    , color : String
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { element = "p"
    , fontSize = "ew-text-base"
    , textAlign = "ew-text-left"
    , color = Theme.baseForeground
    }



-- Attributes : Setters


{-| -}
inline : Attribute msg
inline =
    Attribute (\attrs -> { attrs | element = "span" })


{-| -}
light : Attribute msg
light =
    Attribute (\attrs -> { attrs | color = Theme.baseAux })


{-| -}
small : Attribute msg
small =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-sm" })


{-| -}
large : Attribute msg
large =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-xl" })


{-| -}
extraLarge : Attribute msg
extraLarge =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-2xl" })


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
        [ HA.class "ew-font-text ew-m-0"
        , HA.class attrs.fontSize
        , HA.class attrs.textAlign
        , WH.styles
            [ ( "color", attrs.color )
            ]
        ]
        children
