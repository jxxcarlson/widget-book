module UILibrary.Button exposing(
       template
      , defaultStyle
      , Data
      , Style
    )

import Element exposing (Element)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import UILibrary.Color 
import Element.Border as Border
import Html.Attributes as HA


type alias Style msg =
    { tooltipPlacement : Element msg -> Element.Attribute msg
    , attributes : List (Element.Attribute msg)
    , labelAttributes : List (Element.Attribute msg)
    }


type alias Data msg = { msg : msg, label : String, tooltipText :Maybe  String}

defaultStyle : Style msg
defaultStyle = 
   { tooltipPlacement = Element.above
   , attributes = [
        Background.color UILibrary.Color.darkGray
      , Element.paddingXY 12 6
      , Element.mouseDown [ Background.color UILibrary.Color.darkRed] ]
   , labelAttributes = [Font.color UILibrary.Color.white, Element.centerX, Element.centerY, Font.size 14]

   }



noFocusOption = Element.focusStyle noFocus

noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }


template : Style msg -> Data msg -> Element msg
template style data =
    Element.row [ Element.pointer ]
        [ Input.button style.attributes
            { onPress = Just data.msg
            , label = case data.tooltipText of 
                 Nothing -> (Element.el style.labelAttributes (Element.text data.label))
                 Just ttText -> 
                   addTooltip style.tooltipPlacement ttText
                    (Element.el style.labelAttributes (Element.text data.label))
            }
        ]



-- TOOLTIP

myTooltip : String -> Element msg
myTooltip str =
    Element.el
        [ Background.color (Element.rgb 0 0 0)
        , Font.color (Element.rgb 1 1 1)
        , Element.padding 4
        , Border.rounded 5
        , Font.size 14
        , Border.shadow
            { offset = ( 0, 3 ), blur = 6, size = 0, color = Element.rgba 0 0 0 0.32 }
        ]
        (Element.text str)



--


tooltip : (Element msg -> Element.Attribute msg) -> Element Never -> Element.Attribute msg
tooltip usher tooltip_ =
    Element.inFront <|
        Element.el
            [ Element.width Element.fill
            , Element.height Element.fill
            , Element.transparent True
            , Element.mouseOver [ Element.transparent False ]
            , (usher << Element.map never) <|
                Element.el
                    [ Element.htmlAttribute (HA.style "pointerEvents" "none") ]
                    tooltip_
            ]
            Element.none



-- addTooltip : (Element msg -> Element.Attribute msg) -> String -> Element.Element -> Element.Element


addTooltip placement label element =
    Element.el
        [ tooltip placement (myTooltip label) ]
        element