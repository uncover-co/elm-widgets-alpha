module W.Popover exposing
    ( view
    , Position, top, left, right, over, offset
    , id, class, full, htmlAttrs, Attribute
    )

{-|

@docs view
@docs Position, top, left, right, over, offset
@docs id, class, full, htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import W.Internal.Helpers as WH



-- Placement


{-| -}
type Position
    = Top
    | Left
    | Right
    | Bottom
    | Over



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , position : Position
    , offset : Float
    , full : Bool
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
    , position = Bottom
    , offset = 0
    , full = False
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
top : Attribute msg
top =
    Attribute <| \attrs -> { attrs | position = Top }


{-| -}
left : Attribute msg
left =
    Attribute <| \attrs -> { attrs | position = Left }


{-| -}
right : Attribute msg
right =
    Attribute <| \attrs -> { attrs | position = Right }


{-| -}
over : Attribute msg
over =
    Attribute <| \attrs -> { attrs | position = Over }


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

        positionClass : String
        positionClass =
            case attrs.position of
                Top ->
                    "ew-m-top"

                Left ->
                    "ew-m-left"

                Right ->
                    "ew-m-right"

                Bottom ->
                    "ew-m-bottom"

                Over ->
                    "ew-m-over"
    in
    H.div
        [ HA.class "ew ew-popover" ]
        [ H.div [ HA.tabindex 0 ] props.children
        , H.div
            [ HA.class "ew ew-popover-content"
            , HA.class positionClass
            , HA.classList
                [ ( "ew-m-full", attrs.full )
                , ( "ew-m-styled", not attrs.unstyled )
                ]
            , WH.styles [ ( "--offset", String.fromFloat attrs.offset ++ "px" ) ]
            ]
            [ H.div
                (attrs.htmlAttributes
                    ++ [ WH.maybeAttr HA.id attrs.id
                       , HA.class attrs.class
                       ]
                )
                props.content
            ]
        ]
