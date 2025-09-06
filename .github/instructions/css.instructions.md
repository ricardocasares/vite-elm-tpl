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

**CRITICAL**:
For complex UI elements that require compile time constraints read @instructions/elm.patterns.md

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
