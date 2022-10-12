module FirstChapter exposing (Model, init, chapter_)


import ElmBook.Chapter exposing (chapter, renderStatefulComponent)
-- import ElmBook.Chapter exposing (Chapter, chapter, renderStatefulComponent)
import ElmBook.Actions exposing (mapUpdate)
import Html exposing (..)
import Element exposing(Element)
import UILibrary.Button as Button
import UILibrary.Color as Color
import Element.Font as Font
import ElmBook.ElmUI exposing (Book, book, Chapter)

type Msg = NoOp

type alias Model = Int


init : Model
init = 0


chapter_ : Chapter { x | chapter1Model : Model }
chapter_ =
    chapter "Chapter 1"
        |> renderStatefulComponent (
            \{ chapter1Model } ->
                view chapter1Model
                    |> Element.map (
                        mapUpdate
                            { toState = \state chapter1Model_ -> { state | chapter1Model = chapter1Model_ }
                            , fromState = \state -> state.chapter1Model
                            , update = update
                            }
                    )
        )


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> model


view : Model -> Element Msg
view model =
    -- input [ value model.value, onInput UpdateValue ] []
   Element.column [] 
     [ Element.text "This is a test."
      , testButton
     ]



-- firstChapter : Chapter x
-- firstChapter =
--     chapter "The First Chapter"
--         |> renderComponent
--             (Element.el [] <| Element.text "Hello")


component : Element Msg
component =
   testButton 


testButton = Button.template defaultButtonStyle {msg = NoOp, label = "Cancel", tooltipText = "Are you sure?"}


-- DEFINITIONS

defaultButtonStyle : Button.Style msg
defaultButtonStyle = 
   { tooltipPlacement = Element.above
   , attributes = [Color.bgGray 0.2]
   , labelAttributes = [Color.fgGray 1.0, Element.centerX, Element.centerY, Font.size 14]
   }




content : String
content = """
# It all starts with a chapter

Oh, look – A wild real component!

<component />

Woof! Moving on...
"""