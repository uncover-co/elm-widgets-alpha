module W.Card exposing
    ( view
    , background, notRounded, extraRounded, noShadow, largeShadow
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Styles

@docs background, notRounded, extraRounded, noShadow, largeShadow


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Theme



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { background : String
    , borderRadiusClass : String
    , shadowClass : String
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { background = Theme.baseBackground
    , borderRadiusClass = "ew-rounded"
    , shadowClass = "ew-shadow-md"
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
background : String -> Attribute msg
background v =
    Attribute (\attrs -> { attrs | background = v })


{-| -}
noShadow : Attribute msg
noShadow =
    Attribute (\attrs -> { attrs | shadowClass = "" })


{-| -}
largeShadow : Attribute msg
largeShadow =
    Attribute (\attrs -> { attrs | shadowClass = "ew-shadow-lg" })


{-| -}
notRounded : Attribute msg
notRounded =
    Attribute (\attrs -> { attrs | borderRadiusClass = "" })


{-| -}
extraRounded : Attribute msg
extraRounded =
    Attribute (\attrs -> { attrs | borderRadiusClass = "ew-rounded-lg" })


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute (\attrs -> { attrs | htmlAttributes = v })


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity



-- Main


{-| -}
view : List (Attribute msg) -> List (H.Html msg) -> H.Html msg
view attrs_ children =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    H.div
        (attrs.htmlAttributes
            ++ [ HA.class "ew-border ew-border-solid ew-border-base-fg/[0.03]"
               , HA.class attrs.shadowClass
               , HA.class attrs.borderRadiusClass
               , HA.attribute "style" ("background:" ++ attrs.background)
               ]
        )
        children
