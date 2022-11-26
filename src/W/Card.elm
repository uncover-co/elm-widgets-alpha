module W.Card exposing
    ( background
    , extraRounded
    , largeShadow
    , noAttr
    , noShadow
    , notRounded
    , padding
    , view
    )

import Html as H
import Html.Attributes as HA
import Theme
import W.Internal.Helpers as WH



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes -> Attributes)


type alias Attributes =
    { background : String
    , borderRadiusClass : String
    , shadowClass : String
    , padding :
        { top : Int
        , left : Int
        , right : Int
        , bottom : Int
        }
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { background = Theme.baseBackground
    , borderRadiusClass = "ew-rounded"
    , shadowClass = "ew-shadow-md"
    , padding =
        { top = 0
        , left = 0
        , right = 0
        , bottom = 0
        }
    }



-- Attributes : Setters


{-| -}
padding : { top : Int, left : Int, right : Int, bottom : Int } -> Attribute msg
padding v =
    Attribute (\attrs -> { attrs | padding = v })


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
    H.div
        [ HA.class "ew-border ew-border-solid ew-border-white/[0.03]"
        , HA.class attrs.shadowClass
        , HA.class attrs.borderRadiusClass
        , WH.styles
            [ ( "padding-top", String.fromInt attrs.padding.top ++ "px" )
            , ( "padding-left", String.fromInt attrs.padding.left ++ "px" )
            , ( "padding-right", String.fromInt attrs.padding.right ++ "px" )
            , ( "padding-bottom", String.fromInt attrs.padding.bottom ++ "px" )
            , ( "background", attrs.background )
            ]
        ]
        children
