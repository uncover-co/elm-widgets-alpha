module W.Popover exposing
    ( view
    , top, topRight, bottomRight, left, leftBottom, right, rightBottom
    , over, offset
    , id, class, full, htmlAttrs, Attribute, Position
    )

{-|

@docs view
@docs top, topRight, bottomRight, left, leftBottom, right, rightBottom
@docs over, offset
@docs id, class, full, htmlAttrs, Attribute, Position

-}

import Html as H
import Html.Attributes as HA
import W.Internal.Helpers as WH



-- Placement


{-| TODO: Unexpose this type.
-}
type Position
    = TopLeft
    | TopRight
    | LeftTop
    | LeftBottom
    | RightTop
    | RightBottom
    | BottomLeft
    | BottomRight



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , position : Position
    , offset : Float
    , full : Bool
    , over : Bool
    , unstyled : Bool
    , class : String
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { id = Nothing
    , position = BottomLeft
    , offset = 0
    , full = False
    , over = False
    , unstyled = False
    , class = ""
    , htmlAttributes = []
    }



-- Attributes : Setters


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
class : String -> Attribute msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


{-| -}
full : Bool -> Attribute msg
full v =
    Attribute <| \attrs -> { attrs | full = v }


{-| -}
offset : Float -> Attribute msg
offset v =
    Attribute <| \attrs -> { attrs | offset = v }


{-| -}
bottomRight : Attribute msg
bottomRight =
    Attribute <| \attrs -> { attrs | position = BottomRight }


{-| -}
top : Attribute msg
top =
    Attribute <| \attrs -> { attrs | position = TopLeft }


{-| -}
topRight : Attribute msg
topRight =
    Attribute <| \attrs -> { attrs | position = TopRight }


{-| -}
left : Attribute msg
left =
    Attribute <| \attrs -> { attrs | position = LeftTop }


{-| -}
leftBottom : Attribute msg
leftBottom =
    Attribute <| \attrs -> { attrs | position = LeftBottom }


{-| -}
right : Attribute msg
right =
    Attribute <| \attrs -> { attrs | position = RightTop }


{-| -}
rightBottom : Attribute msg
rightBottom =
    Attribute <| \attrs -> { attrs | position = RightBottom }


{-| -}
over : Attribute msg
over =
    Attribute <| \attrs -> { attrs | over = True }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }



-- Main


{-| -}
view :
    List (Attribute msg)
    ->
        { content : List (H.Html msg)
        , children : List (H.Html msg)
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_

        offsetValue : String
        offsetValue =
            "calc(100% + " ++ String.fromFloat attrs.offset ++ "px)"

        offsetIfOver : String
        offsetIfOver =
            if attrs.over then
                "0"

            else
                offsetValue

        crossAnchor : String -> H.Attribute msg
        crossAnchor x =
            if attrs.full then
                HA.style x "0"

            else
                HA.style x "auto"

        positionAttrs : List (H.Attribute msg)
        positionAttrs =
            case ( attrs.position, attrs.full, attrs.over ) of
                ( TopLeft, _, _ ) ->
                    [ HA.style "left" "0"
                    , HA.style "bottom" offsetIfOver
                    , crossAnchor "right"
                    ]

                ( TopRight, _, _ ) ->
                    [ HA.style "right" "0"
                    , HA.style "bottom" offsetIfOver
                    , crossAnchor "left"
                    ]

                ( BottomLeft, _, _ ) ->
                    [ HA.style "left" "0"
                    , HA.style "top" offsetIfOver
                    , crossAnchor "right"
                    ]

                ( BottomRight, _, _ ) ->
                    [ HA.style "right" "0"
                    , HA.style "top" offsetIfOver
                    , crossAnchor "left"
                    ]

                ( LeftTop, _, _ ) ->
                    [ HA.style "right" offsetValue, HA.style "top" "0" ]

                ( LeftBottom, _, _ ) ->
                    [ HA.style "right" offsetValue, HA.style "bottom" "0" ]

                ( RightTop, _, _ ) ->
                    [ HA.style "left" offsetValue, HA.style "top" "0" ]

                ( RightBottom, _, _ ) ->
                    [ HA.style "left" offsetValue, HA.style "bottom" "0" ]
    in
    H.div
        [ HA.class "ew-inline-block ew-relative ew-group" ]
        [ H.div [ HA.tabindex 0, HA.class "ew-inline-flex" ] props.children
        , H.div
            (positionAttrs
                ++ [ HA.class "ew-hidden ew-absolute ew-z-[9999] group-focus-within:ew-block hover:ew-block"
                   , HA.classList
                        [ ( "ew-min-w-full", attrs.over )
                        , ( "ew-overflow-auto ew-bg-base-bg ew-border-lg ew-border-0.5 ew-border-base-aux/20 ew-shadow", not attrs.unstyled )
                        ]
                   ]
            )
            [ H.div
                (attrs.htmlAttributes
                    ++ [ WH.maybeAttr HA.id attrs.id
                       , HA.class attrs.class
                       ]
                )
                props.content
            ]
        ]
