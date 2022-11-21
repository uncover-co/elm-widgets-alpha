module W.Tooltip exposing
    ( view
    , slow, alwaysVisible
    , htmlAttrs, noAttr, Attribute
    )

{-|

@docs view


# Styles

@docs slow, alwaysVisible


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { htmlAttributes : List (H.Attribute msg)
    , slow : Bool
    , alwaysVisible : Bool
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { htmlAttributes = []
    , slow = False
    , alwaysVisible = False
    }



-- Attributes : Setters


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity


{-| -}
slow : Bool -> Attribute msg
slow v =
    Attribute <| \attrs -> { attrs | slow = v }


{-| -}
alwaysVisible : Bool -> Attribute msg
alwaysVisible v =
    Attribute <| \attrs -> { attrs | alwaysVisible = v }



-- Main


{-| -}
view :
    List (Attribute msg)
    ->
        { tooltip : List (H.Html msg)
        , children : List (H.Html msg)
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        tooltip : H.Html msg
        tooltip =
            H.span
                (attrs.htmlAttributes
                    ++ [ HA.class "ew-tooltip ew-absolute ew-pointer-events-none ew-bottom-full"
                       , HA.class "ew-mb-1"
                       , HA.class "ew-px-2 ew-py-1 ew-rounded"
                       , HA.class "ew-font-text ew-text-sm"
                       , HA.class "ew-bg-neutral-bg ew-text-neutral-aux"
                       , HA.class "ew-transition"
                       , HA.class "group-hover:ew-translate-y-0 group-hover:ew-opacity-100"
                       , HA.classList
                            [ ( "group-hover:ew-delay-500", not attrs.slow )
                            , ( "group-hover:ew-delay-1000", attrs.slow )
                            , ( "ew-translate-y-0.5 ew-opacity-0", not attrs.alwaysVisible )
                            ]
                       ]
                )
                props.tooltip
    in
    H.span []
        [ H.span
            [ HA.class "ew-group ew-relative ew-inline-flex ew-flex-col ew-items-center" ]
            (tooltip :: props.children)
        ]
