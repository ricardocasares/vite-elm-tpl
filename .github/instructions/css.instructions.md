---
applyTo: "**/*.{elm,css}"
---

# CSS Instructions

This project uses [DaisyUI](https://daisyui.com/) for styling the UI.

**CRITICAL:** Fetch docs from https://daisyui.com/llms.txt

- DaisyUI is installed and configured
- Follow DaisyUI's best practices style guides
- do not install any dependencies!

## Creating UI components

Always create reusable UI components in `UI` folder:

```elm
-- UI/Alert.elm
module UI.Alert exposing (..)
```

## Composability

When creating components in Elm language, always favor composability:

```elm
card: List (Attribute msg) -> List (Html msg) -> Html msg
card attr children =
    div (class "card bg-info" :: attrs) children

view model =
    card [ class "text-3xl" ] [ button [ class "button" ] [ text "Button" ] ]
```

This component is composable and can be customized.

## Complex components

**CRIICAL:** Read about patterns in @instructions/elm.patterns.md

Some components need to enforce invariants or build order, for example, a Range component:

- Must have a `value`
- Must have a `step` value
- A `step` must be greater than zero
- Must have a `min` value
- Must have a `max` value
- The `value` must be between `min` and `max`
- The `min` cannot exceed `max`
- The `max` cannot be less or equal to `min`

To enforce this properties you can use Phantom Types and Builder patterns.
