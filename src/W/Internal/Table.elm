module W.Internal.Table exposing (TableGroup(..), toTableGroup)

import Dict


type TableGroup a
    = TableGroups (List ( String, TableGroup a ))
    | TableRows (List a)


toTableGroup : List (a -> String) -> List a -> TableGroup a
toTableGroup xs rows =
    case xs of
        [] ->
            TableRows rows

        h :: tail ->
            rows
                |> List.foldl
                    (\row acc ->
                        let
                            key : String
                            key =
                                h row
                        in
                        Dict.update key
                            (\items ->
                                case items of
                                    Just items_ ->
                                        Just (items_ ++ [ row ])

                                    Nothing ->
                                        Just [ row ]
                            )
                            acc
                    )
                    Dict.empty
                |> Dict.toList
                |> List.map
                    (\( k, kRows ) ->
                        ( k, toTableGroup tail kRows )
                    )
                |> TableGroups
