module ElmWidgets.Attributes exposing
    ( background
    , color
    , disabled
    )


color : String -> { a | color : String } -> { a | color : String }
color v a =
    { a | color = v }


background : String -> { a | background : String } -> { a | background : String }
background v a =
    { a | background = v }


disabled : Bool -> { a | disabled : Bool } -> { a | disabled : Bool }
disabled v a =
    { a | disabled = v }
