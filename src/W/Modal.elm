module W.Modal exposing
    ( view
    , id, absolute
    , Attribute
    , isOpen, onClose, toggable, viewToggle, zIndex
    )

{-|

@docs view
@docs id, absolute
@docs Attribute

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE



-- Attributes


{-| -}
type Attribute msg
    = Attribute (Attributes msg -> Attributes msg)


type alias Attributes msg =
    { id : Maybe String
    , absolute : Bool
    , zIndex : Int
    , toggable : Maybe String
    , isOpen : Maybe Bool
    , onClose : Maybe msg
    }


applyAttrs : List (Attribute msg) -> Attributes msg
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg
defaultAttrs =
    { id = Nothing
    , absolute = False
    , zIndex = 1000
    , toggable = Nothing
    , isOpen = Nothing
    , onClose = Nothing
    }


{-| -}
id : String -> Attribute msg
id v =
    Attribute <| \attrs -> { attrs | id = Just v }


{-| -}
absolute : Bool -> Attribute msg
absolute v =
    Attribute <| \attrs -> { attrs | absolute = v }


{-| -}
zIndex : Int -> Attribute msg
zIndex v =
    Attribute <| \attrs -> { attrs | zIndex = v }


{-| -}
toggable : String -> Attribute msg
toggable v =
    Attribute <| \attrs -> { attrs | toggable = Just v }


{-| -}
isOpen : Bool -> Attribute msg
isOpen v =
    Attribute <| \attrs -> { attrs | isOpen = Just v }


{-| -}
onClose : msg -> Attribute msg
onClose v =
    Attribute <| \attrs -> { attrs | onClose = Just v }



-- Main


{-| -}
viewToggle : String -> List (H.Html msg) -> H.Html msg
viewToggle id_ children =
    H.label [ HA.for id_ ] children


{-| -}
view :
    List (Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
view attrs_ children =
    let
        attrs : Attributes msg
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
        , case attrs.toggable of
            Just toggleId ->
                H.node
                    "input"
                    [ HA.id toggleId
                    , HA.type_ "checkbox"
                    , HA.class "ew-hidden ew-modal-toggle"
                    ]
                    []

            Nothing ->
                H.text ""
        , H.div
            [ HA.attribute "role" "dialog"
            , HA.style "z-index" (String.fromInt attrs.zIndex)
            , HA.class "ew-modal ew-inset-0 ew-flex ew-flex-col ew-items-center ew-justify-center ew-box-border ew-p-6"
            , HA.class "invisible ew-pointer-events-none"
            , HA.classList
                [ ( "ew-modal--is-open", attrs.isOpen == Just True )
                , ( "ew-absolute", attrs.absolute )
                , ( "ew-fixed", not attrs.absolute )
                ]
            ]
            [ case ( attrs.toggable, attrs.onClose ) of
                ( Just toggleId, _ ) ->
                    H.label
                        (backgroundAttrs
                            ++ [ HA.class "ew-focusable-inset hover:ew-bg-black/[0.15]"
                               , HA.for toggleId
                               ]
                        )
                        []

                ( Nothing, Just onClose_ ) ->
                    H.div
                        (backgroundAttrs
                            ++ [ HA.class "ew-focusable-inset hover:ew-bg-black/[0.15]"
                               , HE.onClick onClose_
                               ]
                        )
                        []

                ( Nothing, Nothing ) ->
                    H.div backgroundAttrs []
            , H.div
                [ HA.class "ew-modal-content ew-relative"
                , HA.class "ew-bg-base-bg ew-shadow-lg ew-rounded-lg"
                , HA.class "ew-w-full ew-max-w-md ew-max-h-[80%] ew-overflow-auto"
                , HA.class "ew-opacity-0 ew-pointer-events-none"
                , HA.class "ew-transition ew-duration-400"
                ]
                children
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
