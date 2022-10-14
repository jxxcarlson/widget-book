module UILibrary.Button exposing
    ( Label(..)
    , Params
    , Status(..)
    , largePrimary
    , smallPrimary
    )

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes as HA
import UILibrary.Color


largePrimary : Params msg -> Element msg
largePrimary params =
    template (largePrimaryStyle params.status) params


smallPrimary : Params msg -> Element msg
smallPrimary params =
    template (smallPrimaryStyle params.status) params


type alias Params msg =
    { msg : msg, label : Label, status : Status, tooltipText : Maybe String }


type Status
    = Active
    | Inactive
    | Highlighted


type Label
    = Text String
    | Icon String


type alias Style msg =
    { tooltipPlacement : Element msg -> Element.Attribute msg
    , attributes : List (Element.Attribute msg)
    , labelAttributes : List (Element.Attribute msg)
    , iconSize : Int
    }


template : Style msg -> Params msg -> Element msg
template style params =
    Element.row [ Element.pointer ]
        [ Input.button (realAttributes params.label style.attributes)
            { onPress = Just params.msg
            , label =
                case ( params.label, params.tooltipText ) of
                    ( Text labelText, Nothing ) ->
                        Element.el style.labelAttributes (Element.text labelText)

                    ( Text labelText, Just ttText ) ->
                        addTooltip style.tooltipPlacement
                            ttText
                            (Element.el style.labelAttributes (Element.text labelText))

                    ( Icon iconName, Nothing ) ->
                        Element.image [ Element.width (Element.px style.iconSize), Element.height (Element.px style.iconSize) ] { src = iconName, description = iconName }

                    ( Icon iconName, Just ttText ) ->
                        addTooltip style.tooltipPlacement
                            ttText
                            (Element.image [ Element.width (Element.px style.iconSize), Element.height (Element.px style.iconSize) ] { src = iconName, description = iconName })
            }
        ]


realAttributes label attributes =
    case label of
        Text _ ->
            attributes

        Icon _ ->
            []


type alias ParamsWithIcon msg =
    { msg : msg, tooltipText : Maybe String, icon : String, iconSize : Int, iconText : String }


largePrimaryStyle : Status -> Style msg
largePrimaryStyle status =
    { tooltipPlacement = Element.above
    , attributes =
        [ Background.color (bgColor status)
        , Element.paddingXY 12 6
        , Element.mouseDown
            [ Background.color (fgColor status)
            ]
        ]
    , iconSize = 27
    , labelAttributes = [ Font.color (fgColor status), Element.centerX, Element.centerY, Font.size 14 ]
    }


smallPrimaryStyle : Status -> Style msg
smallPrimaryStyle status =
    { tooltipPlacement = Element.above
    , attributes =
        [ Background.color (bgColor status)
        , Element.paddingXY 8 4
        , Element.mouseDown [ Background.color (fgColor status) ]
        ]
    , iconSize = 19
    , labelAttributes = [ Font.color UILibrary.Color.white, Element.centerX, Element.centerY, Font.size 12 ]
    }


bgColor : Status -> Element.Color
bgColor status =
    case status of
        Active ->
            UILibrary.Color.darkGray

        Inactive ->
            UILibrary.Color.lightGray

        Highlighted ->
            UILibrary.Color.darkRed


fgColor : Status -> Element.Color
fgColor status =
    case status of
        Active ->
            UILibrary.Color.white

        Inactive ->
            UILibrary.Color.black

        Highlighted ->
            UILibrary.Color.white



-- label = Element.image [ Element.width (Element.px 27), Element.height (Element.px 27), Element.moveLeft 12 ] { src = "/bug.png", description = "Bug report" }


templateWithIcon : Style msg -> ParamsWithIcon msg -> Element msg
templateWithIcon style params =
    Element.row [ Element.pointer ]
        [ Input.button []
            { onPress = Just params.msg
            , label =
                case params.tooltipText of
                    Nothing ->
                        Element.image [ Element.width (Element.px 27), Element.height (Element.px 27) ] { src = params.icon, description = params.iconText }

                    Just ttText ->
                        addTooltip style.tooltipPlacement
                            ttText
                            (Element.image [ Element.width (Element.px params.iconSize), Element.height (Element.px params.iconSize) ] { src = params.icon, description = params.iconText })
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
