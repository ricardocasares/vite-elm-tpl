---
applyTo: "**/*.ts"
---

## TypeScript instructions

**CRITICAL:**
Never use TypeScript for main application logic!

Whenever you have to use TypeScript, follow these guidelines:

- Never modify `tsconfig.json`!
- Always handle errors
- Prefer `Union` types over `Object` to model state
- Favor functional programming style
- write short, concise and single value returning functions
- Use `ts-pattern` to pattern match data types
- Avoid using booleans in records
- Always use absolute paths using `@/` prefix

## Commands

- `bun compile` to check app compiles correctly
- `bun interop` to generate typesscript types after modyfing InteropDefinitions.elm

## Elm & TypeScript Interop

**CRITICAL:**

- Read `@src/InteropDefinitions.elm` first, when trying to interop with TypeScript.
- Always run command `bun interop` after modifying `InteropDefinitions.elm` to get up-to-date type definitions.
- Add variants to `ToElm` and `FromElm` types in order to add new features.
- Handle messages in Elm's `subscription` function.
- Handle new variants in `@src/main.ts` at the `subcribe(msg => ...)` function call.
- This makes working in TypeScript very similar as handling messages in Elm.
