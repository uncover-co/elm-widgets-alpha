module W.Internal.Attributes exposing
    ( Attr
    , applyAttrs
    , attr
    )


type Attr a msg
    = Attr (a -> a)


attr : (a -> a) -> Attr a msg
attr fn =
    Attr fn


applyAttrs : a -> List (Attr a msg) -> a
applyAttrs defaultAttrs attrs =
    List.foldl (\(Attr fn) a -> fn a) defaultAttrs attrs
