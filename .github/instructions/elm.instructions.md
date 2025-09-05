---
applyTo: "**/*.elm"
---

# Elm Guidelines

- **CRITICAL:** Never use `Debug.todo`
- **CRITICAL:** Never edit `elm.json` manually
- **CRITICAL:** Let the compiler guide the refactoring
- **CRITICAL:** Avoid ambiguous or illegal states
- **CRITICAL:** Unwrap `Maybe`, `Result` or `RemoteData` early
- **CRITICAL:** Unwrap Custom Types only at the view level

## Commands

- **CRITICAL**: `elm make src/<ModuleName>.elm --output=/dev/null` to check a module compiles
- **CRITICAL**: `bun compile` to check the whole app compiles
- `bun run test` to run all tests
- `bun run test --filter "description"` to run test matching the filter
- `bun lint` to check for linter errors
- `bun lint --fix-all-without-prompt` to fix linting errors automatically
- `bun interop` to generate typesscript types after modyfing InteropDefinitions.elm
- `elm-json install <package-name> --yes` to install packages
- `elm-json uninstall <package-name> --yes` to uninstall packages

## Specialized Modules

Create specialized modules for custom data types with their functions.
The exception to this rule are `Msg` and `Model` types, that **should always** be in `Main.elm`.

```elm
-- Data/Person.elm
module Data.Person exposing (Person, new)

type Person
    = AdultPerson Int
    | MinorPerson Int

type PersonError
    = InvalidPersonAge String

new : Int -> Result PersonError Person
new age =
    if age < 0 then
        Err (InvalidPersonAge "Age must be positive")

    else if age < 18 then
        Ok (MinorPerson age)

    else
        Ok (AdultPerson age)

```

## Ambiguous or illegal states

Use custom types to precisely model application state, removing ambiguity.

```elm
-- Data can be either loading or loaded **but never both at the same time!**
type RemoteData err data
    = Loading
    | Failed err
    | Loaded data
```

## Elm & TypeScript Interop

**CRITICAL:**

- Read `@src/InteropDefinitions.elm` first, when trying to interop with TypeScript
- Use `ToElm` for incoming messages in ports
- Use `FromElm` for outgoing messages in ports
- Add variants to `ToElm` and `FromElm` types in order to add new features
- Run `bun interop` after changing `InteropDefinitions.elm` to generate type definitions

## Routing

- Use `@src/Routes.elm` to add new routes
- Handle new route variants for the `Route` type in `@src/Main.elm`

## Avoid Type Blindness

Examples:

- Use `type Age = Age Int` instead of `Int`
- Use `type Currency = USD Float` instead of `Float`
- Use `type UserId = UserId String` instead of `String`

## Unwrap `Maybe`, `Result` or `RemoteData`

Unwrap early to remove unceirtainty downstream in the application.

```elm
userView : Maybe User -> Html Msg
userView maybeUser =
    case maybeUser of
        Just user ->
            userInfoView user

        Nothing ->
            userNotFoundView
```

## Unwrap Custom Types Late

Unwrap late at view level to enforce them across the application:

```elm
type Dollar
    = Dollar Float

buy : Dollar -> Html Msg
buy (Dollar amount) =
    button [ BuyDollars (Dollar amount) |> onClick ] [ String.fromFloat amount |> text ]
```

## Avoid `Bool` usage

Boolean ambiguity can lead to loss of intent and loss of information in our code.

## Named arguments

Use a record for function arguments to avoid disambiguate:

```elm
bookRoom { from: Date, until: Date } -> Room
```

## Use The Compiler To Your Advantage

**CRITICAL:** Always handle all the branches!

```elm
-- Handles all possible colors
canCrossStreet : SemaphoreColors -> Boolean
canCrossStreet color =
    case color of
        Red -> False
        Yellow -> False
        Green -> True
```

Elm is known for its sound and friendly compiler, use it as your superpower:

```elm
type SemaphoreColors
    = Red
    | Yellow
    | Green
    | Blue -- Recently added

-- The code won't compile because Blue is missing
all : List SemaphoreColors
all =
    next [] |> List.reverse

next : List SemaphoreColors -> List SemaphoreColors
next list =
    case List.head list of
        Nothing ->
            Red :: list |> next

        Just Red ->
            Yellow :: list |> next

        Just Yellow ->
            Green :: list |> next

        Just Green ->
            list
```
