module Main exposing (Model, Msg(..), main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, li, span, text, ul)
import Html.Attributes exposing (attribute, class, href)
import InteropDefinitions as IO
import InteropPorts as IO
import Phosphor as Icon exposing (IconWeight(..))
import Routes exposing (Route(..))
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    }


type Msg
    = NoOp
    | JSReady
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


main : Program IO.Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


init : IO.Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , url = url
      , route = Routes.fromUrl url
      }
    , Cmd.batch [ IO.fromElm IO.ElmReady ]
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    IO.toElm
        |> Sub.map
            (\result ->
                case result of
                    Ok data ->
                        case data of
                            IO.JSReady ->
                                JSReady

                    Err _ ->
                        NoOp
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        JSReady ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, route = Routes.fromUrl url }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Vite Elm Template"
    , body = [ viewBody model ]
    }


viewBody : Model -> Html Msg
viewBody model =
    case model.route of
        Home ->
            viewHome "Home"


viewHome : String -> Html Msg
viewHome title =
    div [ class "flex flex-col gap-6 h-dvh container mx-auto p-8" ]
        [ div [ class "flex" ]
            [ ul [ class "menu w-64 rounded-box" ]
                [ li [] [ a [ href "#" ] [ Icon.house Regular |> Icon.toHtml [], text "Home" ] ]
                , li [] [ a [ href "#", class "menu-active" ] [ Icon.faders Regular |> Icon.toHtml [], text "Settings", span [ class "badge badge-soft badge-info badge-sm" ] [ text "0" ] ] ]
                ]
            , div [ class "flex-1 card card-border bg-base-100 shadow-sm", attribute "lang" "en" ]
                [ div [ class "card-body" ]
                    [ div [ class "card-title" ] [ text title ]
                    , div [] [ text "Hello" ]
                    , div [ class "card-actions justify-end" ]
                        [ button [ class "btn btn-primary" ] [ text "Buy" ]
                        ]
                    ]
                ]
            ]
        ]
