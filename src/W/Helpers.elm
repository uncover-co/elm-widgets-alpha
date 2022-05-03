module W.Helpers exposing
    ( applyAttrs
    , maybeAttr
    , maybeHtml
    , maybeSvgAttr
    , stringIf
    , styles
    , stylesList
    )

import Html as H
import Html.Attributes as HA
import Svg.Attributes as SA


styles : List ( String, String ) -> H.Attribute msg
styles xs =
    xs
        |> List.map (\( k, v ) -> k ++ ":" ++ v)
        |> String.join ";"
        |> HA.attribute "style"


stylesList : List ( String, String, Bool ) -> H.Attribute msg
stylesList xs =
    xs
        |> List.filterMap
            (\( k, v, f ) ->
                if f then
                    Just (k ++ ":" ++ v)

                else
                    Nothing
            )
        |> String.join ";"
        |> HA.attribute "style"


maybeAttr : (a -> H.Attribute msg) -> Maybe a -> H.Attribute msg
maybeAttr fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (HA.class "")


maybeSvgAttr : (a -> H.Attribute msg) -> Maybe a -> H.Attribute msg
maybeSvgAttr fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (SA.class "")


maybeHtml : (a -> H.Html msg) -> Maybe a -> H.Html msg
maybeHtml fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (H.text "")


applyAttrs : a -> List (a -> a) -> a
applyAttrs defaults fns =
    List.foldl (\fn a -> fn a) defaults fns


stringIf : Bool -> String -> String -> String
stringIf v a b =
    if v then
        a

    else
        b
