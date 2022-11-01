module W.Table exposing
    ( view
    , groups, highlight, headerHeight, Attribute
    , onClick, onMouseEnter, onMouseLeave
    , string, int, float, bool, html, Column
    , size, noAutosize, alignRight, alignLeft, alignCenter, columnHtmlAttrs, ColumnAttribute
    , htmlAttrs
    )

{-|

@docs view
@docs groups, highlight, headerHeight, Attribute
@docs onClick, onMouseEnter, onMouseLeave
@docs string, int, float, bool, html, Column
@docs size, noAutosize, alignRight, alignLeft, alignCenter, columnHtmlAttrs, ColumnAttribute
@docs htmlAttrs

-}

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
    { headerHeight : Int
    , groups : List (a -> String)
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
    { headerHeight = 40
    , groups = []
    , highlight = \_ -> False
    , onClick = Nothing
    , onMouseEnter = Nothing
    , onMouseLeave = Nothing
    , htmlAttributes = []
    }


{-| -}
headerHeight : Int -> Attribute msg a
headerHeight v =
    Attribute (\attrs -> { attrs | headerHeight = v })


{-| -}
groups : List (a -> String) -> Attribute msg a
groups v =
    Attribute (\attrs -> { attrs | groups = v })


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



-- Column Attributes


{-| -}
type Column a msg
    = Column
        { label : String
        , size : Maybe Float
        , toHtml : a -> H.Html msg
        , attrs : ColumnAttributes msg
        }


{-| -}
type ColumnAttribute msg
    = ColumnAttribute (ColumnAttributes msg -> ColumnAttributes msg)


type alias ColumnAttributes msg =
    { size : Maybe String
    , autosize : Bool
    , alignment : H.Attribute msg
    , customLabel : Maybe (H.Html msg)
    , htmlAttributes : List (H.Attribute msg)
    }


applyColumnAttrs : ColumnAttributes msg -> List (ColumnAttribute msg) -> ColumnAttributes msg
applyColumnAttrs default attrs =
    List.foldl (\(ColumnAttribute fn) a -> fn a) default attrs


defaultColumnAttrs : ColumnAttributes msg
defaultColumnAttrs =
    { size = Nothing
    , autosize = True
    , alignment = HA.class "ew-flex-start"
    , customLabel = Nothing
    , htmlAttributes = []
    }


{-| -}
columnHtmlAttrs : List (H.Attribute msg) -> ColumnAttribute msg
columnHtmlAttrs v =
    ColumnAttribute (\attrs -> { attrs | htmlAttributes = v })


{-| -}
alignLeft : ColumnAttribute msg
alignLeft =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-flex-start" })


{-| -}
alignRight : ColumnAttribute msg
alignRight =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-flex-end" })


{-| -}
alignCenter : ColumnAttribute msg
alignCenter =
    ColumnAttribute (\attrs -> { attrs | alignment = HA.class "ew-flex-center" })


{-| -}
size : Int -> ColumnAttribute msg
size v =
    ColumnAttribute (\attrs -> { attrs | size = Just (pxString v) })


{-| -}
noAutosize : ColumnAttribute msg
noAutosize =
    ColumnAttribute (\attrs -> { attrs | autosize = False })



-- View


{-| -}
view : List (Attribute msg a) -> List (Column a msg) -> List a -> H.Html msg
view attrs_ columns data =
    let
        attrs : Attributes msg a
        attrs =
            applyAttrs attrs_

        columnSize : String
        columnSize =
            if List.isEmpty columns then
                "100%"

            else
                columns
                    |> List.length
                    |> toFloat
                    |> (/) 1
                    |> pctString
    in
    if List.isEmpty attrs.groups then
        viewWrapper
            attrs.htmlAttributes
            (viewTableHead columnSize attrs columns)
            (viewTableBody columnSize attrs columns data)

    else
        viewWrapper
            attrs.htmlAttributes
            (viewTableHead columnSize attrs columns)
            (W.Internal.Table.toTableGroup attrs.groups data
                |> viewTableGroup columnSize attrs columns
            )


viewWrapper : List (H.Attribute msg) -> H.Html msg -> H.Html msg -> H.Html msg
viewWrapper htmlAttrs_ header table =
    H.article
        (htmlAttrs_ ++ [ HA.class "ew-bg-base-bg ew-text-base-fg ew-font-text ew-overflow-auto" ])
        [ header
        , table
        ]


viewTable : List (H.Html msg) -> H.Html msg
viewTable =
    H.section
        []


viewTableHead : String -> Attributes msg a -> List (Column a msg) -> H.Html msg
viewTableHead columnSize attrs columns =
    H.header
        [ HA.class "ew-flex ew-sticky ew-z-20 ew-top-0 ew-z-10 ew-bg-base-bg ew-box-border"
        , HA.class "ew-border-0 ew-border-b ew-border-solid ew-border-base-aux/10"
        , HA.style "height" (pxString attrs.headerHeight)
        ]
        (List.map (viewTableHeaderCell columnSize) columns)


viewTableHeaderCell : String -> Column a msg -> H.Html msg
viewTableHeaderCell columnSize (Column column) =
    H.p
        [ HA.class "ew-m-0 ew-p-2 ew-box-border ew-font-semibold ew-text-sm ew-text-base-aux"
        , HA.class "ew-flex ew-items-center"
        , HA.style "min-width" "48px"
        , column.attrs.alignment
        , WH.attrIf
            column.attrs.autosize
            (HA.style "width")
            (Maybe.withDefault columnSize column.attrs.size)
        ]
        [ H.text column.label
        ]


viewTableGroupHeader : Attributes msg a -> String -> H.Html msg
viewTableGroupHeader attrs label =
    H.p
        [ HA.class "ew-m-0 ew-p-2"
        , HA.class "ew-bg-base-bg"
        , HA.class "ew-border-0 ew-border-b ew-border-solid ew-border-base-aux/10"
        , HA.class "ew-font-text ew-text-sm ew-font-medium ew-text-base-aux"
        , HA.class "ew-sticky ew-z-10"
        , HA.style "top" (pxString attrs.headerHeight)
        ]
        [ H.text label ]


viewTableGroup : String -> Attributes msg a -> List (Column a msg) -> TableGroup a -> H.Html msg
viewTableGroup columnSize attrs columns tableGroup =
    case tableGroup of
        TableGroups gs ->
            gs
                |> List.map
                    (\( groupLabel, subGroup ) ->
                        H.div []
                            [ viewTableGroupHeader attrs groupLabel
                            , viewTableGroup columnSize attrs columns subGroup
                            ]
                    )
                |> H.div []

        TableRows rows ->
            viewTable
                [ viewTableBody columnSize attrs columns rows
                ]


viewTableBody : String -> Attributes msg a -> List (Column a msg) -> List a -> H.Html msg
viewTableBody columnSize attrs columns data =
    H.ol
        [ HA.class "ew-list-none ew-m-0 ew-p-0"
        , WH.maybeAttr HE.onMouseLeave attrs.onMouseLeave
        ]
        (data
            |> List.map
                (\datum ->
                    H.li
                        [ HA.class "ew-flex ew-p-0 ew-items-stretch"
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
                                    H.p
                                        (column.attrs.htmlAttributes
                                            ++ [ HA.class "ew-shrink-0 ew-box-border ew-m-0 ew-p-2 ew-break-words"
                                               , HA.class "ew-flex ew-items-center"
                                               , column.attrs.alignment
                                               , HA.style "min-width" "48px"
                                               , WH.attrIf
                                                    column.attrs.autosize
                                                    (HA.style "width")
                                                    (Maybe.withDefault columnSize column.attrs.size)
                                               ]
                                        )
                                        [ column.toHtml datum ]
                                )
                        )
                )
        )



-- Column Builders


{-| -}
string : String -> (a -> String) -> List (ColumnAttribute msg) -> Column a msg
string label fn attrs_ =
    let
        attrs : ColumnAttributes msg
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
int : String -> (a -> Int) -> List (ColumnAttribute msg) -> Column a msg
int label fn attrs_ =
    let
        attrs : ColumnAttributes msg
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-justify-end" }
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , toHtml = \a -> H.text (String.fromInt (fn a))
        , attrs = attrs
        }


{-| -}
float : String -> (a -> Float) -> List (ColumnAttribute msg) -> Column a msg
float label fn attrs_ =
    let
        attrs : ColumnAttributes msg
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-justify-end" }
                attrs_
    in
    Column
        { label = label
        , size = Nothing
        , toHtml = \a -> H.text (String.fromFloat (fn a))
        , attrs = attrs
        }


{-| -}
bool : String -> (a -> Bool) -> List (ColumnAttribute msg) -> Column a msg
bool label fn attrs_ =
    let
        attrs : ColumnAttributes msg
        attrs =
            applyColumnAttrs
                { defaultColumnAttrs | alignment = HA.class "ew-justify-center" }
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
html : String -> (a -> field) -> List (ColumnAttribute msg) -> (field -> H.Html msg) -> Column a msg
html label field attrs_ fn =
    let
        attrs : ColumnAttributes msg
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
