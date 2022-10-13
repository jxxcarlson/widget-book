module Book exposing (main)


import ElmBook exposing (withChapters)
import ElmBook.StatefulOptions
import ButtonChapter exposing (chapter_)
import Element exposing (Element, el, text)
-- import Element.Background as Background
-- import Element.Events as Events
-- import Element.Font as Font
-- import Element.Input as Input
-- import UILibrary.Color as Color
-- import UILibrary.Button as Button
-- import UILibrary.Color as Color
import ElmBook.ElmUI exposing (Book, book, Chapter)

type alias SharedState =
    { chapter1Model : ButtonChapter.Model
    }


initialState : SharedState
initialState =
    { chapter1Model = ButtonChapter.init
    }


main : Book SharedState
main =
    book "ElmBook with Elm-UI"
        |> ElmBook.withStatefulOptions
            [ ElmBook.StatefulOptions.initialState initialState ]
        |> withChapters
            [ ButtonChapter.chapter_
            ]

