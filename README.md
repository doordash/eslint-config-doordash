# eslint-config-doordash

DoorDash's [ESLint](https://eslint.org) configuration, following our
styleguide. It extends
[`eslint-config-airbnb`](https://github.com/airbnb/javascript) and turns off
the rules that conflict with [Prettier](https://prettier.io), then layers our
own rules on top.

> **Looking for help with the DoorDash app, your account, or a background
> check?** This repository cannot help with any of that — it is a file of
> code-style rules. Please see [SUPPORT.md](SUPPORT.md) or go straight to
> <https://help.doordash.com>.

## Install

```sh
yarn add --dev @doordash/eslint-config-doordash
```

## Use

In your `.eslintrc`:

```json
{
  "extends": "@doordash/eslint-config-doordash"
}
```

## What it sets

- **Base:** `eslint-config-airbnb`, with `eslint-config-prettier` and
  `eslint-config-prettier/react` disabling stylistic rules Prettier owns.
- **Parser:** `babel-eslint`.
- **Plugins:** `jest` and `prettier`.
- **Prettier:** 80 columns, single quotes, no semicolons, ES5 trailing commas.
- **Notable rules:** `camelcase` and `arrow-parens: as-needed` as errors, no
  semicolons, at most one consecutive empty line and none at end of file, and
  `jest/no-disabled-tests` and `jest/no-focused-tests` as errors so a skipped
  or focused test fails the lint step.

See [`index.js`](index.js) for the full set.

## Contributing

Bug reports go through
[the issue templates](https://github.com/doordash/eslint-config-doordash/issues/new/choose).
Please include the rule involved, a small reproduction, and your versions of
this package and of ESLint.
