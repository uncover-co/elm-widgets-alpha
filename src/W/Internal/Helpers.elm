module W.Internal.Helpers exposing
    ( attrIf
    , limitString
    , maybeAttr
    , maybeHtml
    , onEnter
    , stringIf
    , styles
    )

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import Json.Decode as D



-- Styles


styles : List ( String, String ) -> H.Attribute msg
styles xs =
    xs
        |> List.map (\( k, v ) -> k ++ ":" ++ v)
        |> String.join ";"
        |> HA.attribute "style"



-- Html.Attributes


attrIf : Bool -> (a -> H.Attribute msg) -> a -> H.Attribute msg
attrIf b fn a =
    if b then
        fn a

    else
        HA.class ""


maybeAttr : (a -> H.Attribute msg) -> Maybe a -> H.Attribute msg
maybeAttr fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (HA.class "")



-- Html


maybeHtml : (a -> H.Html msg) -> Maybe a -> H.Html msg
maybeHtml fn a =
    a
        |> Maybe.map fn
        |> Maybe.withDefault (H.text "")



-- Html.Events


enterDecoder : a -> D.Decoder a
enterDecoder a =
    D.field "key" D.string
        |> D.andThen
            (\key ->
                if key == "Enter" then
                    D.succeed a

                else
                    D.fail "Invalid key."
            )


onEnter : msg -> H.Attribute msg
onEnter msg =
    HE.on "keyup" (enterDecoder msg)



-- Basics


stringIf : Bool -> String -> String -> String
stringIf v a b =
    if v then
        a

    else
        b


limitString : Maybe Int -> String -> String
limitString limit str =
    limit
        |> Maybe.map (\l -> String.left l str)
        |> Maybe.withDefault str
