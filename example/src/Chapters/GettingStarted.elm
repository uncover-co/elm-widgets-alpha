module Chapters.GettingStarted exposing (Model, chapter_, init)

import ElmBook
import ElmBook.Actions
import ElmBook.Chapter exposing (Chapter, chapter, render, withComponentOptions, withStatefulComponentList)
import ElmBook.ComponentOptions
import Html as H
import Html.Attributes as HA
import Mask
import Theme
import W.Button
import W.InputInt
import W.Modal


type alias Model =
    { phoneNumberInput : W.InputInt.Value
    }


init : Model
init =
    { phoneNumberInput = W.InputInt.init Nothing
    }


type Msg
    = OnInputPhoneNumber W.InputInt.Value


update : Msg -> Model -> Model
update msg model =
    case msg of
        OnInputPhoneNumber v ->
            { model | phoneNumberInput = v }


toMsg : Msg -> ElmBook.Msg { m | overview : Model }
toMsg =
    ElmBook.Actions.mapUpdate
        { fromState = .overview
        , toState = \s m -> { s | overview = m }
        , update = update
        }


chapter_ : Chapter { m | overview : Model }
chapter_ =
    chapter "Overview"
        |> withComponentOptions
            [ ElmBook.ComponentOptions.hiddenLabel True
            ]
        |> withStatefulComponentList
            [ ( "modal"
              , \state ->
                    H.div
                        [ HA.attribute "style" ("display: flex; align-items: center; justify-content: center; border-radius: 4px; padding: 40px 20px; background:" ++ Theme.baseAuxWithAlpha 0.1)
                        ]
                        [ W.Modal.viewToggle "my-modal-toggle"
                            [ W.Button.viewDummy []
                                [ H.text "Toggle Modal"
                                ]
                            ]
                        , W.Modal.viewToggable []
                            { id = "my-modal-toggle"
                            , children =
                                [ H.div
                                    [ HA.style "padding" "40px"
                                    , HA.style "text-align" "center"
                                    , HA.style "font-family" Theme.fontText
                                    ]
                                    [ H.text "Hello!"
                                    ]
                                ]
                            }
                        ]
              )
            , ( "input-int"
              , \state ->
                    W.InputInt.view
                        [ W.InputInt.mask
                            (Mask.number "(##) ##### ####")
                        ]
                        { onInput = OnInputPhoneNumber
                        , value = state.overview.phoneNumberInput
                        }
                        |> H.map toMsg
              )
            ]
        |> render """
**elm-widgets** is a collection of stateless widgets designed to make your experience building elm applications easier and even more delightful.

---

## Stateless Views

Easy to plug-n-play. No state management. No glue code.

<component with-label="modal" />

```elm
W.Modal.view
    [ W.Modal.toggable "my-modal" ]
    [ H.div [] [ H.text "Hello from modal!" ]
    ]

W.Modal.viewToggle "my-modal"
    [ W.Button.viewDummy []
        [ H.text "Toggle Modal"
        ]
    ]
```

<component with-label="input-int" />

```elm
W.InputInt.view
    [ W.InputInt.mask
        (Mask.number "(##) ##### ####")
    ]
    { onInput = onInputPhoneNumber
    , value = model.phoneNumberInput
    }
```

> Note that the `Mask` module shown in this example is not actually part of **elm-widgets** but you can find one such package [here](https://package.elm-lang.org/packages/Massolari/elm-mask/latest/).

## Use the platform

We're trying to push the boundaries of what is currently possible by smart use of HTML, CSS and Elm views.

```elm
W.InputAutocomplete.view [] 
    { id = "tag-selector"
    , input = ""
    , value = Nothing
    , options = model.allTags
    , toLabel = .name
    , onInput = SelectedTag
    }
```

## Type-safe inputs and outputs

Keep using your Elm types on your view boundaries.

```elm
W.InputDate.view []
    { value = currentDate
    , onInput = SelectedDate
    }

W.InputInt.view []
    { value = W.InputInt.value model.value
    , onInput = SelectedDate
    }

W.InputSelect.view
    [ W.InputSelect.prefix "Role"
    ]
    { value = Role.Viewer
    , options = [ Role.Viewer, Role.Editor, Role.Admin ]
    , toLabel = Role.toString
    , onInput = SelectedRole
    }

type alias Model =
    { selectedDate : Maybe Time.Posix
    }

type Msg
    = SelectedDate (Maybe Posix)
    | SelectedRole Role.Role
```

## Themable

All your widgets should be able to fit your app's look and feel.

Dark mode? Yeah! That too.
"""
