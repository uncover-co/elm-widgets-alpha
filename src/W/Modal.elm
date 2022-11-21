module W.Modal exposing
    ( view
    , viewToggable, viewToggle
    , absolute, zIndex
    , noAttr, Attribute
    )

{-|

@docs view


# Togglable

If you don't want to manage your modal open state at all, use the toggable version.

    W.Modal.viewToggable []
        { id = "toggable-modal"
        , content = [ text "Hello!" ]
        }

    W.Modal.viewToggle "toggable-modal"
        [ W.Button.viewDummy []
            [ text "Click here to toggle modal" ]
        ]

@docs viewToggable, viewToggle


# Styles

@docs absolute, zIndex


# Html

@docs noAttr, Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes -> Attributes)


type alias Attributes =
    { absolute : Bool
    , zIndex : Int
    }


applyAttrs : List (Attribute msg) -> Attributes
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes
defaultAttrs =
    { absolute = False
    , zIndex = 1000
    }


{-| -}
absolute : Attribute msg
absolute =
    Attribute <| \attrs -> { attrs | absolute = True }


{-| -}
zIndex : Int -> Attribute msg
zIndex v =
    Attribute <| \attrs -> { attrs | zIndex = v }


{-| -}
noAttr : Attribute msg
noAttr =
    Attribute identity



-- Main


type Modal msg
    = Stateless { id : String, children : List (H.Html msg) }
    | Stateful { isOpen : Bool, onClose : Maybe msg, children : List (H.Html msg) }


{-| -}
viewToggle : String -> List (H.Html msg) -> H.Html msg
viewToggle id_ children =
    H.label [ HA.for id_ ] children


{-| -}
viewToggable :
    List (Attribute msg)
    ->
        { id : String
        , children : List (H.Html msg)
        }
    -> H.Html msg
viewToggable attrs props =
    view_ attrs (Stateless props)


{-| -}
view :
    List (Attribute msg)
    ->
        { isOpen : Bool
        , onClose : Maybe msg
        , children : List (H.Html msg)
        }
    -> H.Html msg
view attrs props =
    view_ attrs (Stateful props)


{-| -}
view_ : List (Attribute msg) -> Modal msg -> H.Html msg
view_ attrs_ props =
    let
        attrs : Attributes
        attrs =
            applyAttrs attrs_

        backgroundAttrs : List (H.Attribute msg)
        backgroundAttrs =
            [ HA.class "ew-modal-background ew-block ew-absolute ew-inset-0"
            , HA.class "ew-transition ew-duration-300"
            , HA.class "ew-opacity-0 ew-bg-black/20 ew-pointer-events-none"
            ]
    in
    H.div []
        [ H.node "style" [] [ H.text toggleStyle ]
        , case props of
            Stateless { id } ->
                H.node
                    "input"
                    [ HA.id id
                    , HA.type_ "checkbox"
                    , HA.class "ew-hidden ew-modal-toggle"
                    ]
                    []

            _ ->
                H.text ""
        , H.div
            [ HA.attribute "role" "dialog"
            , HA.style "z-index" (String.fromInt attrs.zIndex)
            , HA.class "ew-modal ew-inset-0 ew-flex ew-flex-col ew-items-center ew-justify-center ew-box-border ew-p-6"
            , HA.class "invisible ew-pointer-events-none"
            , HA.classList
                [ ( "ew-modal--is-open"
                  , case props of
                        Stateful { isOpen } ->
                            isOpen

                        _ ->
                            False
                  )
                , ( "ew-absolute", attrs.absolute )
                , ( "ew-fixed", not attrs.absolute )
                ]
            ]
            [ case props of
                Stateless { id } ->
                    H.label
                        (backgroundAttrs
                            ++ [ HA.class "ew-focusable-inset hover:ew-bg-black/[0.15]"
                               , HA.for id
                               ]
                        )
                        []

                Stateful { onClose } ->
                    case onClose of
                        Just onClose_ ->
                            H.div
                                (backgroundAttrs
                                    ++ [ HA.class "ew-focusable-inset hover:ew-bg-black/[0.15]"
                                       , HE.onClick onClose_
                                       ]
                                )
                                []

                        Nothing ->
                            H.div backgroundAttrs []
            , H.div
                [ HA.class "ew-modal-content ew-relative"
                , HA.class "ew-bg-base-bg ew-shadow-lg ew-rounded-lg"
                , HA.class "ew-w-full ew-max-w-md ew-max-h-[80%] ew-overflow-auto"
                , HA.class "ew-opacity-0 ew-pointer-events-none"
                , HA.class "ew-transition ew-duration-400"
                ]
                (case props of
                    Stateless { children } ->
                        children

                    Stateful { children } ->
                        children
                )
            ]
        ]



-- Helpers


toggleStyle : String
toggleStyle =
    """
.ew-modal-toggle:checked + .ew-modal, .ew-modal.ew-modal--is-open .ew-modal-background {
    visibility: visible;
    pointer-events: auto;
}
.ew-modal-toggle:checked + .ew-modal .ew-modal-background, .ew-modal.ew-modal--is-open .ew-modal-background {
    opacity: 1;
    pointer-events: auto;
}
.ew-modal-toggle:checked + .ew-modal .ew-modal-content, .ew-modal.ew-modal--is-open .ew-modal-content {
    opacity: 1;
    pointer-events: auto;
    animation: 0.2s ease-out forwards ew-animation-fade-slide;
}
"""
