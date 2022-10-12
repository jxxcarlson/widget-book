module UILibrary.Button exposing(
       template
      , Data
      , Style
    )

import Element as E exposing (Element)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import UILibrary.Color as Color
import Element.Border as Border
import Html.Attributes as HA


type alias Style msg =
    { tooltipPlacement : Element msg -> E.Attribute msg
    , attributes : List (E.Attribute msg)
    , labelAttributes : List (E.Attribute msg)
    }


type alias Data msg = { msg : msg, label : String, tooltipText : String}


template : Style msg -> Data msg -> Element msg
template style data =
    E.row [ E.pointer, E.mouseDown [ Background.color Color.darkRed ] ]
        [ Input.button style.attributes
            { onPress = Just data.msg
            , label = addTooltip style.tooltipPlacement data.tooltipText 
                (E.el style.labelAttributes (E.text data.label))
            }
        ]


-- TOOLTIP

myTooltip : String -> Element msg
myTooltip str =
    E.el
        [ Background.color (E.rgb 0 0 0)
        , Font.color (E.rgb 1 1 1)
        , E.padding 4
        , Border.rounded 5
        , Font.size 14
        , Border.shadow
            { offset = ( 0, 3 ), blur = 6, size = 0, color = E.rgba 0 0 0 0.32 }
        ]
        (E.text str)



--


tooltip : (Element msg -> E.Attribute msg) -> Element Never -> E.Attribute msg
tooltip usher tooltip_ =
    E.inFront <|
        E.el
            [ E.width E.fill
            , E.height E.fill
            , E.transparent True
            , E.mouseOver [ E.transparent False ]
            , (usher << E.map never) <|
                E.el
                    [ E.htmlAttribute (HA.style "pointerEvents" "none") ]
                    tooltip_
            ]
            E.none



-- addTooltip : (Element msg -> E.Attribute msg) -> String -> E.Element -> E.Element


addTooltip placement label element =
    E.el
        [ tooltip placement (myTooltip label) ]
        element