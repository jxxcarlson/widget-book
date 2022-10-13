module ButtonChapter exposing (Model, init, chapter_)


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


chapter_ : Chapter { x | chapter1Model : Model }
chapter_ =
    chapter "Buttons"
      --  |> renderStatefulComponent ( \{ chapter1Model } -> view chapter1Model  |> foo  )
      |> renderStatefulComponentList [ 
           ("foo", \{ chapter1Model } -> view chapter1Model  |> foo  )
           --, ("bar", chapter "hoho" |> render content   )
         ]
        -- |> render content

foo = Element.map bar

bar = mapUpdate
        { toState = \state chapter1Model_ -> { state | chapter1Model = chapter1Model_ }
        , fromState = \state -> state.chapter1Model
        , update = update
        }


yada  = \state chapter1Model_ -> { state | chapter1Model = chapter1Model_ }

update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> model


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

view : Model -> Element Msg
view model =
   Element.column [Element.spacing 12] 
     [ Element.text "This is a test."
      , cancelButton
      --, render content 
     ] 

content = """
```elm
cancelButton = Button.template 
                 Button.defaultStyle 
                 {msg = NoOp, label = "Cancel", tooltipText = Nothing}
```
"""

-- viewMarkdown : String -> Element msg
-- viewMarkdown content =
--     ElmBook.UI.Markdown.view content |> Element.html
--         -- |> withOther "stuff"
--         -- |> withAnd [ "x" [] ]

cancelButton = Button.template Button.defaultStyle {msg = NoOp, label = "Cancel", tooltipText = Nothing}

                                                                                                                                                                                                                                                                                                                                  
