module Book exposing (main)


import ElmBook exposing (withChapters)
import ElmBook.StatefulOptions
import ButtonChapter exposing (buttonChapter)
import ColorChapter exposing(colorChapter)
import Element exposing (Element, el, text)
-- import Element.Background as Background
-- import Element.Events as Events
-- import Element.Font as Font
-- import Element.Input as Input
-- import UILibrary.Color as Color
-- import UILibrary.Button as Button
-- import UILibrary.Color as Color
import ElmBook.ElmUI exposing (Book, book, Chapter)
import Html exposing (input)
import InputChapter

type alias SharedState =
    { buttonChapterModel : ButtonChapter.Model
    , colorChapterModel : ColorChapter.Model
    , inputChapterModel : InputChapter.Model
    }


initialState : SharedState
initialState =
    { buttonChapterModel = ButtonChapter.init
    , colorChapterModel = ColorChapter.init
    , inputChapterModel = InputChapter.init
    }


main : Book SharedState
main =
    book "ElmBook with Elm-UI"
        |> ElmBook.withStatefulOptions
            [ ElmBook.StatefulOptions.initialState initialState ]
        |> withChapters
            [ ButtonChapter.buttonChapter
            , InputChapter.inputChapter
            , ColorChapter.colorChapter
            ]

