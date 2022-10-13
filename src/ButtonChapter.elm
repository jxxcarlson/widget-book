module ButtonChapter exposing (Model, init, buttonChapter)


import ElmBook.Chapter exposing (chapter, renderStatefulComponent, withStatefulComponentList, renderStatefulComponentList, render)
import ElmBook.Actions exposing (mapUpdate)
import Html exposing (..)
import Element exposing(Element)
import UILibrary.Button
import UILibrary.Color as Color
import Element.Font as Font
import ElmBook.ElmUI exposing (Book, book, Chapter)
import Element.Background as Background



type Msg = NoOp

type alias Model = Int


init : Model
init = 0



buttonChapter : Chapter { x | buttonChapterModel : Model }
buttonChapter =
    chapter "Buttons"
      |> withStatefulComponentList [ 
           ("Cancel button", \{ buttonChapterModel } -> view buttonChapterModel  |> Element.map mapUpdater  )
         ]
      |> render content
      

mapUpdater = mapUpdate
        { toState = \state chapterModel_ -> { state | buttonChapterModel = chapterModel_ }
        , fromState = \state -> state.buttonChapterModel
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> model

view : Model -> Element Msg
view model =
   Element.column [Element.spacing 12] 
     [ Element.text "This is a test."
      , cancelButton
     ] 

content = """
## Buttons

The `UILibrary.Button.template` function provides a simple 
way to manufacture buttons for your app in a stylistically
consistent yet flexible way:

```elm
cancelButton = 
  UILibrary.Button.template 
    myStyle {msg = NoOp, label = "Cancel", tooltipText = Nothing}
```

<component with-label="Cancel button" />

For the `myStyle` argument, there is a default value, which 
is what we use in the example:

```
myStyle = UILibrary.Button.defaultStyle
```

It is defined as follows:

```elm
defaultStyle : Style msg
defaultStyle = 
   { tooltipPlacement = Element.above
   , attributes = [
         UILibrary.Color.bgGray 0.2, Element.paddingXY 12 6 
       , Element.mouseDown [ Background.color Color.darkRed] ]
   , labelAttributes = [
         UILibrary.Color.fgGray 1.0, Element.centerX
       , Element.centerY, Font.size 14]
   }
```
However, you can supply your own style using


```elm
type alias Style msg =
    { tooltipPlacement : Element msg -> Element.Attribute msg
    , attributes : List (Element.Attribute msg)
    , labelAttributes : List (Element.Attribute msg)
    }
```
"""


cancelButton = UILibrary.Button.template UILibrary.Button.defaultStyle {msg = NoOp, label = "Cancel", tooltipText = Nothing}

    