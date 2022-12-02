module W.Attributes exposing (noAttr)

import W.Internal.Attributes exposing (Attribute(..))


noAttr : Attribute a
noAttr =
    Attribute identity
