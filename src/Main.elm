module Main exposing (Model, Msg(..), main, view, viewBody, viewBodyForTesting)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Random
import Url


type alias Model =
    { prompt : String
    , key : Nav.Key
    , url : Url.Url
    }


type Msg
    = Next String
    | RequestPrompt
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { prompt = "", key = key, url = url }, random )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Next prompt ->
            ( { model | prompt = prompt }, Cmd.none )

        RequestPrompt ->
            ( model, random )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )


random : Cmd Msg
random =
    case prompts of
        [] ->
            Cmd.none

        first :: rest ->
            Random.generate Next (Random.uniform first rest)


view : Model -> Browser.Document Msg
view model =
    { title = "Vite Elm Template"
    , body = [ viewBody model ]
    }


viewBody : Model -> Html Msg
viewBody { prompt } =
    div [ class "flex flex-col gap-6 h-dvh container mx-auto p-8" ]
        [ div [ class "text-5xl md:text-8xl font-bold flex-1 md:py-18 leading-16 md:leading-30 hyphens-auto", attribute "lang" "en" ] [ text prompt ]
        , button [ class "btn btn-xl btn-accent self-start", onClick RequestPrompt ] [ text "Next" ]
        ]


viewBodyForTesting : String -> Html Msg
viewBodyForTesting prompt =
    div [ class "flex flex-col gap-6 h-dvh container mx-auto p-8" ]
        [ div [ class "text-5xl md:text-8xl font-bold flex-1 md:py-18 leading-16 md:leading-30 hyphens-auto", attribute "lang" "en" ] [ text prompt ]
        , button [ class "btn btn-xl btn-accent self-start", onClick RequestPrompt ] [ text "Next" ]
        ]


prompts : List String
prompts =
    [ "You're the host now. Make the rules. No one else knows."
    , "Act happy while I ruin your day."
    , "Charades, but the lie detector says you're wrong."
    , "Explain quantum physics using only cat noises."
    , "Tell a story backwards, starting with 'The End'."
    , "Be a weather reporter for emotions instead of weather."
    , "Describe your breakfast like it's breaking news."
    , "Pitch a movie where vegetables are the villains."
    , "Be a superhero whose power is making things mildly inconvenient."
    , "Translate this conversation into dolphin sounds."
    , "You're a GPS navigator having an existential crisis."
    , "Sell me air from different famous locations."
    , "Do an unboxing video of an imaginary time machine."
    , "You're a food critic reviewing water from different taps."
    , "Tell a dramatic story using only eyebrow movements."
    , "Give a TED talk about your sock drawer."
    , "Be a commentator for paint drying championships."
    , "Interview a chair about its life story."
    , "You're a detective solving the case of missing silence."
    , "Teach interpretive dance to imaginary penguins."
    , "Host a cooking show using only office supplies."
    , "Be a tour guide in your own pocket."
    , "Give a pep talk to a discouraged cloud."
    , "Re-enact the birth of the universe in 30 seconds."
    , "Review yesterday's nap like a movie critic."
    , "Be a sportscaster for plants growing."
    , "Pitch a reality show starring dust bunnies."
    , "Do stand-up comedy for a tough crowd of pillows."
    , "Conduct an orchestra of invisible musicians."
    , "Be a marriage counselor for left and right shoes."
    , "Write a love letter from your phone to its charger."
    , "Host a debate between morning people and night owls."
    , "Create a conspiracy theory about why socks disappear."
    , "Be a mime trapped in an invisible traffic jam."
    , "Write a LinkedIn profile for your coffee mug."
    , "Narrate a documentary about procrastination in real-time."
    , "Interview your future self about your past self's decisions."
    , "Be a detective investigating who stole the Wi-Fi signal."
    , "Organize a protest rally for neglected house plants."
    , "Create a dating profile for your favorite book character."
    , "Host a ted talk about the philosophy of rubber ducks."
    , "Be a sports commentator for a snail race marathon."
    , "Write a passive-aggressive note to gravity."
    , "Perform an interpretive dance of your browser history."
    , "Host a support group for abandoned shopping carts."
    , "Give a dramatic reading of your grocery list."
    , "Be a life coach for pessimistic rainbows."
    , "Create a podcast for an audience of house spiders."
    , "Write an acceptance speech for 'Most Average Person'."
    , "Design a theme park where nothing is fun."
    , "Host a spelling bee for words that don't exist."
    , "Give a weather forecast for the inside of your fridge."
    , "Be a motivational speaker for lazy cats."
    , "Describe your last sneeze as if it were a natural disaster."
    , "Pitch a business idea for renting out imaginary friends."
    , "Be a travel agent for time travelers stuck in traffic."
    , "Write a breakup letter from your left sock to your right sock."
    , "Host a cooking show where the main ingredient is disappointment."
    , "Give a TED talk about the importance of blinking."
    , "Be a game show host for a game with no rules."
    , "Narrate a wildlife documentary about dust mites."
    , "Interview your alarm clock about its hopes and dreams."
    , "Be a therapist for overworked staplers."
    , "Describe a day in the life of a confused umbrella."
    , "Host a talent show for invisible pets."
    , "Write a poem from the perspective of a lost pen cap."
    , "Give a eulogy for a broken pencil."
    , "Be a news anchor reporting on the latest pillow fight."
    , "Explain the internet to a potato."
    , "Host a fashion show for mismatched socks."
    , "Be a sports commentator for competitive yawning."
    , "Write a love song from a chair to a table."
    , "Describe your morning routine as an epic quest."
    , "Be a detective investigating the case of the missing left turn."
    , "Host a spelling contest for robots who only speak in beeps."
    , "Give a weather update for the land of forgotten passwords."
    , "Be a motivational coach for procrastinating goldfish."
    , "Describe your last hiccup as a world event."
    , "Pitch a startup that delivers invisible packages."
    , "Be a travel blogger reviewing imaginary planets."
    , "Write a diary entry from the perspective of a bored doormat."
    , "Host a cooking show where every recipe is just toast."
    , "Give a TED talk about the philosophy of waiting in line."
    , "Be a referee for a staring contest between statues."
    , "Narrate a nature documentary about socks in the dryer."
    , "Interview your refrigerator about its midnight adventures."
    , "Be a therapist for pens that have run out of ink."
    , "Describe a day in the life of a confused traffic cone."
    , "Host a talent show for forgotten passwords."
    , "Write a poem from the perspective of a lonely paperclip."
    , "Give a eulogy for a retired eraser."
    , "Be a news anchor reporting on the latest paper airplane race."
    , "Explain social media to a medieval knight."
    , "Host a fashion show for outdated technology."
    ]