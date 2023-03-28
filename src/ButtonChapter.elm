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
            , ( "Small Secondary", \{ buttonChapterModel } -> viewSmallSecondaryButtons buttonChapterModel |> Element.map mapUpdater )
            , ( "List Item", \{ buttonChapterModel } -> viewListItems buttonChapterModel |> Element.map mapUpdater )
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
        , Button.largePrimary { msg = NoOp, status = Button.Waiting, label = Button.Text "Waiting", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.Active, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.ActiveSpecialDark, label = Button.Text "Special", tooltipText = Nothing }
        , Button.largePrimary { msg = NoOp, status = Button.ActiveTransparent, label = Button.Text "Transparent", tooltipText = Nothing }
        ]


viewSmallButtons : Model -> Element Msg
viewSmallButtons model =
    Element.row [ Element.spacing 24 ]
        [ Button.smallPrimary { msg = NoOp, status = Button.Active, label = Button.Text "Active", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Inactive, label = Button.Text "Inactive", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Waiting, label = Button.Text "Waiting", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.Active, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        , Button.smallPrimary { msg = NoOp, status = Button.ActiveTransparent, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        ]


viewSmallSecondaryButtons : Model -> Element Msg
viewSmallSecondaryButtons model =
    Element.row [ Element.spacing 24 ]
        [ Button.smallSecondary { msg = NoOp, status = Button.Active, label = Button.Text "Active", tooltipText = Nothing }
        , Button.smallSecondary { msg = NoOp, status = Button.Inactive, label = Button.Text "Inactive", tooltipText = Nothing }
        , Button.smallSecondary { msg = NoOp, status = Button.Waiting, label = Button.Text "Waiting", tooltipText = Nothing }
        , Button.smallSecondary { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.smallSecondary { msg = NoOp, status = Button.Active, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        , Button.smallSecondary { msg = NoOp, status = Button.ActiveTransparent, label = Button.Icon "bug-strong.png", tooltipText = Nothing }
        ]


viewListItems : Model -> Element Msg
viewListItems model =
    Element.row [ Element.spacing 24 ]
        [ Button.listItem [] { msg = NoOp, status = Button.Active, label = Button.Text "Active", tooltipText = Nothing }
        , Button.listItem [] { msg = NoOp, status = Button.Inactive, label = Button.Text "Inactive", tooltipText = Nothing }
        , Button.listItem [] { msg = NoOp, status = Button.Waiting, label = Button.Text "Waiting", tooltipText = Nothing }
        , Button.listItem [] { msg = NoOp, status = Button.Highlighted, label = Button.Text "Highlighted", tooltipText = Nothing }
        , Button.listItem [ Button.FontItalic ] { msg = NoOp, status = Button.Active, label = Button.Text "Active, italic", tooltipText = Nothing }
        , Button.listItem [ Button.FontUnderline ] { msg = NoOp, status = Button.Active, label = Button.Text "Active, underline", tooltipText = Nothing }
        , Button.listItem [ Button.FontItalic, Button.FontUnderline ] { msg = NoOp, status = Button.Active, label = Button.Text "Active, italic & underline", tooltipText = Nothing }
        ]


content =
    """

The `UILibrary.Button` module provides library of stylistically coherent buttons,
`largePrimary` and `smallPrimary`:


### Gallery

<component with-label="Large Primary" />

<component with-label="Small Primary" />

<component with-label="Small Secondary" />

<component with-label="List Item" />

### API

```
module UILibrary.Button

largePrimary : Config msg -> Element msg

smallPrimary : Config msg -> Element msg

type alias Config msg =
    {  msg : msg
     , label : Label
     , status : Status
     , tooltipText : Maybe String }

type Status
    = Active
    | Inactive
    | Waiting
    | Highlighted
```

### Usage

Here is a button with a text label:

```elm
Button.largePrimary
   {    msg = OpenEditor
      , status = Button.Active
      , label = Button.Text "Open Editor"
      , tooltipText = Nothing
   }
```

And here is one with an icon label:

```elm
Button.largePrimary
   {    msg = OpenBugReporter
      , status = Button.Active
      , label = Button.Icon "bug.png"
      , tooltipText = Just "Report a bug"
   }
```



"""
