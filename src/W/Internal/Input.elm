module W.Internal.Input exposing
    ( areaClass
    , baseClass
    , iconChevronDown
    , iconWrapper
    , view
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


prefixSuffixClass : H.Attribute msg
prefixSuffixClass =
    HA.class <|
        "ew-flex ew-items-center ew-justify-center ew-box-border"
            ++ " ew-border-0 ew-border-solid ew-border-base-aux/30"
            ++ " ew-p-2 ew-min-w-[48px] ew-self-stretch"
            ++ " ew-text-sm ew-text-base ew-text-base-aux"


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
        [ HA.class "ew-absolute ew-inset-y-1 ew-right-1 ew-pointer-events-none ew-w-8 ew-flex ew-items-center ew-justify-center"
        , HA.class class
        ]
        [ child ]


iconChevronDown : H.Html msg
iconChevronDown =
    H.div
        [ HA.class "ew-block ew-h-1.5 ew-w-1.5 ew-border-2 ew-border-current ew-border-solid ew-rotate-[45deg]"
        , HA.style "border-left" "none"
        , HA.style "border-top" "none"
        ]
        []
