module ElmWidgets.Theme exposing
    ( themeGlobalStyles
    , themeProvider
    )

import Html as H
import Html.Attributes as HA


themeString : String
themeString =
    [ -- fonts
      "--uc-ts-font-title: serif"
    , "--uc-ts-font-text: sans-serif"
    , "--uc-ts-font-code: monospaced"

    -- button
    , "--uc-ts-btn-color: #fff"
    , "--uc-ts-btn-background: #09f"
    , "--uc-ts-btn-shadow: #9cf"

    -- color
    , "--uc-ts-color: #444"
    , "--uc-ts-color-faded: #999"

    -- border radius
    , "--uc-ts-border-radius: 4px"
    , "--uc-ts-border-radius-large: 8px"

    -- background
    , "--uc-ts-background: #fff"
    , "--uc-ts-background-faded: #eee"

    -- accessibility
    , "--uc-ts-focus: #59e7d2"

    -- status - danger
    , "--uc-ts-danger: #ff4d4f"
    , "--uc-ts-danger-contrast: #fff"
    , "--uc-ts-danger-faded: #f4bd4f"

    -- status - warning
    , "--uc-ts-warning: #fa0"
    , "--uc-ts-warning-high: #fff"
    , "--uc-ts-warning-faded: #faf3e0"
    , "--uc-ts-warning-shadow: #d2b672"

    -- status - success
    , "--uc-ts-success: #56bd1a"
    , "--uc-ts-success-contrast: #fff"
    , "--uc-ts-success-faded: #8ed466"
    ]
        |> String.join ";"


themeGlobalStyles : H.Html msg
themeGlobalStyles =
    H.node "style"
        []
        [ H.text <|
            "body { "
                ++ themeString
                ++ " }"
        ]


themeProvider : H.Attribute msg
themeProvider =
    HA.attribute "style" themeString
