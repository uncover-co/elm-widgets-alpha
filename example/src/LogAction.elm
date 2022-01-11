module LogAction exposing (..)

import ElmBook
import ElmBook.Actions exposing (logAction, logActionWith)


logActionWithMaybeInt : String -> Maybe Int -> ElmBook.Msg x
logActionWithMaybeInt label i =
    i
        |> Maybe.map (logActionWith (\i_ -> "Just " ++ String.fromInt i_) label)
        |> Maybe.withDefault (logAction (label ++ ": Nothing"))
