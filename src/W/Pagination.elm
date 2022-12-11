module W.Pagination exposing
    ( view, viewLinks
    , separator
    , noAttr, Attribute
    )

{-|

@docs view, viewLinks


# Styles

@docs separator


# Html

@docs noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import W.Button
import W.Internal.Pagination



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { separator : List (H.Html msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { separator = [ H.span [ HA.class "ew-relative -ew-top-px" ] [ H.text "—" ] ]
    }



-- Attributes : Setters


{-| -}
separator : List (H.Html msg) -> Attribute msg
separator v =
    Attribute (\attrs -> { attrs | separator = v })


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity



-- Main


{-| -}
viewLinks :
    List (Attribute msg)
    ->
        { total : Int
        , active : Int
        , href : Int -> String
        }
    -> H.Html msg
viewLinks attrs_ props =
    case W.Internal.Pagination.toPages props.active props.total of
        Ok pages ->
            let
                attrs : Attributes msg
                attrs =
                    applyAttrs attrs_
            in
            H.div
                [ HA.class "ew-flex ew-items-center ew-font-primary ew-space-x-2 ew-text-base-aux" ]
                (pages
                    |> List.map
                        (\page ->
                            if page /= -1 then
                                W.Button.viewLink
                                    [ W.Button.small
                                    , W.Button.invisible
                                    , W.Button.icon
                                    , if page == props.active then
                                        W.Button.primary

                                      else
                                        W.Button.noAttr
                                    ]
                                    { href = props.href page
                                    , label = [ H.text (String.fromInt page) ]
                                    }

                            else
                                H.span
                                    [ HA.class "ew-inline-flex ew-items-center ew-leading-none" ]
                                    attrs.separator
                        )
                )

        Err errorMessage ->
            H.text errorMessage


{-| -}
view :
    List (Attribute msg)
    ->
        { total : Int
        , active : Int
        , onClick : Int -> msg
        }
    -> H.Html msg
view attrs_ props =
    case W.Internal.Pagination.toPages props.active props.total of
        Ok pages ->
            let
                attrs : Attributes msg
                attrs =
                    applyAttrs attrs_
            in
            H.div
                [ HA.class "ew-flex ew-items-center ew-font-primary ew-space-x-2 ew-text-base-aux" ]
                (pages
                    |> List.map
                        (\page ->
                            if page /= -1 then
                                W.Button.view
                                    [ W.Button.small
                                    , W.Button.icon
                                    , if page == props.active then
                                        W.Button.primary

                                      else
                                        W.Button.invisible
                                    ]
                                    { onClick = props.onClick page
                                    , label = [ H.text (String.fromInt page) ]
                                    }

                            else
                                H.span
                                    [ HA.class "ew-inline-flex ew-items-center ew-leading-none" ]
                                    attrs.separator
                        )
                )

        Err errorMessage ->
            H.text errorMessage
