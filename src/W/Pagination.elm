module W.Pagination exposing (view, separator, onClick)

{-|

@docs view, separator, onClick

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
    { onClick : Maybe (Int -> msg)
    , separator : H.Html msg
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { onClick = Nothing
    , separator = H.span [ HA.class "ew-relative -ew-top-px" ] [ H.text "—" ]
    }



-- Attributes : Setters


{-| -}
separator : H.Html msg -> Attribute msg
separator v =
    Attribute (\attrs -> { attrs | separator = v })


{-| -}
onClick : (Int -> msg) -> Attribute msg
onClick v =
    Attribute (\attrs -> { attrs | onClick = Just v })



-- Main


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
    let
        attrs : Attributes msg
        attrs =
            applyAttrs attrs_
    in
    case W.Internal.Pagination.toPages props.active props.total of
        Ok pages ->
            H.div
                [ HA.class "ew-flex ew-items-center ew-font-primary ew-space-x-2 ew-text-base-aux" ]
                (pages
                    |> List.map
                        (\page ->
                            if page /= -1 then
                                W.Button.view
                                    [ W.Button.small
                                    , W.Button.invisible
                                    , W.Button.icon
                                    , if page == props.active then
                                        W.Button.primary

                                      else
                                        W.Button.noAttr
                                    ]
                                    { onClick = props.onClick page
                                    , label = H.text (String.fromInt page)
                                    }

                            else
                                H.span
                                    [ HA.class "ew-inline-flex ew-items-center ew-leading-none" ]
                                    [ attrs.separator
                                    ]
                        )
                )

        Err errorMessage ->
            H.text errorMessage
