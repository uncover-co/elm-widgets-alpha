module W.Attributes exposing (noAttr)

import W.Internal.Attributes as WA


noAttr : WA.Attr msg a
noAttr =
    WA.attr identity
