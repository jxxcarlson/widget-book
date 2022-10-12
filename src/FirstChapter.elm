module FirstChapter exposing (firstChapter)


import ElmBook.Chapter exposing (chapter, renderComponent)
import Html exposing (..)
import Element exposing(Element)
import UILibrary.Button as Button
import UILibrary.Color as Color
import Element.Font as Font
import ElmBook.ElmUI exposing (Book, book, Chapter)

type Msg = NoOp


firstChapter : Chapter x
firstChapter =
    chapter "The First Chapter"
        |> renderComponent
            (Element.el [] <| Element.text "Hello")


component : Element Msg
component =
   testButton 




defaultButtonStyle : Button.Style msg
defaultButtonStyle = 
   { tooltipPlacement = Element.above
   , attributes = [Color.bgGray 0.2]
   , labelAttributes = [Color.fgGray 1.0, Element.centerX, Element.centerY, Font.size 14]
   }

testButton = Button.template defaultButtonStyle {msg = NoOp, label = "Cancel", tooltipText = "Are you sure?"}


content : String
content = """
# It all starts with a chapter

Oh, look – A wild real component!

<component />

Woof! Moving on...
"""