module Main exposing (Model, Msg(..), main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, input, label, li, text, ul)
import Html.Attributes exposing (attribute, class, for, href, id, type_)
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


type alias MenuItem =
    { label : String
    , route : Route
    , icon : Icon.Icon
    }


type Msg
    = NoOp
    | JSReady
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url



-- Menu Data


navigationItems : List MenuItem
navigationItems =
    [ { label = "Dashboard", route = Home, icon = Icon.house }
    , { label = "Settings", route = Settings, icon = Icon.gear }
    ]


userActionItems : List MenuItem
userActionItems =
    [ { label = "Settings", route = Settings, icon = Icon.gear }
    ]



-- Menu Helpers


viewMenuItem : Route -> MenuItem -> Html Msg
viewMenuItem currentRoute item =
    let
        isActive : Bool
        isActive =
            currentRoute == item.route

        activeClass : String
        activeClass =
            if isActive then
                "menu-active"

            else
                ""
    in
    li [] [ a [ href (Routes.toString item.route), class activeClass ] [ item.icon Regular |> Icon.toHtml [], text item.label ] ]


viewMenuItemTextOnly : Route -> MenuItem -> Html Msg
viewMenuItemTextOnly currentRoute item =
    let
        isActive : Bool
        isActive =
            currentRoute == item.route

        activeClass : String
        activeClass =
            if isActive then
                "menu-active"

            else
                ""
    in
    li [] [ a [ href (Routes.toString item.route), class activeClass ] [ text item.label ] ]


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
    , IO.fromElm IO.ElmReady
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
    div []
        [ viewNavbar model.route
        , div [ class "flex flex-col" ]
            [ div [ class "drawer lg:hidden" ]
                [ input [ id "mobile-drawer", type_ "checkbox", class "drawer-toggle" ] []
                , viewDrawerSide model.route
                ]
            , div [ class "flex-1 container mx-auto p-4" ]
                [ case model.route of
                    Home ->
                        viewHome "Dashboard"

                    Settings ->
                        viewSettings "Settings"
                ]
            ]
        ]


viewNavbar : Route -> Html Msg
viewNavbar currentRoute =
    div [ class "navbar bg-base-100 shadow-sm w-full" ]
        [ div [ class "flex-none lg:hidden" ]
            [ label [ for "mobile-drawer", attribute "aria-label" "open sidebar", class "btn btn-square btn-ghost" ]
                [ Icon.list Regular |> Icon.toHtml []
                ]
            ]
        , div [ class "flex-1 px-2 mx-2 font-bold" ] [ text "Stonks" ]
        , div [ class "flex-none hidden lg:block" ]
            [ ul [ class "menu menu-horizontal" ]
                (List.map (viewMenuItemTextOnly currentRoute) navigationItems)
            ]
        , div [ class "flex-none hidden lg:flex" ]
            [ div [ class "dropdown dropdown-end" ]
                [ div [ attribute "tabindex" "0", attribute "role" "button", class "btn btn-ghost btn-circle avatar" ]
                    [ div [ class "w-8 rounded-full" ]
                        [ Icon.userCircle Regular |> Icon.withClass "w-8 h-8" |> Icon.toHtml []
                        ]
                    ]
                , ul [ attribute "tabindex" "0", class "menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow" ]
                    (List.map (viewMenuItemTextOnly currentRoute) userActionItems)
                ]
            ]
        ]


viewDrawerSide : Route -> Html Msg
viewDrawerSide currentRoute =
    div [ class "drawer-side" ]
        [ label [ for "mobile-drawer", attribute "aria-label" "close sidebar", class "drawer-overlay" ] []
        , ul [ class "menu bg-base-200 text-base-content min-h-full w-80 p-4" ]
            (List.concat
                [ [ -- User Info Section
                    li [ class "mb-4" ]
                        [ div [ class "flex items-center gap-3 px-3 py-2" ]
                            [ div [ class "avatar" ]
                                [ div [ class "w-10 rounded-full" ]
                                    [ Icon.userCircle Regular |> Icon.withClass "w-10 h-10" |> Icon.toHtml []
                                    ]
                                ]
                            , div []
                                [ div [ class "font-semibold" ] [ text "John Doe" ]
                                , div [ class "text-sm opacity-70" ] [ text "john@example.com" ]
                                ]
                            ]
                        ]
                  , li [ class "menu-title" ] [ text "Navigation" ]
                  ]
                , List.map (viewMenuItem currentRoute) navigationItems
                , [ li [ class "menu-title" ] [ text "Account" ] ]
                , List.map (viewMenuItem currentRoute) userActionItems
                ]
            )
        ]


viewHome : String -> Html Msg
viewHome title =
    div [ class "flex flex-col gap-6" ]
        [ div [ class "card bg-base-100 shadow-xl" ]
            [ div [ class "card-body" ]
                [ div [ class "card-title" ] [ Icon.trendUp Regular |> Icon.toHtml [], text title ]
                , div [] [ text "Welcome to your investment dashboard" ]
                , div [ class "stats bg-base-200 shadow" ]
                    [ div [ class "stat" ]
                        [ div [ class "stat-title" ] [ text "Total Portfolio" ]
                        , div [ class "stat-value" ] [ text "$89,400" ]
                        , div [ class "stat-desc" ] [ text "↗︎ 400 (22%)" ]
                        ]
                    , div [ class "stat" ]
                        [ div [ class "stat-title" ] [ text "Today's Gain" ]
                        , div [ class "stat-value text-primary" ] [ text "$1,200" ]
                        , div [ class "stat-desc text-primary" ] [ text "↗︎ 40 (2%)" ]
                        ]
                    ]
                , div [ class "card-actions justify-end" ]
                    [ button [ class "btn btn-primary" ] [ text "View Details" ]
                    ]
                ]
            ]
        ]


viewSettings : String -> Html Msg
viewSettings title =
    div [ class "flex flex-col gap-6" ]
        [ div [ class "card bg-base-100 shadow-xl" ]
            [ div [ class "card-body" ]
                [ div [ class "card-title" ] [ Icon.gear Regular |> Icon.toHtml [], text title ]
                , div [] [ text "Manage your application settings" ]
                , div [ class "grid grid-cols-1 md:grid-cols-2 gap-4 mt-4" ]
                    [ div [ class "card bg-base-200" ]
                        [ div [ class "card-body" ]
                            [ div [ class "card-title text-sm" ] [ text "Notifications" ]
                            , div [ class "form-control" ]
                                [ label [ class "label cursor-pointer" ]
                                    [ text "Email notifications"
                                    , input [ type_ "checkbox", class "toggle toggle-primary" ] []
                                    ]
                                ]
                            ]
                        ]
                    , div [ class "card bg-base-200" ]
                        [ div [ class "card-body" ]
                            [ div [ class "card-title text-sm" ] [ text "Theme" ]
                            , div [ class "form-control" ]
                                [ label [ class "label cursor-pointer" ]
                                    [ text "Dark mode"
                                    , input [ type_ "checkbox", class "toggle toggle-primary" ] []
                                    ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "card-actions justify-end" ]
                    [ button [ class "btn btn-ghost" ] [ text "Reset" ]
                    , button [ class "btn btn-primary" ] [ text "Save Changes" ]
                    ]
                ]
            ]
        ]
