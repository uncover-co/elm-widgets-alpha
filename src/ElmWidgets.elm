module ElmWidgets exposing
    ( confirmButton
    , dangerButton
    , iconButton
    , invisibleButton
    , outlinedButton
    , primaryButton
    )

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE


buttonLink : Html msg
buttonLink =
    H.button [] []


outlinedButtonLink : Html msg
outlinedButtonLink =
    H.button [] []


textButtonLink : Html msg
textButtonLink =
    H.button [] []


iconButtonLink : Html msg
iconButtonLink =
    H.button [] []



-- Primary Button


type alias PrimaryButtonAttributes =
    { color : String
    , background : String
    , disabled : Bool
    }


primaryButtonDefaults : PrimaryButtonAttributes
primaryButtonDefaults =
    { color = ""
    , background = ""
    , disabled = False
    }


primaryButton :
    List (PrimaryButtonAttributes -> PrimaryButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
primaryButton attrs_ props =
    let
        attrs =
            attrs_
                |> List.foldl (\fn a -> fn a) primaryButtonDefaults
    in
    H.button
        [ HA.style "color" attrs.color
        , HA.style "background" attrs.background
        , HA.disabled attrs.disabled
        , HA.class "ew ew-btn ew-m-primary"
        , HE.onClick props.onClick
        ]
        [ props.label ]



-- Status Buttons


type alias StatusButtonAttributes =
    { disabled : Bool
    }


statusButtonDefaults : StatusButtonAttributes
statusButtonDefaults =
    { disabled = False
    }


dangerButton :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
dangerButton attrs_ props =
    let
        attrs =
            attrs_
                |> List.foldl (\fn a -> fn a) statusButtonDefaults
    in
    H.button
        [ HA.disabled attrs.disabled
        , HA.class "ew ew-btn ew-m-primary ew-is-danger"
        , HE.onClick props.onClick
        ]
        [ props.label ]


confirmButton :
    List (StatusButtonAttributes -> StatusButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
confirmButton attrs_ props =
    let
        attrs =
            attrs_
                |> List.foldl (\fn a -> fn a) statusButtonDefaults
    in
    H.button
        [ HA.disabled attrs.disabled
        , HA.class "ew ew-btn ew-m-primary ew-is-success"
        , HE.onClick props.onClick
        ]
        [ props.label ]



-- Outline Button


type alias OutlineButtonAttributes =
    { color : String
    , disabled : Bool
    }


outlineButtonDefaults : OutlineButtonAttributes
outlineButtonDefaults =
    { color = ""
    , disabled = False
    }


outlinedButton :
    List (OutlineButtonAttributes -> OutlineButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
outlinedButton attrs_ props =
    let
        attrs =
            attrs_
                |> List.foldl (\fn a -> fn a) outlineButtonDefaults
    in
    H.button
        [ HA.style "color" attrs.color
        , HA.style "border-color" attrs.color
        , HA.disabled attrs.disabled
        , HA.class "ew ew-btn ew-m-outlined"
        , HE.onClick props.onClick
        ]
        [ props.label ]



-- Invisible Button


type alias InvisibleButtonAttributes =
    { color : String
    , disabled : Bool
    }


invisibleButtonDefaults : InvisibleButtonAttributes
invisibleButtonDefaults =
    { color = ""
    , disabled = False
    }


invisibleButton :
    List (InvisibleButtonAttributes -> InvisibleButtonAttributes)
    ->
        { label : Html msg
        , onClick : msg
        }
    -> Html msg
invisibleButton attrs_ props =
    let
        attrs =
            attrs_
                |> List.foldl (\fn a -> fn a) invisibleButtonDefaults
    in
    H.button
        [ HA.style "color" attrs.color
        , HA.disabled attrs.disabled
        , HA.class "ew ew-btn ew-m-invisible"
        , HE.onClick props.onClick
        ]
        [ H.div
            [ HA.class "ew ew-bg"
            , HA.style "background-color" attrs.color
            ]
            []
        , H.span
            [ HA.class "ew ew-relative"
            ]
            [ props.label ]
        ]


iconButton : Html msg
iconButton =
    H.button [] []
