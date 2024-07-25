module Main exposing (Msg(..), main, view)

import Browser
import Html exposing (Html, button, div, input, label, text)
import Html.Attributes as Attr exposing (class)
import Html.Events exposing (onClick)
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr


type alias Model =
    Int


type Msg
    = Reset
    | Increment
    | Decrement


main : Program () Int Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


init : Model
init =
    0


update : Msg -> number -> number
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0


view : Int -> Html Msg
view model =
    div [ class "flex gap-2 items-center flex-col h-full justify-center" ]
        [ div [ class "flex gap-2 p-2 items-center" ]
            [ button [ class "btn  btn-primary", onClick Decrement ] [ text "-" ]
            , button [ class "btn grow", onClick Reset ] [ text (String.fromInt model) ]
            , button [ class "btn  btn-secondary", onClick Increment ] [ text "+" ]
            ]
        , theme
        ]


theme : Html msg
theme =
    label
        [ class "swap swap-rotate" ]
        [ input
            [ Attr.type_ "checkbox"
            , Attr.class "theme-controller"
            , Attr.value "dracula"
            ]
            []
        , sun
        , moon
        ]


sun : Html msg
sun =
    svg
        [ SvgAttr.width "32"
        , SvgAttr.height "32"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.class "swap-off h-6 w-6 fill-current"
        ]
        [ Svg.g
            [ SvgAttr.fill "none"
            , SvgAttr.stroke "currentColor"
            , SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.strokeWidth "2"
            ]
            [ Svg.circle
                [ SvgAttr.cx "12"
                , SvgAttr.cy "12"
                , SvgAttr.r "4"
                ]
                []
            , path
                [ SvgAttr.d "M12 2v2m0 16v2M4.93 4.93l1.41 1.41m11.32 11.32l1.41 1.41M2 12h2m16 0h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41" ]
                []
            ]
        ]


moon : Html msg
moon =
    svg
        [ SvgAttr.width "32"
        , SvgAttr.height "32"
        , SvgAttr.viewBox "0 0 24 24"
        , SvgAttr.class "swap-on h-6 w-6 fill-current"
        ]
        [ path
            [ SvgAttr.fill "none"
            , SvgAttr.stroke "currentColor"
            , SvgAttr.strokeLinecap "round"
            , SvgAttr.strokeLinejoin "round"
            , SvgAttr.strokeWidth "2"
            , SvgAttr.d "M12 3a6 6 0 0 0 9 9a9 9 0 1 1-9-9"
            ]
            []
        ]
