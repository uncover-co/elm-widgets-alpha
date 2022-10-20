module W.Button exposing
    ( view, viewLink
    , disabled, outlined, invisible
    , primary, secondary, success, warning, danger, theme, ButtonTheme
    , rounded, large, small, icon, fill
    , left, right
    , id, class, htmlAttrs, noAttr, Attribute
    )

{-|

@docs view, viewLink


# State

@docs disabled, outlined, invisible


# Colors

@docs primary, secondary, success, warning, danger, theme, ButtonTheme


# Styles

@docs rounded, large, small, icon, fill


# Elements

@docs left, right


# Html

@docs id, class, htmlAttrs, noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Theme exposing (ThemeColorSetValues)
import W.Internal.Helpers as WH



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , style : ButtonStyle
    , class : String
    , disabled : Bool
    , size : ButtonSize
    , rounded : Bool
    , width : ButtonWidth
    , left : Maybe (H.Html msg)
    , right : Maybe (H.Html msg)
    , theme : ButtonTheme
    , htmlAttributes : List (H.Attribute msg)
    }


type ButtonStyle
    = Basic
    | Outlined
    | Invisible


type ButtonSize
    = Small
    | Medium
    | Large


type ButtonWidth
    = Fill
    | Icon
    | Base


{-| -}
type alias ButtonTheme =
    { foreground : String
    , background : String
    , aux : String
    }


toButtonTheme : ThemeColorSetValues -> ButtonTheme
toButtonTheme color =
    { foreground = color.foreground
    , background = color.background
    , aux = color.aux
    }


defaultAttrs : Attributes msg
defaultAttrs =
    { id = Nothing
    , style = Basic
    , class = ""
    , disabled = False
    , size = Medium
    , rounded = False
    , width = Base
    , left = Nothing
    , right = Nothing
    , theme = toButtonTheme Theme.neutral
    , htmlAttributes = []
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


styleAttrs : Attributes msg -> List (H.Attribute msg)
styleAttrs attrs =
    case attrs.style of
        Basic ->
            [ HA.style "color" attrs.theme.aux
            , HA.style "background" attrs.theme.background
            , HA.class "ew-border-0"
            ]

        Outlined ->
            [ HA.style "color" attrs.theme.foreground
            , HA.style "border-color" attrs.theme.foreground
            , HA.style "background" Theme.baseBackground
            , HA.class "ew-border-solid ew-border-[3px]"
            ]

        Invisible ->
            [ HA.class "ew-relative ew-bg-transparent ew-border-0"
            , HA.class "before:ew-content-[''] before:ew-block before:ew-absolute before:ew-inset-0 before:ew-bg-current before:ew-opacity-0 hover:before:ew-opacity-[0.15] before:ew-transition-opacity"
            , HA.style "color" attrs.theme.foreground
            ]


roundedAttrs : Attributes msg -> H.Attribute msg
roundedAttrs attrs =
    case ( attrs.rounded, attrs.size ) of
        ( False, Large ) ->
            HA.class "ew-rounded-xl before:ew-rounded-xl"

        ( False, _ ) ->
            HA.class "ew-rounded-lg before:ew-rounded-lg"

        ( True, Large ) ->
            HA.class "ew-rounded-[20px] before:ew-rounded-[24px]"

        ( True, Medium ) ->
            HA.class "ew-rounded-[20px] before:ew-rounded-[20px]"

        ( True, Small ) ->
            HA.class "ew-rounded-[16px] before:ew-rounded-[16px]"



-- Main


attributes : List (Attribute msg) -> List (H.Attribute msg)
attributes attrs_ =
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    attrs.htmlAttributes
        ++ styleAttrs attrs
        ++ [ WH.maybeAttr HA.id attrs.id
           , HA.disabled attrs.disabled
           , roundedAttrs attrs
           , HA.class attrs.class
           , HA.class "ew-btn ew-focusable"
           , HA.classList
                [ ( "ew-h-[32px] ew-text-sm", attrs.size == Small )
                , ( "ew-h-[40px] ew-text-base", attrs.size == Medium )
                , ( "ew-h-[48px] ew-text-base", attrs.size == Large )
                , ( "ew-px-3", attrs.size == Small && attrs.width == Base )
                , ( "ew-px-5", attrs.size == Medium && attrs.width == Base )
                , ( "ew-px-6", attrs.size == Large && attrs.width == Base )
                , ( "ew-min-w-[32px] ew-px-1", attrs.size == Small && attrs.width == Icon )
                , ( "ew-min-w-[40px] ew-px-1", attrs.size == Medium && attrs.width == Icon )
                , ( "ew-min-w-[48px] ew-px-1", attrs.size == Large && attrs.width == Icon )
                , ( "ew-w-full", attrs.width == Fill )
                ]
           ]


{-| -}
view :
    List (Attribute msg)
    ->
        { label : H.Html msg
        , onClick : msg
        }
    -> H.Html msg
view attrs props =
    H.button
        (HE.onClick props.onClick :: attributes attrs)
        [ props.label ]


{-| -}
viewLink :
    List (Attribute msg)
    ->
        { label : H.Html msg
        , href : String
        }
    -> H.Html msg
viewLink attrs props =
    H.a
        (HA.href props.href :: attributes attrs)
        [ props.label ]



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
primary : Attribute msg
primary =
    Attribute <| \attrs -> { attrs | theme = toButtonTheme Theme.primary }


{-| -}
secondary : Attribute msg
secondary =
    Attribute <| \attrs -> { attrs | theme = toButtonTheme Theme.secondary }


{-| -}
success : Attribute msg
success =
    Attribute <| \attrs -> { attrs | theme = toButtonTheme Theme.success }


{-| -}
warning : Attribute msg
warning =
    Attribute <| \attrs -> { attrs | theme = toButtonTheme Theme.warning }


{-| -}
danger : Attribute msg
danger =
    Attribute <| \attrs -> { attrs | theme = toButtonTheme Theme.danger }


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
    Attribute <| \attrs -> { attrs | width = Fill }


{-| -}
icon : Attribute msg
icon =
    Attribute <| \attrs -> { attrs | width = Icon }


{-| -}
rounded : Attribute msg
rounded =
    Attribute <| \attrs -> { attrs | rounded = True }


{-| -}
small : Attribute msg
small =
    Attribute <| \attrs -> { attrs | size = Small }


{-| -}
large : Attribute msg
large =
    Attribute <| \attrs -> { attrs | size = Large }


{-| -}
left : H.Html msg -> Attribute msg
left v =
    Attribute <| \attrs -> { attrs | left = Just v }


{-| -}
right : H.Html msg -> Attribute msg
right v =
    Attribute <| \attrs -> { attrs | right = Just v }


{-| -}
theme : ButtonTheme -> Attribute msg
theme v =
    Attribute <| \attrs -> { attrs | theme = v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity
