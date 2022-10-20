module W.ButtonGroup exposing
    ( view
    , id, disabled, highlighted
    , outlined, rounded, small, fill
    , Attribute
    )

{-|

@docs view
@docs id, disabled, highlighted
@docs outlined, rounded, small, fill
@docs Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import ThemeSpec exposing (ThemeSpecColorVars)
import W.Internal.Helpers as WH



-- Attributes


{-| -}
type Attribute a msg
    = Attribute (Attributes a msg -> Attributes a msg)


type alias Attributes a msg =
    { id : Maybe (a -> String)
    , disabled : a -> Bool
    , highlighted : a -> Bool
    , outlined : Bool
    , rounded : Bool
    , small : Bool
    , fill : Bool
    , theme : ThemeSpecColorVars
    , htmlAttributes : List (H.Attribute msg)
    }


defaultAttrs : Attributes a msg
defaultAttrs =
    { id = Nothing
    , disabled = \_ -> False
    , highlighted = \_ -> False
    , outlined = False
    , rounded = False
    , small = False
    , fill = False
    , theme = ThemeSpec.secondary
    , htmlAttributes = []
    }


applyAttrs : List (Attribute a msg) -> Attributes a msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs



-- Attributes


{-| -}
id : (a -> String) -> Attribute a msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
disabled : (a -> Bool) -> Attribute a msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
highlighted : (a -> Bool) -> Attribute a msg
highlighted v =
    Attribute <| \attrs -> { attrs | highlighted = v }


{-| -}
rounded : Attribute a msg
rounded =
    Attribute <| \attrs -> { attrs | rounded = True }


{-| -}
small : Attribute a msg
small =
    Attribute <| \attrs -> { attrs | small = True }


{-| deprecated.
-}
outlined : Attribute a msg
outlined =
    Attribute <| \attrs -> { attrs | outlined = True }


{-| -}
fill : Attribute a msg
fill =
    Attribute <| \attrs -> { attrs | fill = True }



-- Main


{-| -}
view :
    List (Attribute a msg)
    ->
        { items : List a
        , toLabel : a -> H.Html msg
        , onClick : a -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs : Attributes a msg
        attrs =
            applyAttrs attrs_
    in
    H.div
        [ HA.class "ew-inline-flex ew-items-center"
        , HA.classList
            [ ( "ew-m-outlined", attrs.outlined )
            , ( "ew-w-full", attrs.fill )
            ]
        ]
        (props.items
            |> List.map
                (\item ->
                    H.button
                        [ WH.maybeAttr (\fn -> HA.id (fn item)) attrs.id
                        , HA.class "ew-grow ew-shrink-0 ew-box-border"
                        , HA.class "ew-focusable ew-inline-flex ew-items-center ew-justify-center"
                        , HA.class "ew-py-0 ew-px-4 ew-border-solid"
                        , HA.class "ew-font-text ew-text-base ew-font-medium ew-leading-0"
                        , HA.class "focus:ew-relative ew-z-1"
                        , HA.classList
                            [ ( "ew-h-[32px]", attrs.small )
                            , ( "ew-h-[40px]", not attrs.small )
                            , ( "first:ew-rounded-l-lg last:ew-rounded-r-lg", not attrs.rounded )
                            , ( "first:ew-rounded-l-[16px] last:ew-rounded-r-[16px]", attrs.rounded && attrs.small )
                            , ( "first:ew-rounded-l-[20px] last:ew-rounded-r-[20px]", attrs.rounded && not attrs.small )
                            , ( "ew-border-0 ew-bg-primary-bg ew-text-primary-aux", attrs.highlighted item && not attrs.outlined )
                            , ( "ew-border-0 ew-bg-neutral-bg ew-text-neutral-aux", not (attrs.highlighted item) && not attrs.outlined )
                            , ( "ew-border-primary-fg ew-text-primary-fg", attrs.highlighted item && attrs.outlined )
                            , ( "ew-border-neutral-fg ew-text-neutral-fg", not (attrs.highlighted item) && attrs.outlined )
                            , ( "-ew-mx-px first:ew-ml-0 last:ew-mr-0", attrs.outlined )
                            ]
                        , HA.disabled (attrs.disabled item)
                        , HE.onClick (props.onClick item)
                        ]
                        [ props.toLabel item ]
                )
        )
