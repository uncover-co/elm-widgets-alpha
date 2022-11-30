module W.Internal.Input exposing
    ( areaClass
    , baseClass
    , iconWrapper
    , mask
    , maskClass
    , view
    , viewIcon
    )

import Html as H
import Html.Attributes as HA


view :
    { x
        | prefix : Maybe (H.Html msg)
        , suffix : Maybe (H.Html msg)
        , readOnly : Bool
    }
    -> H.Html msg
    -> H.Html msg
view attrs input =
    H.label
        [ HA.class "ew-input ew-bg-base-bg ew-box-border"
        , HA.class "ew-flex ew-items-stretch"
        , HA.class "ew-border ew-border-solid ew-border-base-aux/30 ew-rounded ew-overflow-hidden"
        , HA.class "ew-font-text ew-text-base ew-text-base-fg"
        , HA.class "ew-transition"
        , HA.class "ew-ring-offset-0 ew-ring-primary-fg/50"
        , HA.classList
            [ ( "focus-within:ew-ring focus-within:ew-border-primary-fg", not attrs.readOnly )
            ]
        ]
        [ case attrs.prefix of
            Just prefix ->
                H.div
                    [ prefixSuffixClass
                    , HA.class "ew-border-r"
                    ]
                    [ prefix ]

            Nothing ->
                H.text ""
        , input
        , case attrs.suffix of
            Just suffix ->
                H.div
                    [ prefixSuffixClass
                    , HA.class "ew-border-l"
                    ]
                    [ suffix ]

            Nothing ->
                H.text ""
        ]


viewIcon :
    { x
        | prefix : Maybe (H.Html msg)
        , suffix : Maybe (H.Html msg)
        , readOnly : Bool
    }
    -> H.Html msg
    -> H.Html msg
    -> H.Html msg
viewIcon attrs icon input =
    view attrs
        (H.div [ HA.class "ew-w-full ew-relative" ]
            [ input
            , iconWrapper "ew-text-base-aux" icon
            ]
        )


prefixSuffixClass : H.Attribute msg
prefixSuffixClass =
    HA.class <|
        "ew-flex ew-items-center ew-justify-center ew-box-border"
            ++ " ew-border-0 ew-border-solid ew-border-base-aux/30"
            ++ " ew-p-2 ew-min-w-[48px] ew-self-stretch"
            ++ " ew-text-sm ew-text-base ew-text-base-aux"


maskClass : Maybe (a -> String) -> H.Attribute msg
maskClass fn =
    HA.classList
        [ ( "ew-text-transparent focus:ew-text-base-fg focus:ew-pb-[18px] focus:ew-pt-0"
          , fn /= Nothing
          )
        ]


mask : Maybe (a -> String) -> a -> H.Html msg
mask fn value =
    case Maybe.map (\f -> f value) fn of
        Just value_ ->
            H.p
                [ HA.class "ew-absolute ew-inset-y-0 ew-inset-x-3"
                , HA.class "ew-flex ew-items-center"
                , HA.class "ew-leading-0 ew-text-base ew-text-base-fg"
                , HA.class "ew-m-0 ew-p-0 ew-box-border"
                , HA.class "ew-transition ew-cursor-text"
                , HA.class "group-focus-within:ew-top-[22px]"
                , HA.class "group-focus-within:ew-text-sm group-focus-within:ew-text-base-aux"
                , HA.style "transition" "position 0.2s"
                , HA.attribute "aria-hidden" "true"
                ]
                [ H.text value_ ]

        Nothing ->
            H.text ""


baseClass : String
baseClass =
    "ew-appearance-none ew-box-border ew-grow ew-self-stretch"
        ++ " ew-leading-none"
        ++ " ew-w-full ew-min-h-[48px] ew-py-2 ew-px-3"
        ++ " ew-border-0"
        ++ " ew-font-text ew-text-base ew-text-base-fg ew-placeholder-base-aux"
        ++ " ew-outline-0"
        ++ " ew-bg-base-aux/[0.07]"
        ++ " focus:ew-bg-base-bg"
        ++ " disabled:ew-bg-base-aux/30"
        ++ " aria-readonly:disabled:ew-bg-base-aux/[0.07]"
        ++ " aria-readonly:read-only:focus:ew-bg-base-aux/10"


areaClass : String
areaClass =
    "ew-input ew-appearance-none ew-box-border"
        ++ " ew-relative"
        ++ " ew-w-full ew-min-h-[48px] ew-py-2 ew-px-3"
        ++ " ew-bg-base-aux/[0.07] ew-border ew-border-solid ew-border-base-aux/30 ew-rounded ew-shadow-none"
        ++ " ew-font-text ew-text-base ew-text-base-fg ew-placeholder-base-aux"
        ++ " ew-transition"
        ++ " ew-outline-0 ew-ring-offset-0 ew-ring-primary-fg/50"
        ++ " disabled:ew-bg-base-aux/[0.25] disabled:ew-border-base-aux/[0.25]"
        ++ " focus:ew-bg-base-bg focus:ew-ring focus:ew-border-primary-fg"
        ++ " read-only:focus:ew-bg-base-aux/10"


iconWrapper : String -> H.Html msg -> H.Html msg
iconWrapper class child =
    H.div
        [ HA.class "ew-input-icon ew-absolute ew-w-10 ew-inset-y-1 ew-right-1"
        , HA.class "ew-pointer-events-none ew-flex ew-items-center ew-justify-center"
        , HA.class "ew-bg-base-bg"
        , HA.class "before:ew-block before:ew-content-['']"
        , HA.class "before:ew-inset-0 before:ew-absolute"
        , HA.class class
        ]
        [ H.div [ HA.class "ew-relative" ] [ child ] ]
