module Book exposing (main)


import ElmBook exposing (withChapters)
import FirstChapter exposing (firstChapter)
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


firstChapter : Chapter x
firstChapter =
    chapter "First Chapter"
        |> renderComponent
            (el [] <| text "Hello")


main : Book ()
main =
    book "ElmBook with Elm-UI"
        |> withChapters
            [ firstChapter
            ]

