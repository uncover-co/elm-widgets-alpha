module W.Button exposing
    ( view, viewLink
    , disabled
    , accent, danger, success, warning, theme
    , fill, outlined, invisible
    , left, right
    , id, class, htmlAttrs, Attribute
    )

{-|

@docs view, viewLink


# State

@docs disabled


# Colors

@docs accent, danger, success, warning, theme


# Styles

@docs fill, outlined, invisible


# Elements

@docs left, right


# Html

@docs id, class, htmlAttrs, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import ThemeSpec exposing (ThemeSpecColor)
import W.Helpers as WH



-- Core


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , style : ButtonStyle
    , class : String
    , disabled : Bool
    , fill : Bool
    , left : Maybe (H.Html msg)
    , right : Maybe (H.Html msg)
    , theme : ThemeSpecColor
    , htmlAttributes : List (H.Attribute msg)
    }


type ButtonStyle
    = Basic
    | Outlined
    | Invisible


styleClass : ButtonStyle -> String
styleClass s =
    case s of
        Basic ->
            ""

        Outlined ->
            "ew-m-outlined"

        Invisible ->
            "ew-m-invisible"


defaults : Attributes msg
defaults =
    { id = Nothing
    , style = Basic
    , class = ""
    , disabled = False
    , fill = False
    , left = Nothing
    , right = Nothing
    , theme = ThemeSpec.base
    , htmlAttributes = []
    }


attributes : List (Attribute msg) -> List (H.Attribute msg)
attributes attrs_ =
    let
        attrs =
            List.foldl (\(Attribute fn) a -> fn a) defaults attrs_
    in
    attrs.htmlAttributes
        ++ [ WH.maybeAttr HA.id attrs.id
           , HA.disabled attrs.disabled
           , HA.class "ew ew-focusable ew-btn"
           , HA.class (styleClass attrs.style)
           , HA.class attrs.class
           , WH.styles
                [ ( "--color", attrs.theme.lighter )
                , ( "--background", attrs.theme.base )
                , ( "--shadow", attrs.theme.shadow )
                , ( "width", WH.stringIf attrs.fill "100%" "auto" )
                ]
           ]


{-| -}
view :
    List (Attribute msg)
    ->
        { label : String
        , onClick : msg
        }
    -> H.Html msg
view attrs props =
    H.button
        (HE.onClick props.onClick :: attributes attrs)
        [ H.text props.label ]


{-| -}
viewLink :
    List (Attribute msg)
    ->
        { label : String
        , href : String
        }
    -> H.Html msg
viewLink attrs props =
    H.a
        (HA.href props.href :: attributes attrs)
        [ H.text props.label ]



-- Attributes


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
class : String -> Attribute msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


{-| -}
disabled : Bool -> Attribute msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
accent : Attribute msg
accent =
    Attribute <| \attrs -> { attrs | theme = ThemeSpec.accent }


{-| -}
success : Attribute msg
success =
    Attribute <| \attrs -> { attrs | theme = ThemeSpec.success }


{-| -}
warning : Attribute msg
warning =
    Attribute <| \attrs -> { attrs | theme = ThemeSpec.warning }


{-| -}
danger : Attribute msg
danger =
    Attribute <| \attrs -> { attrs | theme = ThemeSpec.danger }


{-| -}
outlined : Attribute msg
outlined =
    Attribute <| \attrs -> { attrs | style = Outlined }


{-| -}
invisible : Attribute msg
invisible =
    Attribute <| \attrs -> { attrs | style = Invisible }


{-| -}
fill : Attribute msg
fill =
    Attribute <| \attrs -> { attrs | fill = True }


{-| -}
left : H.Html msg -> Attribute msg
left v =
    Attribute <| \attrs -> { attrs | left = Just v }


{-| -}
right : H.Html msg -> Attribute msg
right v =
    Attribute <| \attrs -> { attrs | right = Just v }


{-| -}
theme : ThemeSpecColor -> Attribute msg
theme v =
    Attribute <| \attrs -> { attrs | theme = v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }
