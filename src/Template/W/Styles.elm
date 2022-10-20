module Template.W.Styles exposing (globalStyles, baseTheme)

{-| Hello!

@docs globalStyles, baseTheme

-}

import Html as H
import Theme


{-| -}
baseTheme : H.Html msg
baseTheme =
    Theme.globalProvider Theme.lightTheme


{-| -}
globalStyles : H.Html msg
globalStyles =
    H.node "style"
        []
        [ H.text <| Debug.todo "STYLES" ]
