module InputChapter exposing (Model, inputChapter, init)


import Element exposing (Element)
import ElmBook.Actions exposing (mapUpdate)
import ElmBook.Chapter exposing (chapter, render, withStatefulComponentList)
import ElmBook.ElmUI exposing (Book, Chapter)
import UILibrary.Color
import UILibrary.Input 


type Msg
    = NoOp
    | InputName String
 


type alias Model =
    {username : String}


init : Model
init =
    {username = ""}


inputChapter : Chapter { x | inputChapterModel : Model }
inputChapter =
    chapter "Input Fields"
        |> withStatefulComponentList
            [ ( "Large Primary", \{ inputChapterModel } -> viewLargeInputs inputChapterModel |> Element.map mapUpdater )
            , ( "Small Primary", \{ inputChapterModel } -> viewSmallInputs inputChapterModel |> Element.map mapUpdater )
            
            ]
        |> render content


mapUpdater =
    mapUpdate
        { toState = \state chapterModel_ -> { state | inputChapterModel = chapterModel_ }
        , fromState = \state -> state.inputChapterModel
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model
        InputName str -> {model | username = str}


viewLargeInputs : Model -> Element Msg
viewLargeInputs model =
    Element.row [ Element.spacing 24 ]
        [ UILibrary.Input.largePrimary { msg = InputName, label = "Username", placement = UILibrary.Input.LabelLeft UILibrary.Color.darkGray, placeholder = Nothing } model.username
        ]


viewSmallInputs : Model -> Element Msg
viewSmallInputs model =
    Element.row [ Element.spacing 24 ]
        [ UILibrary.Input.smallPrimary { msg = InputName, label = "Username", placement = UILibrary.Input.LabelLeft UILibrary.Color.darkGray, placeholder = Nothing } model.username
        ]

content =
    """

The `UILibrary.Button` module provides library of stylistically coherent inputFields,
`largePrimary` and `smallPrimary`:


### Gallery

<component with-label="Large Primary" />

<component with-label="Small Primary" />

### API

"""
