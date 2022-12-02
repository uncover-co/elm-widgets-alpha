module W.Internal.Attributes exposing (Attribute(..), applyAttrs)


type Attribute msg a
    = Attribute (a -> a)


applyAttrs : a -> List (Attribute msg a) -> a
applyAttrs defaultAttrs attrs =
    List.foldl (\(Attribute fn) a -> fn a) defaultAttrs attrs
