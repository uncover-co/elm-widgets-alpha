module W.Table exposing
    ( view
    , string, int, float, bool, html, Column
    , size, alignRight, alignLeft, alignCenter, columnHtmlAttrs, ColumnAttribute
    , groups, highlight
    , onClick, onMouseEnter, onMouseLeave
    , htmlAttrs, noAttr, Attribute
    , toGroup
    )

{-|

@docs view


# Columns

@docs string, int, float, bool, html, Column


# Column Attributes

@docs size, alignRight, alignLeft, alignCenter, columnHtmlAttrs, ColumnAttribute


# Table Attributes

@docs groups, highlight


# Actions

@docs onClick, onMouseEnter, onMouseLeave


# Html

@docs htmlAttrs, noAttr, Attribute

-}

import Dict
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import W.InputCheckbox
import W.Internal.Helpers as WH
import W.Internal.Table exposing (TableGroup(..))



-- Table Attributes


{-| -}
type Attribute msg a
    = Attribute (Attributes msg a -> Attributes msg a)


type alias Attributes msg a =
    { groups : Maybe (a -> String)
    , highlight : a -> Bool
    , onClick : Maybe (a -> msg)
    , onMouseEnter : Maybe (a -> msg)
    , onMouseLeave : Maybe msg
    , htmlAttributes : List (H.Attribute msg)
    }


applyAttrs : List (Attribute msg a) -> Attributes msg a
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg a
defaultAttrs =
    { groups = Nothing
    , highlight = \_ -> False
    , onClick = Nothing
    , onMouseEnter = Nothing
    , onMouseLeave = Nothing
    , htmlAttributes = []
    }


{-| -}
groups : (a -> String) -> Attribute msg a
groups v =
    Attribute (\attrs -> { attrs | groups = Just v })


{-| -}
highlight : (a -> Bool) -> Attribute msg a
highlight v =
    Attribute (\attrs -> { attrs | highlight = v })


{-| -}
onMouseEnter : (a -> msg) -> Attribute msg a
onMouseEnter v =
    Attribute (\attrs -> { attrs | onMouseEnter = Just v })


{-| -}
onMouseLeave : msg -> Attribute msg a
onMouseLeave v =
    Attribute (\attrs -> { attrs | onMouseLeave = Just v })


{-| -}
onClick : (a -> msg) -> Attribute msg a
onClick v =
    Attribute (\attrs -> { attrs | onClick = Just v })


{-| -}
htmlAttrs : List (H.Attribute msg) -> Attribute msg a
htmlAttrs v =
    Attribute <| \attrs -> { attrs | htmlAttributes = v }


{-| -}
noAttr : Attribute msg a
noAttr =
    Attribute identity



-- Column Attributes


{-| -}
type Column msg a
    = Column
        { label : String
        , size : Maybe Float
        , toHtml : a -> H.Html msg
        , attrs : ColumnAttributes msg a
        }


{-| -}
type ColumnAttribute msg a
    = ColumnAttribute (ColumnAttributes msg a -> ColumnAttributes msg a)


type alias ColumnAttributes msg a =
    { size : Maybe String
    , largeScreenOnly : Bool
    , alignment : H.Attribute msg
    , customLabel : Maybe (H.Html msg)
    , toGroup : Maybe (List a -> H.Html msg)
    , htmlAttributes : List (H.Attribute msg)
    }


applyColumnAttrs : ColumnAttributes msg a -> List (ColumnAttribute msg a) -> ColumnAttributes msg a
applyColumnAttrs default attrs =
    List.foldl (\(ColumnAttribute fn) a -> fn a) default attrs


defaultColumnAttrs : ColumnAttributes msg a
defaultColumnAttrs =
    { size = Nothing
    , largeScreenOnly = False
    , toGroup = Nothing
    , alignment = HA.class "ew-text-left"
    , customLabel = Nothing
    , htmlAttributes = []
    }


{-| -}
columnHtmlAttrs : List (H.Attribute msg) -> ColumnAttribute msg a
columnHtmlAttrs v =
    ColumnAttribute (\attrs -> { attrs | htmlAttributes = v })


{-| -}
alignLeft : ColumnAttribute msg a
alignLeft =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-text-left" })


{-| -}
alignRight : ColumnAttribute msg a
alignRight =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-text-right" })


{-| -}
alignCenter : ColumnAttribute msg a
alignCenter =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-text-center" })


{-| -}
size : Int -> ColumnAttribute msg a
size v =
    ColumnAttribute (\attrs -> { attrs | size = Just (pxString v) })


{-| -}
toGroup : (List a -> H.Html msg) -> ColumnAttribute msg a
toGroup v =
    ColumnAttribute (\attrs -> { attrs | toGroup = Just v })



-- View


{-| -}
view : List (Attribute msg a) -> List (Column msg a) -> List a -> H.Html msg
view attrs_ columns data =
    let
        attrs : Attributes msg a
        attrs =
            applyAttrs attrs_

        rows : List (H.Html msg)
        rows =
            case attrs.groups of
                Just groups_ ->
                    let
                        groupLabelColSpan : Int
                        groupLabelColSpan =
                            countWhile
                                (\(Column col) -> col.attrs.toGroup == Nothing)
                                columns
                    in
                    data
                        |> toGroupedRows groups_
                        |> List.concatMap
                            (\( k, groupRows ) ->
                                viewGroupHeader groupLabelColSpan k attrs columns groupRows
                                    :: List.map (viewTableRow attrs columns) groupRows
                            )

                Nothing ->
                    List.map (viewTableRow attrs columns) data
    in
    H.table
        (attrs.htmlAttributes
            ++ [ HA.class "ew-table ew-table-fixed ew-indent-0"
               , HA.class "ew-w-full ew-overflow-auto"
               , HA.class "ew-bg-base-bg ew-font-text ew-text-base-fg"
               ]
        )
        [ -- Table Head
          H.thead
            [ HA.class "ew-sticky ew-z-20 ew-top-0 ew-z-10"
            , HA.class "ew-bg-base-bg"
            ]
            [ H.tr [] (List.map viewTableHeaderColumn columns) ]
        , --  Table Body
          H.tbody
            [ WH.maybeAttr HE.onMouseLeave attrs.onMouseLeave ]
            rows
        ]


countWhile : (a -> Bool) -> List a -> Int
countWhile fn xs =
    xs
        |> List.foldl
            (\a ( continue, acc ) ->
                if continue && fn a then
                    ( True, acc + 1 )

                else
                    ( False, acc )
            )
            ( True, 0 )
        |> Tuple.second


toGroupedRows : (a -> String) -> List a -> List ( String, List a )
toGroupedRows groupBy_ data =
    data
        |> List.foldl
            (\row acc ->
                let
                    key : String
                    key =
                        groupBy_ row
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


viewGroupHeader : Int -> String -> Attributes msg a -> List (Column msg a) -> List a -> H.Html msg
viewGroupHeader labelColSpan label attrs columns data =
    H.tr
        [ HA.class "ew-p-0" ]
        ((if labelColSpan > 0 then
            H.td
                [ HA.colspan labelColSpan, HA.class "ew-text-left" ]
                [ H.text label ]

          else
            H.text ""
         )
            :: (columns
                    |> List.filterMap
                        (\(Column col) ->
                            col.attrs.toGroup
                                |> Maybe.map (\fn -> fn data)
                                |> Maybe.map
                                    (\x ->
                                        H.td
                                            [ col.attrs.alignment ]
                                            [ x ]
                                    )
                        )
               )
        )



-- (columns
--     |> List.map
--         (\(Column column) ->
--             H.td
--                 (column.attrs.htmlAttributes
--                     ++ [ HA.class "ew-shrink-0 ew-box-border ew-m-0 ew-p-2 ew-break-words"
--                        , column.attrs.alignment
--                        , HA.style "min-width" "48px"
--                        , WH.stylesList
--                             [ ( "min-width", "48px", True )
--                             , ( "width"
--                               , Maybe.withDefault "auto" column.attrs.size
--                               , column.attrs.size /= Nothing
--                               )
--                             ]
--                        ]
--                 )
--                 [ column.toHtml datum ]
--         )


viewTableHeaderColumn : Column msg a -> H.Html msg
viewTableHeaderColumn (Column column) =
    H.th
        [ HA.class "ew-m-0 ew-p-2 ew-box-border ew-font-semibold ew-text-sm ew-text-base-aux"
        , column.attrs.alignment
        , WH.stylesList
            [ ( "min-width", "48px", True )
            , ( "width"
              , Maybe.withDefault "auto" column.attrs.size
              , column.attrs.size /= Nothing
              )
            ]
        ]
        [ H.text column.label
        ]


viewTableRow : Attributes msg a -> List (Column msg a) -> a -> H.Html msg
viewTableRow attrs columns datum =
    H.tr
        [ HA.class "ew-p-0"
        , if attrs.highlight datum then
            HA.classList
                [ ( "ew-bg-base-aux/[0.07]", True )
                , ( "hover:ew-bg-base-aux/10", attrs.onClick /= Nothing )
                ]

          else
            HA.classList
                [ ( "hover:ew-bg-base-aux/[0.07]", attrs.onClick /= Nothing )
                ]
        , WH.maybeAttr (\onClick_ -> HE.onClick (onClick_ datum)) attrs.onClick
        , WH.maybeAttr (\onMouseEnter_ -> HE.onMouseEnter (onMouseEnter_ datum)) attrs.onMouseEnter
        ]
        (columns
            |> List.map
                (\(Column column) ->
                    H.td
                        (column.attrs.htmlAttributes
                            ++ [ HA.class "ew-shrink-0 ew-box-border ew-m-0 ew-p-2 ew-break-words"
                               , column.attrs.alignment
                               , HA.style "min-width" "48px"
                               , WH.stylesList
                                    [ ( "min-width", "48px", True )
                                    , ( "width"
                                      , Maybe.withDefault "auto" column.attrs.size
                                      , column.attrs.size /= Nothing
                                      )
                                    ]
                               ]
                        )
                        [ column.toHtml datum ]
                )
        )



-- Column Builders


{-| -}
string : String -> (a -> String) -> List (ColumnAttribute msg a) -> Column msg a
string label fn attrs_ =
    let
        attrs : ColumnAttributes msg a
        attrs =
            applyColumnAttrs
                defaultColumnAttrs
                attrs_
    in
    Column
        { label = label
        , size = Just 0.8
        , toHtml = \a -> H.text (fn a)
        , attrs = attrs
        }


{-| -}
int : String -> (a -> Int) -> List (ColumnAttribute msg a) -> Column msg a
int label fn attrs_ =
    let
        attrs : ColumnAttributes msg a
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-text-right" }
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , toHtml = \a -> H.text (String.fromInt (fn a))
        , attrs = attrs
        }


{-| -}
float : String -> (a -> Float) -> List (ColumnAttribute msg a) -> Column msg a
float label fn attrs_ =
    let
        attrs : ColumnAttributes msg a
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-text-right" }
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , toHtml = \a -> H.text (String.fromFloat (fn a))
        , attrs = attrs
        }


{-| -}
bool : String -> (a -> Bool) -> List (ColumnAttribute msg a) -> Column msg a
bool label fn attrs_ =
    let
        attrs : ColumnAttributes msg a
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-text-right" }
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , attrs = attrs
        , toHtml =
            \a ->
                W.InputCheckbox.viewReadOnly [] (fn a)
        }


{-| -}
html : String -> (a -> field) -> List (ColumnAttribute msg a) -> (field -> H.Html msg) -> Column msg a
html label field attrs_ fn =
    let
        attrs : ColumnAttributes msg a
        attrs =
            applyColumnAttrs
                defaultColumnAttrs
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , attrs = attrs
        , toHtml = fn << field
        }



-- Helpers


pctString : Float -> String
pctString v =
    String.fromFloat (v * 100) ++ "%"


pxString : Int -> String
pxString v =
    String.fromInt v ++ "px"
