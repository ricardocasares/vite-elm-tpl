module Routes exposing (Route(..), fromUrl, toPath)

import Url
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, top)


type Route
    = Home


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    case Parser.parse parser url of
        Just route ->
            route

        Nothing ->
            Home


toPath : Route -> String
toPath route =
    case route of
        Home ->
            "/"
