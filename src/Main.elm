module Main exposing (Msg(..), main, view)

import Browser
import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import VitePluginHelper as Vite


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
        [ img [ src <| Vite.asset "/src/assets/logo.png", class "h-32 w-32 rounded-lg" ] []
        , div [ class "flex gap-2 p-2 items-center" ]
            [ button [ class "btn btn-sm btn-error", onClick Decrement ] [ text "-" ]
            , button [ class "btn btn-sm grow", onClick Reset ] [ text (String.fromInt model) ]
            , button [ class "btn btn-sm btn-success btn-active", onClick Increment ] [ text "+" ]
            ]
        ]
