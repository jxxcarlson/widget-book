module Book exposing (main)


import ElmBook exposing (withChapters)
import ElmBook.StatefulOptions
import FirstChapter exposing (chapter_)
import Element exposing (Element, el, text)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import UILibrary.Color as Color
import UILibrary.Button as Button
import UILibrary.Color as Color


-- import ElmBook exposing (withChapters)
import ElmBook.ElmUI exposing (Book, book, Chapter)
import ElmBook.Chapter exposing (chapter, renderComponent)

type alias SharedState =
    { chapter1Model : FirstChapter.Model
    }

-- firstChapter : Chapter x
-- firstChapter =
--     chapter "First Chapter"
--         |> renderComponent
--             (el [] <| text "Hello")

initialState : SharedState
initialState =
    { chapter1Model = FirstChapter.init
    }


main : Book SharedState
main =
    book "ElmBook with Elm-UI"
        |> ElmBook.withStatefulOptions
            [ ElmBook.StatefulOptions.initialState initialState
            ]
        |> withChapters
            [ FirstChapter.chapter_
            ]

