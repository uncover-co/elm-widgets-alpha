module ElmWidgets.Styles exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA


themeString : String
themeString =
    [ -- fonts
      "--uc-ts-font-title: serif"
    , "--uc-ts-font-text: sans-serif"
    , "--uc-ts-font-code: monospaced"

    -- button
    , "--uc-ts-btn-background: #444"
    , "--uc-ts-btn-color: #fff"

    -- color
    , "--uc-ts-color: #444"
    , "--uc-ts-color-faded: #999"

    -- border radius
    , "--uc-ts-border-radius: 4px"
    , "--uc-ts-border-large: 8px"

    -- background
    , "--uc-ts-background: #fff"
    , "--uc-ts-background-faded: #eee"

    -- accessibility
    , "--uc-ts-focus: #09d"

    -- status
    , "--uc-ts-danger: #ff4d4f"
    , "--uc-ts-danger-contrast: #fff"
    , "--uc-ts-danger-faded: #f87a7c"
    , "--uc-ts-success: #56bd1a"
    , "--uc-ts-success-contrast: #fff"
    , "--uc-ts-success-faded: #8ed466"
    ]
        |> String.join ";"


themeGlobal : Html msg
themeGlobal =
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


globalStyles : Html msg
globalStyles =
    H.node "style"
        []
        [ H.text """
.ew {
    box-sizing: border-box;
}
.ew.ew-relative {
    position: relative;
}

.ew.ew-btn {
    box-sizing: border-box;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 36px;
    padding: 0 16px;
    border: none;
    border-radius: var(--uc-ts-border-radius);
    
    font-family: var(--uc-ts-font-text);
    color: var(--uc-ts-btn-color);
    text-transform: uppercase;
    font-size: 12px;
    font-weight: bold;
    line-height: 1em;
    letter-spacing: 0.05em;
    
    cursor: pointer;
    transition: box-shadow 0.15s, background 0.15s;
}
.ew.ew-btn:focus {
    outline: 3px solid var(--uc-ts-focus);
}
.ew.ew-btn:active {
    opacity: 0.8;
}
.ew.ew-btn:disabled {
    opacity: 0.4;
    pointer-events: none;
}

.ew.ew-btn.ew-m-primary {
    background: var(--uc-ts-btn-background);
}
.ew.ew-btn.ew-m-primary:hover {
    box-shadow: 0 0 8px var(--uc-ts-color-faded);
}

.ew.ew-btn.ew-m-primary.ew-is-danger {
    background: var(--uc-ts-danger);
    color: var(--uc-ts-danger-contrast);
}
.ew.ew-btn.ew-m-primary.ew-is-danger:hover {
    box-shadow: 0 0 8px var(--uc-ts-danger-faded);
}

.ew.ew-btn.ew-m-primary.ew-is-success {
    background: var(--uc-ts-success);
    color: var(--uc-ts-success-contrast);
}
.ew.ew-btn.ew-m-primary.ew-is-success:hover {
    box-shadow: 0 0 8px var(--uc-ts-success-faded);
}


.ew.ew-btn.ew-m-outlined {
    background: transparent;
    border: 3px solid var(--uc-ts-color);
    color: var(--uc-ts-color);
    box-shadow: none;
}
.ew.ew-btn.ew-m-outlined:hover {
    box-shadow: 0 0 4px var(--uc-ts-color-faded);
}

.ew.ew-btn.ew-m-invisible {
    position: relative;
    overflow: hidden;
    color: var(--uc-ts-color);
    background: transparent;
    border-color: transparent;
    box-shadow: none;
}

.ew.ew-btn.ew-m-invisible > .ew.ew-bg {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    opacity: 0;
    background: var(--uc-ts-background-faded);
    transition: 0.15s;
}
.ew.ew-btn.ew-m-invisible:hover > .ew.ew-bg {
    opacity: 1;
}
"""
        ]
