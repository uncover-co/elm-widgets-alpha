module UI exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


hSpacer : List (Html msg) -> Html msg
hSpacer children =
    div []
        (children
            |> List.map
                (\c ->
                    span
                        [ style "padding-right" "8px" ]
                        [ c ]
                )
        )
