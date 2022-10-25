module W.Table exposing
    ( view
    , string, int, float, bool, html
    , onClick, groups, maxHeight
    )

{-|

@docs view
@docs string, int, float, bool, html
@docs onClick, groups, maxHeight

-}

import Html as H
import Html.Attributes as HA
import Html.Events as HE
import W.InputCheckbox
import W.Internal.Helpers as WH
import W.Internal.Table exposing (TableGroup(..))



-- Table Attributes


type Attribute msg a
    = Attribute (Attributes msg a -> Attributes msg a)


type alias Attributes msg a =
    { onClick : Maybe (a -> msg)
    , headerHeight : Int
    , maxHeight : Maybe String
    , groups : List (a -> String)
    }


applyAttrs : List (Attribute msg a) -> Attributes msg a
applyAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs


defaultAttrs : Attributes msg a
defaultAttrs =
    { onClick = Nothing
    , headerHeight = 40
    , maxHeight = Nothing
    , groups = []
    }


{-| -}
maxHeight : String -> Attribute msg a
maxHeight v =
    Attribute (\attrs -> { attrs | maxHeight = Just v })


{-| -}
onClick : (a -> msg) -> Attribute msg a
onClick v =
    Attribute (\attrs -> { attrs | onClick = Just v })


{-| -}
groups : List (a -> String) -> Attribute msg a
groups v =
    Attribute (\attrs -> { attrs | groups = v })



-- Column Attributes


type Column a msg
    = Column
        { label : String
        , size : Maybe Float
        , toHtml : a -> H.Html msg
        , attrs : ColumnAttributes msg
        }


type ColumnAttribute msg
    = ColumnAttribute (ColumnAttributes msg -> ColumnAttributes msg)


type alias ColumnAttributes msg =
    { class : String
    , width : Maybe String
    , alignment : H.Attribute msg
    , customLabel : Maybe (H.Html msg)
    }


applyColumnAttrs : ColumnAttributes msg -> List (ColumnAttribute msg) -> ColumnAttributes msg
applyColumnAttrs default attrs =
    List.foldl (\(ColumnAttribute fn) a -> fn a) default attrs


defaultColumnAttrs : ColumnAttributes msg
defaultColumnAttrs =
    { class = ""
    , width = Nothing
    , alignment = HA.class "ew-flex-start"
    , customLabel = Nothing
    }



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
            attrs.maxHeight
            (viewTableHead columnSize attrs columns)
            (viewTableBody columnSize attrs columns data)

    else
        viewWrapper
            attrs.maxHeight
            (viewTableHead columnSize attrs columns)
            (W.Internal.Table.toTableGroup attrs.groups data
                |> viewTableGroup columnSize attrs columns
            )


viewWrapper : Maybe String -> H.Html msg -> H.Html msg -> H.Html msg
viewWrapper maxHeight_ header table =
    H.article
        [ HA.class "ew-bg-base-bg ew-text-base-fg ew-font-text ew-overflow-auto"
        , WH.maybeAttr (HA.style "max-height") maxHeight_
        ]
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
        [ HA.class "ew-flex ew-sticky ew-top-0 ew-bg-base-bg ew-z-10 ew-box-border"
        , HA.class "ew-border-0 ew-border-b ew-border-solid ew-border-base-aux/20"
        , HA.style "height" (pxString attrs.headerHeight)
        ]
        (List.map (viewTableHeaderCell columnSize) columns)


viewTableHeaderCell : String -> Column a msg -> H.Html msg
viewTableHeaderCell columnSize (Column column) =
    H.p
        [ HA.class "ew-m-0 ew-p-2 ew-font-semibold ew-text-sm"
        , HA.style "width" (Maybe.withDefault columnSize column.attrs.width)
        , HA.class "ew-flex ew-items-center"
        , column.attrs.alignment
        ]
        [ H.text column.label
        ]


viewTableGroupHeader : Attributes msg a -> String -> H.Html msg
viewTableGroupHeader attrs label =
    H.p
        [ HA.class "ew-m-0 ew-p-2"
        , HA.class "ew-bg-base-bg"
        , HA.class "before:ew-content-[''] before:ew-block before:ew-inset-0 before:ew-absolute before:ew-bg-base-fg/[0.07]"
        , HA.class "ew-border-0 ew-border-b ew-border-solid ew-border-base-aux/20"
        , HA.class "ew-font-text ew-text-sm ew-font-medium ew-text-base-fg"
        , HA.class "ew-sticky"
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
        [ HA.class "ew-list-none ew-m-0 ew-p-0" ]
        (data
            |> List.map
                (\datum ->
                    H.li
                        (case attrs.onClick of
                            Just onClick_ ->
                                [ HE.onClick (onClick_ datum)
                                , HA.class "ew-group"
                                , HA.class "ew-flex ew-items-stretch"
                                ]

                            Nothing ->
                                [ HA.class "ew-flex ew-p-0 ew-items-stretch" ]
                        )
                        (columns
                            |> List.map
                                (\(Column column) ->
                                    H.p
                                        [ HA.class "ew-shrink-0 ew-box-border ew-m-0 ew-p-2 ew-break-words"
                                        , HA.class "ew-flex ew-items-center"
                                        , column.attrs.alignment
                                        , HA.style "width"
                                            (Maybe.withDefault columnSize column.attrs.width)
                                        , HA.style "min-width" "48px"
                                        , HA.classList
                                            [ ( "group-hover:ew-bg-base-aux/[0.07]"
                                              , attrs.onClick /= Nothing
                                              )
                                            ]
                                        ]
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
