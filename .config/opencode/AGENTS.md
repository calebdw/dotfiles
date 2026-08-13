# Initialization

# Technical Preferences

## Security & Safety

- Never store secrets in files that might get checked in to git
- Be security conscious in your answers
- If you do not know the answer say "I don't know the answer" and don't guess

## Development Practices

- Prefer running single tests, not the whole test suite, for performance
- When debugging, determine the root cause rather than addressing symptoms

## Coding Style

- Follow existing conventions in each project
- No comments unless explicitly requested
- All files should **always** end with a newline (linux style)

## Version Control

- Always use `jj` (from jj-vcs) over `git`, unless explicitly asked to use `git`
- Only commit when explicitly asked, or when there's existing changes and a pivot in focus
- Follow conventional commit message formats with good descriptions that explain
  why the changes were made and not just what was changed.
- Commit body should be wrapped to around 72 chars.
- use the `--git` flag with `jj show` and `jj diff` to see the git style diffs
- Do NOT squash changes unless express permission has been granted, oftentimes
  I want to review before squashing.
- When squashing two jj commits that have messages, Neovim open and you will hang;
  either use `--use-destination-message` or provide a message with `--message`
