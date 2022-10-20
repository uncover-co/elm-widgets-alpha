module W.InputCheckbox exposing
    ( view, viewReadOnly
    , id, color, disabled, readOnly
    , Attribute
    )

{-|

@docs view, viewReadOnly
@docs id, color, disabled, readOnly
@docs Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Theme
import W.Internal.Helpers as WH



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes -> Attributes)


type alias Attributes =
    { id : Maybe String
    , color : String
    , disabled : Bool
    , readOnly : Bool
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { id = Nothing
    , color = Theme.primaryBackground
    , disabled = False
    , readOnly = False
    }



-- Attributes : Setters


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
color : String -> Attribute msg
color v =
    Attribute <| \attrs -> { attrs | color = v }


{-| -}
disabled : Bool -> Attribute msg
disabled v =
    Attribute <| \attrs -> { attrs | disabled = v }


{-| -}
readOnly : Bool -> Attribute msg
readOnly v =
    Attribute <| \attrs -> { attrs | readOnly = v }



-- Main


baseAttrs : List (Attribute msg) -> Bool -> List (H.Attribute msg)
baseAttrs attrs_ value =
    let
        attrs : Attributes
        attrs =
            applyAttrs attrs_
    in
    [ WH.maybeAttr HA.id attrs.id
    , HA.class "ew-check-radio ew-rounded before:ew-rounded-sm"
    , HA.style "color" attrs.color
    , HA.type_ "checkbox"
    , HA.checked value

    -- We also disable the checkbox plugin when it is readonly
    -- Since this property is not currently respected for checkboxes
    , HA.disabled (attrs.disabled || attrs.readOnly)
    , HA.readonly attrs.readOnly
    ]


{-| -}
view :
    List (Attribute msg)
    -> { value : Bool, onInput : Bool -> msg }
    -> H.Html msg
view attrs_ props =
    H.input
        (HE.onCheck props.onInput :: baseAttrs attrs_ props.value)
        []


{-| -}
viewReadOnly :
    List (Attribute msg)
    -> Bool
    -> H.Html msg
viewReadOnly attrs_ value =
    H.input
        (baseAttrs (readOnly True :: attrs_) value)
        []
