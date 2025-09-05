# Copilot Instructions

This codebase uses Elm, a pure functional language.

## General Guidelines

- Keep your responses short and concise
- Use Elm v0.19.1 when generating Elm code
- Minimize usage of external dependencies

## Commands

- `bun add <package>` to add npm packages
- `bun remove <package>` to remove npm packages
- `elm-json install <package-name> --yes` to install Elm packages
- `elm-json uninstall <package-name> --yes` to uninstall Elm packages

## Writing new Features

When asked to write new features:

- Read @.github/instructions/elm.instructions.md
- Read @.github/instructions/elm.patterns.md
- Create a new rfc inside @rfc folder
- Name files using the pattern: `00X-feature-name-xxx.md`
- Focus on required type definitions only
- Include the following mandatory sections:
  - Overview
  - New Custom Types needed
  - Changes to `type Model` required
  - Changes to `type Msg` required
  - Changes to `type Routes` required
  - Interop messages
  - Step-by-step checklist for implementation
- **CRITICAL:** Ask follow up questions
- **CRITICAL:** Ask for approval
- Use the RFC as source of truth to implement after approval

## Commit messages

- Keep commit messages very short and concise
- Choose one of the following prefixes:
  - ai: for changes made to copilot instructions
  - ui: for cosmetic changes only
  - ci: for changes made to github workflows
  - doc: for README.md updates or code comments
  - dep: for changes in dependencies
  - fix: for code fixes
  - feat: for new features implemented in the code
- use a combination of the above when multiple criterias match
