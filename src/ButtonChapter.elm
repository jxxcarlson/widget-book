module ButtonChapter exposing (Model, buttonChapter, init)

import Element exposing (Element)
import ElmBook.Actions exposing (mapUpdate)
import ElmBook.Chapter exposing (chapter, render, withStatefulComponentList)
import ElmBook.ElmUI exposing (Book, Chapter)
import UILibrary.Button as Button


type Msg
    = NoOp


type alias Model =
    Int


init : Model
init =
    0


buttonChapter : Chapter { x | buttonChapterModel : Model }
buttonChapter =
    chapter "Buttons"
        |> withStatefulComponentList
            [ ( "Large Primary", \{ buttonChapterModel } -> viewLargeButtons buttonChapterModel |> Element.map mapUpdater )
            , ( "Small Primary", \{ buttonChapterModel } -> viewSmallButtons buttonChapterModel |> Element.map mapUpdater )
            ]
        |> render content


mapUpdater =
    mapUpdate
        { toState = \state chapterModel_ -> { state | buttonChapterModel = chapterModel_ }
        , fromState = \state -> state.buttonChapterModel
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


viewLargeButtons : Model -> Element Msg
viewLargeButtons model =
    Element.row [ Element.spacing 24 ]
        [ Button.largePrimary { msg = NoOp, status = Button.Active, label = Button.Text "Active", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.Inactive, label = Button.Text "Inactive", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.Active, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        ]


viewSmallButtons : Model -> Element Msg
viewSmallButtons model =
    Element.row [ Element.spacing 24 ]
        [ Button.smallPrimary { msg = NoOp, status = Button.Active, label = Button.Text "Active", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Inactive, label = Button.Text "Inactive", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Active, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        ]


content =
    """

The `UILibrary.Button` module provides library of stylistically coherent buttons.  Here
is a large primary button with a text label:

```elm
Button.largePrimary
   {    msg = OpenEditor
      , status = Button.Active
      , label = Button.Text "Open Editor"
      , tooltipText = Nothing
   }
```

And here is a large primary button with an icon label:

```elm
Button.largePrimary
   {    msg = OpenBugReporter
      , status = Button.Active
      , label = Button.Icon "bug.png"
      , tooltipText = Just "Report a bug"
   }
```

The values for `status` are

```elm
type Status
    = Active
    | Inactive
    | Highlighted
```

### Gallery

<component with-label="Large Primary" />

<component with-label="Small Primary" />


"""
