module Routes exposing (Route(..), fromUrl, toString)

import Url
import Url.Parser as Parser exposing (Parser, map, oneOf, s, top)


type Route
    = Home
    | Settings


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map Settings (s "settings")
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    case Parser.parse parser url of
        Just route ->
            route

        Nothing ->
            Home


toString : Route -> String
toString route =
    case route of
        Home ->
            "/"

        Settings ->
            "/settings"
