module W.Internal.TableTest exposing (..)

import Expect exposing (equal)
import Test exposing (Test, describe, test)
import W.Internal.Table exposing (TableGroup(..))


type alias InputRecord =
    { name : String
    , region : String
    , age : Int
    }


input : List InputRecord
input =
    [ { name = "Georges", region = "CE", age = 33 }
    , { name = "Murilo", region = "CE", age = 27 }
    , { name = "Gabi", region = "SP", age = 28 }
    , { name = "Malu", region = "SP", age = 25 }
    , { name = "Malu", region = "SP", age = 45 }
    ]


suite : Test
suite =
    describe "W.Internal.Table.toTableGroup"
        [ test "Should return rows when there is no group" <|
            \_ ->
                equal
                    (W.Internal.Table.toTableGroup [] input)
                    (TableRows input)
        , test "Should return groups when there is a single group defined" <|
            \_ ->
                equal
                    (W.Internal.Table.toTableGroup [ .region ] input)
                    (TableGroups
                        [ ( "CE"
                          , TableRows
                                [ { name = "Georges", region = "CE", age = 33 }
                                , { name = "Murilo", region = "CE", age = 27 }
                                ]
                          )
                        , ( "SP"
                          , TableRows
                                [ { name = "Gabi", region = "SP", age = 28 }
                                , { name = "Malu", region = "SP", age = 25 }
                                , { name = "Malu", region = "SP", age = 45 }
                                ]
                          )
                        ]
                    )
        , test "Should return nested groups when there is multiple groups defined" <|
            \_ ->
                equal
                    (W.Internal.Table.toTableGroup [ .region, .name ] input)
                    (TableGroups
                        [ ( "CE"
                          , TableGroups
                                [ ( "Georges", TableRows [ { name = "Georges", region = "CE", age = 33 } ] )
                                , ( "Murilo", TableRows [ { name = "Murilo", region = "CE", age = 27 } ] )
                                ]
                          )
                        , ( "SP"
                          , TableGroups
                                [ ( "Gabi", TableRows [ { name = "Gabi", region = "SP", age = 28 } ] )
                                , ( "Malu"
                                  , TableRows
                                        [ { name = "Malu", region = "SP", age = 25 }
                                        , { name = "Malu", region = "SP", age = 45 }
                                        ]
                                  )
                                ]
                          )
                        ]
                    )
        ]
