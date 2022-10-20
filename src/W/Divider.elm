module W.Divider exposing
    ( view
    , vertical, margins
    )

{-|

@docs view
@docs vertical, margins

-}

import Html as H
import Html.Attributes as HA



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes -> Attributes)


type alias Attributes =
    { vertical : Bool
    , margins : Int
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { vertical = False
    , margins = 8
    }



-- Attributes : Setters


{-| -}
vertical : Attribute msg
vertical =
    Attribute (\attrs -> { attrs | vertical = True })


{-| -}
margins : Int -> Attribute msg
margins v =
    Attribute (\attrs -> { attrs | margins = v })



-- Main


{-| -}
view : List (Attribute msg) -> List (H.Html msg) -> H.Html msg
view attrs_ children =
    let
        attrs : Attributes
        attrs =
            applyAttrs attrs_
    in
    if List.isEmpty children then
        H.hr
            [ HA.class "ew-self-stretch ew-border-base-aux/20 ew-border-solid ew-border-0 ew-m-0 ew-outline-0 ew-shadow-none ew-appearance-none"
            , HA.style "margin"
                (if attrs.vertical then
                    "0 " ++ String.fromInt attrs.margins ++ "px"

                 else
                    String.fromInt attrs.margins ++ "px 0"
                )
            , HA.classList
                [ ( "ew-border-t-2", not attrs.vertical )
                , ( "ew-border-l-2", attrs.vertical )
                ]
            ]
            []

    else
        H.div
            [ HA.class "ew-self-stretch ew-flex ew-items-center ew-justify-center ew-gap-1.5 ew-leading-none"
            , HA.class "ew-font-text ew-text-sm ew-text-base-fg"
            , HA.class "before:ew-content-[''] before:ew-block before:ew-grow before:ew-bg-base-aux/20"
            , HA.class "after:ew-content-[''] after:ew-block after:ew-grow after:ew-bg-base-aux/20"
            , if attrs.vertical then
                HA.style "width" (String.fromInt (attrs.margins * 2 + 2) ++ "px")

              else
                HA.style "height" (String.fromInt (attrs.margins * 2 + 2) ++ "px")
            , HA.classList
                [ ( "before:ew-h-0.5 after:ew-h-0.5", not attrs.vertical )
                , ( "ew-flex-col before:ew-w-0.5 after:ew-w-0.5", attrs.vertical )
                ]
            ]
            children
