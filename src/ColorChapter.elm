module ColorChapter exposing (Model, init, colorChapter)


import ElmBook.Chapter exposing (chapter, renderStatefulComponent, withStatefulComponentList, renderStatefulComponentList, render)
import ElmBook.Actions exposing (mapUpdate)
import Html exposing (..)
import Element exposing(Element)
import UILibrary.Button
import UILibrary.Color
import Element.Font as Font
import ElmBook.ElmUI exposing (Book, book, Chapter)
import Element.Background as Background



type Msg = NoOp

type alias Model = Int


init : Model
init = 0



colorChapter : Chapter { x | colorChapterModel : Model }
colorChapter =
    chapter "Colors"
      |> withStatefulComponentList [ 
           ("Grays", \{ colorChapterModel } -> viewGrays colorChapterModel  |> Element.map mapUpdater  )
         , ("Reds", \{ colorChapterModel } -> viewReds colorChapterModel  |> Element.map mapUpdater  )
         , ("Greens", \{ colorChapterModel } -> viewGreens colorChapterModel  |> Element.map mapUpdater  )
         , ("Blues", \{ colorChapterModel } -> viewBlues colorChapterModel  |> Element.map mapUpdater  )
         ]
      |> render content
      

mapUpdater = mapUpdate
        { toState = \state model_ -> { state | colorChapterModel = model_ }
        , fromState = \state -> state.colorChapterModel
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp -> model

viewGrays : Model -> Element Msg
viewGrays _ = UILibrary.Color.grayExample


viewReds : Model -> Element Msg
viewReds _ = UILibrary.Color.redExample

viewGreens : Model -> Element Msg
viewGreens _ = UILibrary.Color.greenExample

viewBlues : Model -> Element Msg
viewBlues _ = UILibrary.Color.blueExample



content = """
The aim of the `UILibrary.Color` module is to provide a limited palette of colors.
Below is a list of grays, which are accessed as `UILibray.Color.black`, `UILibray.Color.palegray`, etc.

## Black, Grays, and White

<component with-label="Grays" />

## Pure colors

<component with-label="Reds" />

<component with-label="Greens" />

<component with-label="Blues" />

## Mixed colors


"""


                                                                                                                                                                                                                                                                                                                                  
