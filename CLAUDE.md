# GDev — AI-Assisted Game Development Workspace

Claude-ready workspace for AI-paired Roblox game development. Drop projects into `projects/`, and every Claude Code instance you launch inherits the toolchain, skills, and starter template.

---

## Setup

**Human reading this on a fresh clone:** follow [`SETUP.md`](./SETUP.md) — it has the full walkthrough.

**Claude instance reading this as project context:** if the user asks anything like *"help me set this up,"* *"set up GDev,"* *"install this,"* or *"get me started,"* open [`SETUP.md`](./SETUP.md) and walk them through it interactively. Protocol:
1. Ask their OS first (Windows / macOS / Linux) — several steps branch on this.
2. Run `SETUP.md` section by section, in order. Skip anything clearly already done (e.g. `node --version` works → skip Node install).
3. Do safe, non-interactive commands on their behalf. Pause and ask before anything that needs credentials, browser login, downloading an installer, or Roblox Studio interaction.
4. Use the **Verify** hints in each section — confirm the step worked before moving on. If something fails, diagnose the root cause; don't silently skip.
5. Finish with the smoke test in `SETUP.md §6` — that's the proof the whole pipeline works.
6. If any URL, package name, or step in `SETUP.md` is broken or stale, flag it so the user can fix it at the source.

---

## Directory Layout

```
GDev/
├── CLAUDE.md            ← workspace conventions (this file, auto-loaded by Claude)
├── SETUP.md             ← first-time setup walkthrough
├── README.md            ← public-facing intro
├── LICENSE              ← MIT
├── skills/              ← reusable skill/reference files
├── templates/           ← scaffolding for new projects
│   └── roblox-game/     ← Rojo + Wally + Rokit Roblox starter
├── projects/            ← your projects (gitignored)
└── logs/                ← session logs, post-mortems, decisions
```

---

## Dev Philosophy

- **Ship fast, iterate faster.** Working version first, polish second.
- **AI does the heavy lifting.** Claude for boilerplate, exploration, repetitive refactors. Human for creative and architectural decisions.
- **Every project gets its own `CLAUDE.md`.** Workspace-level conventions live here; project-specific ones go in `projects/<name>/CLAUDE.md` and override these.
- **Code is disposable, knowledge is not.** When you learn something useful, write it down in `skills/` or Claude memory. Code regenerates; hard-won context doesn't.
- **Prefer working software over perfect abstractions.** Build the simplest thing that works, refactor when you actually need to.
- **Test at boundaries, trust internals.** Validate user input and external data; don't litter internals with defensive checks.

---

## Creating a New Project

Use the `roblox-new-project` skill (`skills/roblox-new-project.md`), or manually:

1. Copy `templates/roblox-game/` to `projects/<name>/`
2. Edit `default.project.json` — set `"name"` to your project name
3. Edit `wally.toml` — set `name = "<your-scope>/<project-name>"`
4. Edit the project's `CLAUDE.md` — replace `[Game Name]` placeholder
5. `cd projects/<name> && rokit install && wally install`
6. `git init` inside the project (optional — each project can be its own repo)
7. `rojo serve`, open Studio, connect via Rojo plugin

---

## Conventions for Claude Instances

When working in this workspace:
- Work inside `projects/<name>/` — never dump generated files in GDev root
- Check `skills/` for reusable patterns before writing something new
- If you discover a reusable pattern, add it as a new skill file in `skills/`
- Log significant decisions or architecture choices in `logs/`
- Respect each project's own `CLAUDE.md` — it overrides workspace conventions

### MCP Server Usage (Roblox Studio)

- **Prefer `execute_luau`** (community MCP) over raw `run_code` (official MCP) — more ergonomic for most cases
- Community MCP's `set_property` wants typed values (Vector3/Color3 as Luau tables, not strings). When in doubt, use `execute_luau` to set properties via code.
- Studio must be open with HTTP Requests enabled for any MCP tool to work (see `SETUP.md §4c`).

---

## Useful Slash Commands

Built into Claude Code:

- **`/mcp`** — list registered MCP servers and their auth state
- **`/init`** — initialize a `CLAUDE.md` for a new project
- **`/review`** — review a pull request
- **`/help`** — full command list
