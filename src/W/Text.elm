module W.Text exposing (color, extraLarge, inline, large, light, noAttr, small, view)

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
    , color : String
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { element = "p"
    , fontSize = "ew-text-base"
    , color = Theme.baseForeground
    }



-- Attributes : Setters


inline : Attribute msg
inline =
    Attribute (\attrs -> { attrs | element = "span" })


light : Attribute msg
light =
    Attribute (\attrs -> { attrs | color = Theme.baseAux })


small : Attribute msg
small =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-sm" })


large : Attribute msg
large =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-xl" })


extraLarge : Attribute msg
extraLarge =
    Attribute (\attrs -> { attrs | fontSize = "ew-text-2xl" })


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
        , WH.styles
            [ ( "color", attrs.color )
            ]
        ]
        children
