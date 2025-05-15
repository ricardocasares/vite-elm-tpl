---
applyTo: "**/*.{elm,css}"
---

# CSS Instructions

- Use `tailwindcss` v4 classes
- Use `DaisyUI` v5 pre-made components
- Use Context7 MCP server to learn how to use `DaisyUI` and `tailwindcss`

## Elm Elements

When creating elements in Elm language, always favor composability:

```elm
-- Bad: This element cannot be extended or composed
card: String -> Html msg
card title = div [ class "card bg-info" ] [ text title ]


-- Good: The card element can be extended with new classes
card: List (Attribute msg) -> List (Html msg) -> Html msg
card attr children =
    div ([ class "card bg-info" ] ++ attrs) children


-- Good: The card element can be composed with children
view model =
    card [ class "text-3xl" ] [ button [ class "button" ] [ text "Button" ] ]
```
