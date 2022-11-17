module W.InputSelect exposing
    ( view, viewGroups
    , id, disabled, readOnly, prefix, suffix
    , Attribute
    )

{-|

@docs view, viewGroups
@docs id, disabled, readOnly, prefix, suffix
@docs Attribute

-}

import Dict exposing (Dict)
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import W.Internal.Helpers as WH
import W.Internal.Input



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , disabled : Bool
    , readOnly : Bool
    , prefix : Maybe (H.Html msg)
    , suffix : Maybe (H.Html msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { id = Nothing
    , disabled = False
    , readOnly = False
    , prefix = Nothing
    , suffix = Nothing
    }



-- Attributes : Setters


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
disabled : Bool -> Attribute msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute msg
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }


{-| -}
prefix : H.Html msg -> Attribute msg
prefix v =
    Attribute <| \attrs -> { attrs | prefix = Just v }


{-| -}
suffix : H.Html msg -> Attribute msg
suffix v =
    Attribute <| \attrs -> { attrs | suffix = Just v }


{-| -}
viewGroups :
    List (Attribute msg)
    ->
        { value : a
        , options : List a
        , optionGroups : List ( String, List a )
        , toLabel : a -> String
        , onInput : a -> msg
        }
    -> H.Html msg
viewGroups attrs_ props =
    let
        attrs =
            applyAttrs attrs_

        values : Dict String a
        values =
            props.optionGroups
                |> List.concatMap Tuple.second
                |> List.append props.options
                |> List.map (\a -> ( props.toLabel a, a ))
                |> Dict.fromList
    in
    W.Internal.Input.view attrs
        (H.div
            [ HA.class "ew-w-full ew-relative" ]
            [ H.select
                [ WH.maybeAttr HA.id attrs.id
                , HA.class W.Internal.Input.baseClass
                , HA.disabled attrs.disabled
                , HA.readonly attrs.readOnly
                , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
                , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
                , HA.placeholder "Select"
                , HE.onInput
                    (\s ->
                        Dict.get s values
                            |> Maybe.withDefault props.value
                            |> props.onInput
                    )
                ]
                (List.concat
                    [ props.options
                        |> List.map
                            (\a ->
                                H.option
                                    [ HA.selected (a == props.value)
                                    , HA.value (props.toLabel a)
                                    ]
                                    [ H.text (props.toLabel a) ]
                            )
                    , props.optionGroups
                        |> List.map
                            (\( l, options_ ) ->
                                H.optgroup [ HA.attribute "label" l ]
                                    (options_
                                        |> List.map
                                            (\a ->
                                                H.option
                                                    [ HA.selected (a == props.value)
                                                    , HA.value (props.toLabel a)
                                                    ]
                                                    [ H.text (props.toLabel a) ]
                                            )
                                    )
                            )
                    ]
                )
            , W.Internal.Input.iconWrapper "ew-text-base-aux"
                W.Internal.Input.iconChevronDown
            ]
        )


{-| -}
view :
    List (Attribute msg)
    ->
        { value : a
        , options : List a
        , toLabel : a -> String
        , onInput : a -> msg
        }
    -> H.Html msg
view attrs_ props =
    viewGroups attrs_
        { value = props.value
        , options = props.options
        , optionGroups = []
        , toLabel = props.toLabel
        , onInput = props.onInput
        }
