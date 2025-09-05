# Elm Patterns

## Builder

```elm
module Button exposing (new, html, onClick, disabled)

new: String -> ButtonConfig
new label =
    { label = label
    , disabled = False
    , ...
    }

onClick : msg => ButtonConfig -> ButtonConfig
disabled : Bool -> ButtonConfig -> ButtonConfig
build: ButtonConfig -> Html msg

-- Usage

Button.new "Increment"
    |> Button.disabled False
    |> Button.onClick IncrementCounter
    |> Button.build
```

## Phantom types

Use Phantom types to:

- Enforcing invariants
- Validation
- State machines
- Processes

```elm
type Users a =
    Users (List User)

type Active
    = Active

activeUsers : List User -> Users Active
activeUsers users =
    users
        |> List.filter isActive
        |> Users
```

## Parse don't validate

To remove unceirtanty from the application:

```elm
-- Data/User.elm
type alias UserInput =
    { name: Maybe String
    , age: Maybe Int
    }

type alias ValidUser =
    { name: String
    , age: Int
    }

validate : UserInput -> Result String ValidUser
```

## Enforcing build order

Sometimes we need to build complex UI components or flows in our application that need enforcing constraints to build them correctly.

This pattern combines [Phantom types](#phantom-types) and [Builder](#builder) patterns:

```elm
-- UI/Button.elm
module UI.Button exposing (..)

type Button label click msg
    = Button (Config msg)


type alias Config msg =
    { label : String
    , onClick: msg
    }


type OnClickNotSet
    = OnClickNotSet


type OnClickSet
    = OnClickSet


new : String -> Button String OnClickNotSet msg
onClick : msg -> Button String OnClickNotSet msg -> Button String OnClickSet msg
build : Button String OnClickSet msg -> Html msg

-- Main.elm
import UI.Button as Button

Button.new "Increment"
    |> Button.onClick CounterUp -- MUST have onClick in order to compile
    |> Button.build
```