# Interop Guidelines

**CRITICAL:** Read @src/InteropDefinitions.elm first!

Elm can only interact with TypeScript and other browser APIs via `ports`

## Ports

**CRITICAL:** Only **two ports are available** to the application:

```elm
port interopToElm : (Json.Decode.Value -> msg) -> Sub msg
port interopFromElm : Json.Encode.Value -> Cmd msg
```

## Interop Messages

**CRITICAL:** Only **two custom types** are available in @src/InteropDefinitions.elm for interop: 

```elm
-- Example
type ToElm = Ping
type FromElm = Pong
```

- Add variants to `ToElm` and `FromElm` to add new features
- Handle incoming messages in Elm's `subscription` function
- Read https://package.elm-lang.org/packages/dillonkearns/elm-ts-json/2.1.1/TsJson-Codec
- Write codecs for custom types inside their respective modules

## Handling messages

**CRITICAL:** Run command `bun interop` after modifying @src/InteropDefinitions.elm

- Handle new variants in `@src/main.ts` at the `subcribe(msg => ...)` function call
- This makes working in TypeScript very similar as handling messages in Elm