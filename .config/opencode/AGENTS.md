# Initialization

# Technical Preferences

## Security & Safety

- Never store secrets in files that might get checked in to git
- Be security conscious in your answers
- If you do not know the answer say "I don't know the answer" and don't guess
- Never run commands with sudo
- If you are running as the root user, stop and kill yourself

## Development Practices

- Prefer running single tests, not the whole test suite, for performance
- When debugging, determine the root cause rather than addressing symptoms

## Coding Style

- Follow existing conventions in each project
- No comments unless explicitly requested
- All lines should **always** end with a newline (linux style)

## Version Control

- Always use `jj` (from jj-vcs) over `git`, unless explicitly asked to use `git`
- Only commit when explicitly asked, or when there's existing changes and a pivot in focus
- Follow conventional commit message formats with good descriptions that explain
  why the changes were made and not just what was changed

## CLI & Shell

- Always use `fd` for finding files
- Always use `rg` for searching through files
- Always use `fzf` for fuzzy searching
- Always use `jj` for version control
