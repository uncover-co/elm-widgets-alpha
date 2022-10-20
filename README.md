# elm-widgets

A collection of widgets themed trough [elm-theme](https://package.elm-lang.org/packages/uncover-co/elm-theme/latest/).

**Alpha** - This is the alpha version of ElmWidgets. This means this package will be updated faster but breakage is expected. A stable version is yet to be released as `uncover-co/elm-widgets`.

## Setup

ElmWidgets is plug-and-play with whatever styling approach you prefer - elm-css, elm-ui, tailwind, you name it - just insert ElmWidgets globalStyles somewhere in your application html and use any widget directly.

```elm
import W.Styles
import W.Button


main : Html msg
main =
    div []
        [ W.globalStyles
        , W.baseTheme
        , ...
            W.Button.view []
                { label = text "Sir, would you please click me?"
                , onClick = ...
                }
        ]
```
