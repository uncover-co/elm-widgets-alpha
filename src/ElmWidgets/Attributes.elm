module ElmWidgets.Attributes exposing
    ( background
    , color
    , disabled
    , fill
    , placeholder
    , shadow
    )


color : String -> { a | color : String } -> { a | color : String }
color v a =
    { a | color = v }


background : String -> { a | background : String } -> { a | background : String }
background v a =
    { a | background = v }


shadow : String -> { a | shadow : String } -> { a | shadow : String }
shadow v a =
    { a | shadow = v }


disabled : Bool -> { a | disabled : Bool } -> { a | disabled : Bool }
disabled v a =
    { a | disabled = v }


fill : Bool -> { a | fill : Bool } -> { a | fill : Bool }
fill v a =
    { a | fill = v }


placeholder : String -> { a | placeholder : Maybe String } -> { a | placeholder : Maybe String }
placeholder v a =
    { a | placeholder = Just v }
