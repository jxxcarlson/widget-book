module ButtonChapter exposing (Model, init, buttonChapter)


import ElmBook.Chapter exposing (chapter, renderStatefulComponent, renderStatefulComponentList, render)
import ElmBook.Actions exposing (mapUpdate)
import Html exposing (..)
import Element exposing(Element)
import UILibrary.Button as Button
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
      |> renderStatefulComponentList [ 
           ("Cancel button", \{ buttonChapterModel } -> view buttonChapterModel  |> Element.map mapUpdater  )
           -- WANT TO RENDER content (markdown) HERE
           -- Need something like 'ElmBook.UI.Markdown.view content |> Element.html'
         ]
      

mapUpdater = mapUpdate
        { toState = \state chapter1Model_ -> { state | buttonChapterModel = chapter1Model_ }
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
```elm
cancelButton = Button.template 
                 Button.defaultStyle 
                 {msg = NoOp, label = "Cancel", tooltipText = Nothing}
```
"""


cancelButton = Button.template Button.defaultStyle {msg = NoOp, label = "Cancel", tooltipText = Nothing}

                                                                                                                                                                                                                                                                                                                                  

-- viewMarkdown : String -> Element msg
-- viewMarkdown content =
--     ElmBook.UI.Markdown.view content |> Element.html
--         -- |> withOther "stuff"
--         -- |> withAnd [ "x" [] ]


-- chapter : String -> ChapterBuilder state html

-- renderStatefulComponent :
--     (state -> html)
--     -> ChapterBuilder state html
--     -> ChapterCustom state html

-- mapUpdate :
--     { fromState : state -> model
--     , toState : state -> model -> state
--     , update : msg -> model -> model
--     }
--     -> msg
--     -> Msg state

-- render : String -> ChapterBuilder state html -> ChapterCustom state html
