# elm-widgets

A collection of stateless widgets themed trough [elm-theme](https://package.elm-lang.org/packages/uncover-co/elm-theme/latest/).

Visit [elm-widgets.netlify.app](https://elm-widgets.netlify.app) for a more comprehensive overview and a showcase of all available widgets.

**Alpha** - This is the alpha version of elm-widgets. This means this package will be updated faster but breakage is expected. The stable version can be found at [uncover-co/elm-widgets](https://package.elm-lang.org/packages/uncover-co/elm-widgets/latest/).

## Getting Started

elm-widgets is plug-and-play with whatever html and styling approach you prefer - elm-css, elm-ui, tailwind, you name it - just insert elm-widgets globalStyles somewhere in your application html and use any widget directly.

```elm
import W.Styles
import W.Button


main : Html msg
main =
    div []
        [ W.Styles.globalStyles
        , W.Styles.baseTheme
        , ...
            W.Button.view []
                { label = [ text "Sir, would you please click me?" ]
                , onClick = ...
                }
        ]
```
