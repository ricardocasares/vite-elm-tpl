---
applyTo: "**/*.{elm,css}"
---

# CSS Instructions

- tailwindcss v4 is already installed and configured
- daisyui v5 is already installed and configured
- always fetch docs from https://daisyui.com/llms.txt
- follow daisyui's best practices
- src/main.css is already present and configured
- do not install any dependencies for customizing styles

## Creating UI components

Always create reusable UI components in `UI` folder:

```elm
-- UI/Alert.elm
module UI.Alert exposing (..)
```

**CRITICAL**:
For complex UI elements that require compile time constraints read [Enforcing build order](./elm.patterns.md)

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
