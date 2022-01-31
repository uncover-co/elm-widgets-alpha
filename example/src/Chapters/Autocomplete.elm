module Chapters.Autocomplete exposing (..)

import ElmBook.Actions exposing (logAction, logActionWithString)
import ElmBook.Chapter exposing (Chapter, chapter, renderComponentList)
import ElmWidgets as W
import ElmWidgets.Attributes as WA


result : String -> Maybe Int -> String
result search value =
    "\""
        ++ search
        ++ "\""
        ++ " "
        ++ (case value of
                Just int_ ->
                    "Just " ++ String.fromInt int_

                Nothing ->
                    "Nothing"
           )


chapter_ : Chapter x
chapter_ =
    chapter "Autocomplete"
        |> renderComponentList
            [ ( "Default"
              , W.autocomplete [ WA.placeholder "Search for a number…" ]
                    { id = "default"
                    , search = ""
                    , value = Nothing
                    , options = Just (List.range 0 10)
                    , toLabel = String.fromInt
                    , onInput = \a b -> logActionWithString "onInput" (result a b)
                    }
              )
            , ( "Loading"
              , W.autocomplete [ WA.placeholder "Fetching some options…" ]
                    { id = "loading"
                    , search = ""
                    , value = Nothing
                    , options = Nothing
                    , toLabel = String.fromInt
                    , onInput = \a b -> logActionWithString "onInput" (result a b)
                    }
              )
            ]
