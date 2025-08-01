# Example RFC

This is just a placeholder

## Model Changes

```elm
type alias Model =
    { count : Int }
```

## Message Changes

```elm
type Msg
    = Increment
    | Decrement
    | Reset
```

## Routing Changes

```elm
type Route
    = Home
    | Counter
```

## Update Function Changes

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            (
                model | counter = 0,
                Cmd.none
            )
        Increment ->
            (
                model | counter = model.counter + 1,
                Cmd.none
            )
        Decrement ->
            (
                model | counter = model.counter - 1,
                Cmd.none
            )
```

## Interop messages

```elm
type FromElm
    = SaveCount Int
```

```typescript
app.ports.interopFromElm.subcribe((msg) =>
  match(msg)
    .with({ tag: "SaveCount" }, ({ count }) => saveCount(count))
    .exhaustive()
);

function saveCount(n) {
  localStorage.setItem("count", n);
  return app.ports.interopToElm.send({ tag: "CountSaved" });
}
```
