# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this repository is

`@doordash/eslint-config-doordash` — a shareable ESLint config. The entire
package is `index.js`, a single exported config object. There is no build step,
no test suite, and no CI beyond issue-template validation.

```
index.js            The config. This is the package.
package.json        Deps are the plugins/configs index.js resolves.
.eslintrc           Lints this repo with its own config.
.vscode/settings.json  Editor defaults matching the Prettier settings.
SUPPORT.md          Where non-engineering requests should go.
.github/ISSUE_TEMPLATE/  Issue routing. See below.
```

## Read this before touching .github/ISSUE_TEMPLATE/

This repository is public, is named after a large consumer brand, and is one of
the first GitHub results for "doordash". Every issue it has ever received —
both of them — came from a member of the public trying to reach DoorDash
Support. #11 was empty and titled "Doordash". #12 was titled "Review of
background checks", with one comment: "Door Dash has old e-mail address".

Neither had anything to do with ESLint. Neither could be fixed by a code
change. Someone with a real problem — an outdated email on their account, a
background check they were waiting on — spent their time filing it somewhere
nobody could help, and posted it on a permanent public page while doing so.

`.github/ISSUE_TEMPLATE/config.yml` exists to stop that happening again. It
sets `blank_issues_enabled: false` and offers DoorDash Support links first, so
the "New issue" page routes people to a team that can actually help.

If you are changing that directory:

- **Keep `blank_issues_enabled: false`.** Re-enabling blank issues restores the
  exact path that produced #11 and #12.
- **Keep the support contact links first**, and keep their wording plain. The
  audience is someone who is not a programmer and does not know what ESLint is.
  Say that this repo cannot see their account.
- **Verify any URL before adding it.** `www.doordash.com` sits behind a
  Cloudflare challenge that returns 403 to non-browser clients, so a link there
  cannot be confirmed from a terminal and should not be added on a guess. The
  `help.doordash.com` links currently in `config.yml` were checked and return
  200.
- **Malformed template YAML fails silently.** GitHub ignores a template it
  cannot parse and quietly falls back to blank issues, so the routing breaks
  with no error anywhere. That is what the CI check guards.

## Handling a misfiled issue

Do not write code for it, and do not open a PR claiming to resolve it. There is
nothing in this repository to change. Point the person at
<https://help.doordash.com> and leave closing the issue to a maintainer.

Never copy personal information out of one of these issues — email addresses,
phone numbers, addresses, order or background-check details — into a commit
message, a PR, a test fixture, or a CLAUDE.md. It is someone's personal data
and this is a public repository.

## Changing the config

`index.js` is a plain object; edit it directly. A rule change alters lint
results in every DoorDash repo that consumes this package, so keep changes
narrow and say in the PR which rule moved and why.

Note that `dependencies` pins ESLint 4 and a 2017-era plugin set. Those
versions are what consumers resolve, so bumping any of them is a breaking
change for them, not a routine dependency update.

## Conventions

- No semicolons, single quotes, 80 columns, ES5 trailing commas — the Prettier
  settings this config itself declares.
- `.eslintrc` extends `./index.js`, so the repo is linted by its own config.
  Keep it that way; it is the only check that the config loads at all.
