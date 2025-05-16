# Copilot Instructions

This codebase uses Elm, a pure functional language.

## General Guidelines

- Keep your responses short and concise
- This project uses Vite v5 to bundle source files
- Use Elm v0.19.1 when generating Elm code
- Always use the `elm` compiler as your guide
- Run `elm make src/Main.elm --output=/dev/null` on the @terminal to check for compiler errors
- Keep the `update` function clean and readable
- Keep indentation low by using pipeline operator |>
- Create new modules only around custom types when needed
- Create small reusable functions
- Use `bun dev` on the @terminal to get a working http server
- Run `bun lint` on the @terminal for linting Elm files and fix errors
- Run `bun run test` on the @terminal for testing your changes
- Check the #problems tab to resolve issues

## Commit messages

- Keep commit messages short and concise
- Choose one of the following prefixes:
  - ai: for changes made to copilot instructions
  - ui: for cosmetic changes only
  - ci: for changes made to github workflows
  - doc: for README.md updates or code comments
  - dep: for changes in dependencies
  - fix: for code fixes
  - feat: for new features implemented in the code
