module W.InputAutocomplete exposing
    ( view
    , class, disabled, readOnly, required, placeholder, onBlur, onEnter, onFocus, htmlAttrs
    , prefix, suffix
    , Attribute
    )

{-|

@docs view
@docs class, disabled, readOnly, required, placeholder, onBlur, onEnter, onFocus, htmlAttrs
@docs prefix, suffix
@docs Attribute

-}

import Dict
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D
import W.Internal.Helpers as WH
import W.Internal.Input
import W.Loading



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { class : String
    , disabled : Bool
    , required : Bool
    , readOnly : Bool
    , placeholder : Maybe String
    , prefix : Maybe (H.Html msg)
    , suffix : Maybe (H.Html msg)
    , onFocus : Maybe msg
    , onBlur : Maybe msg
    , onEnter : Maybe msg
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { class = ""
    , disabled = False
    , required = False
    , readOnly = False
    , placeholder = Nothing
    , prefix = Nothing
    , suffix = Nothing
    , onFocus = Nothing
    , onBlur = Nothing
    , onEnter = Nothing
    , htmlAttributes = []
    }



-- Attribute : Setters


{-| -}
class : String -> Attribute msg
class v =
    Attribute <| \attrs -> { attrs | class = v }


{-| -}
placeholder : String -> Attribute msg
placeholder v =
    Attribute <| \attrs -> { attrs | placeholder = Just v }


{-| -}
disabled : Bool -> Attribute msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute msg
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }


{-| -}
required : Bool -> Attribute msg
required v =
    Attribute <| \attrs -> { attrs | required = v }


{-| -}
prefix : H.Html msg -> Attribute msg
prefix v =
    Attribute <| \attrs -> { attrs | prefix = Just v }


{-| -}
suffix : H.Html msg -> Attribute msg
suffix v =
    Attribute <| \attrs -> { attrs | suffix = Just v }


{-| -}
onBlur : msg -> Attribute msg
onBlur v =
    Attribute <| \attrs -> { attrs | onBlur = Just v }


{-| -}
onFocus : msg -> Attribute msg
onFocus v =
    Attribute <| \attrs -> { attrs | onFocus = Just v }


{-| -}
onEnter : msg -> Attribute msg
onEnter v =
    Attribute <| \attrs -> { attrs | onEnter = Just v }


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }



-- Main


{-| -}
view :
    List (Attribute msg)
    ->
        { id : String
        , search : String
        , value : Maybe a
        , options : Maybe (List a)
        , toLabel : a -> String
        , onInput : String -> Maybe a -> msg
        }
    -> H.Html msg
view attrs_ props =
    let
        attrs =
            applyAttrs attrs_

        options =
            props.options
                |> Maybe.withDefault []
                |> List.map (\o -> ( props.toLabel o, o ))

        optionsDict =
            Dict.fromList options
    in
    W.Internal.Input.view attrs
        (H.div [ HA.class "ew-w-full ew-flex ew-relative" ]
            [ H.input
                (attrs.htmlAttributes
                    ++ [ WH.maybeAttr HA.placeholder attrs.placeholder
                       , HA.disabled (attrs.disabled || attrs.readOnly)
                       , HA.readonly attrs.readOnly
                       , WH.attrIf attrs.readOnly (HA.attribute "aria-readonly") "true"
                       , WH.attrIf attrs.disabled (HA.attribute "aria-disabled") "true"
                       , HA.required attrs.required
                       , HA.autocomplete False
                       , HA.id props.id
                       , HA.class attrs.class
                       , HA.class W.Internal.Input.baseClass
                       , HA.class "ew-pr-10"
                       , HA.list (props.id ++ "-list")
                       , HA.value props.search
                       , WH.maybeAttr HE.onFocus attrs.onFocus
                       , WH.maybeAttr HE.onBlur attrs.onBlur
                       , WH.maybeAttr WH.onEnter attrs.onEnter
                       , HE.on "input"
                            (D.at [ "target", "value" ] D.string
                                |> D.andThen
                                    (\value ->
                                        Dict.get value optionsDict
                                            |> props.onInput value
                                            |> D.succeed
                                    )
                            )
                       ]
                )
                []
            , H.datalist
                [ HA.id (props.id ++ "-list") ]
                (options
                    |> List.map
                        (\( label, _ ) ->
                            H.option [ HA.value label ] []
                        )
                )
            , W.Internal.Input.iconWrapper "ew-text-base-aux"
                (if props.options == Nothing then
                    W.Loading.circles [ W.Loading.size 28 ]

                 else
                    W.Internal.Input.iconChevronDown
                )
            ]
        )
