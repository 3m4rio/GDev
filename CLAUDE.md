# GDev — AI-Assisted Game Development Workspace

Claude-ready workspace for AI-paired Roblox game development. Launch Claude Code from this directory (or any project inside `projects/`) and it will pick up this file as project instructions.

---

## What This Is

A **kit**, not a single project. This directory holds:
- **Skills** Claude can reference (`skills/`)
- **Templates** for scaffolding new projects (`templates/`)
- **Session logs** and decision records (`logs/`)
- **Your projects** live in `projects/` (gitignored — your work stays local)

Claude instances launched from here work across projects. Claude instances launched from inside a specific project directory get focused context for that project.

---

## Directory Layout

```
GDev/
├── CLAUDE.md            ← this file (workspace-wide instructions)
├── README.md            ← public-facing intro
├── skills/              ← reusable skill/reference files (.md)
├── templates/           ← scaffolding for new projects
│   └── roblox-game/     ← Rojo + Wally + Rokit Roblox starter
├── projects/            ← your projects (gitignored)
├── logs/                ← session logs, post-mortems, decisions
└── .tools/              ← local binaries (MCP servers, etc.) — gitignored
```

---

## First-Time Setup

Everything needed to get a fresh clone productive. Do these once per machine.

### 1. Install Claude Code
Follow the official instructions at <https://docs.claude.com/en/docs/claude-code>. You need Claude Code installed and signed in before anything else here matters.

### 2. Install Rokit (Roblox toolchain manager)

Rokit manages per-project versions of Rojo, Wally, Selene, and StyLua. Install it once, and every project's `rokit.toml` pins the exact versions it needs.

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/rojo-rbx/rokit/main/scripts/install.ps1 | iex
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/rojo-rbx/rokit/main/scripts/install.sh | sh
```

Then on any shell:
```bash
export PATH="$HOME/.rokit/bin:$PATH"   # add to your shell rc
rokit --version                         # verify
```

**Gotcha:** Rokit shims (`rojo`, `wally`, etc.) only work inside a directory tree that contains a `rokit.toml`. Run them from inside a project dir, not from GDev root.

When you open a project for the first time, cd into it and run:
```bash
rokit install
```
This downloads the pinned tool versions. First run prompts you to trust each tool — accept all.

### 3. Install Roblox Studio

Download from <https://www.roblox.com/create>. You need Studio open to run games and test MCP servers.

### 4. Install the Roblox Studio MCP Plugins

MCP servers let Claude read from and write to your Studio session directly. There are two — install both; they complement each other.

**Option A — Community MCP plugin (37+ tools: execute Luau, create objects, get selection, etc.):**
```bash
npx -y robloxstudio-mcp@latest --install-plugin
```

**Option B — Official Roblox MCP plugin (run code, control play mode, read console):**
1. Download the Roblox Studio MCP installer from <https://github.com/Roblox/studio-rust-mcp-server/releases>
2. Run the installer — it places the plugin into Studio's plugins folder automatically

**Verify installation:**
- Open Roblox Studio → look at the Plugins tab
- You should see MCP plugin entries
- **Per-experience:** Game Settings → Security → **Allow HTTP Requests → ON** (both plugins require this)

### 5. Register MCP Servers with Claude Code

In a terminal at GDev root:

```bash
# Community MCP server
claude mcp add robloxstudio-mcp -- npx -y robloxstudio-mcp@latest

# Official Roblox MCP server (adjust path to your installed binary)
claude mcp add roblox-studio-official -- <path-to>/rbx-studio-mcp --stdio
```

The official server's binary location depends on how you installed it — check the installer output or the repo's README.

**Optional but recommended for this kit:**
```bash
# Context7 — live docs lookup for libraries/APIs
claude mcp add context7 -- npx -y @upstash/context7-mcp

# GitHub — PRs, issues, code search
claude mcp add github -- npx -y @modelcontextprotocol/server-github
# (set GITHUB_PERSONAL_ACCESS_TOKEN env var — see server README)
```

Run `claude mcp list` to confirm everything registered.

### 6. Verify End-to-End

```bash
cd projects/
# copy a template to start a project
cp -r ../templates/roblox-game my-first-game
cd my-first-game
rokit install
wally install
rojo serve
```

Open Studio → install/use the Rojo plugin → connect to the local Rojo server → you should see your `src/` folders syncing into the DataModel.

---

## Creating a New Project

Use the `roblox-new-project` skill, or manually:

1. Copy `templates/roblox-game/` to `projects/<name>/`
2. Edit `default.project.json` — set `"name"` to your project name
3. Edit `wally.toml` — set `name = "<your-scope>/<project-name>"`
4. Edit the project's `CLAUDE.md` — replace `[Game Name]` placeholder
5. `cd projects/<name> && rokit install && wally install`
6. `git init` inside the project (optional — each project can be its own repo)
7. `rojo serve`, open Studio, connect

---

## Dev Philosophy

- **Ship fast, iterate faster.** Working version first, polish second.
- **AI does the heavy lifting.** Claude for boilerplate, exploration, repetitive refactors. Human for creative and architectural decisions.
- **Every project gets its own `CLAUDE.md`.** Workspace-level conventions live here; project-specific ones go in `projects/<name>/CLAUDE.md`.
- **Code is disposable, knowledge is not.** When you learn something useful, write it down in `skills/` or Claude memory. Code regenerates; hard-won context doesn't.
- **Prefer working software over perfect abstractions.** Build the simplest thing that works, refactor when you actually need to.
- **Test at boundaries, trust internals.** Validate user input and external data; don't litter internals with defensive checks.

---

## Conventions for Claude Instances

When Claude is running in this workspace:
- Work inside `projects/<name>/` — never dump generated files in GDev root
- Check `skills/` for reusable patterns before writing something new
- If you discover a reusable pattern, add it as a new skill file in `skills/`
- Log significant decisions or architecture choices in `logs/`
- Respect each project's own `CLAUDE.md` — it overrides workspace conventions

### MCP Server Usage for Studio

- **Prefer `execute_luau`** (community MCP) over raw `run_code` (official MCP) for running code in Studio — more ergonomic and flexible
- The community MCP's `set_property` wants typed values (Vector3/Color3 as Luau tables, not strings) — when in doubt, use `execute_luau` instead
- Studio must be open with HTTP Requests enabled for any MCP tool to work

---

## Useful Slash Commands

Claude Code ships with built-in commands. Ones that pair well with this kit:

- **`/mcp`** — list registered MCP servers and their auth state
- **`/init`** — initialize a `CLAUDE.md` for a new project
- **`/review`** — review a pull request
- **`/help`** — full command list

User-installed skills (if present in your Claude Code setup) — use `/` in the CLI to see what's available on your machine. This kit itself doesn't install global skills; project-specific skills live in `skills/`.

---

## Contributing / Sharing

This workspace is designed to be forkable. Fork, replace anything under `projects/` with your own work, and the scaffolding + skills + setup guide all come along for free. See `README.md` for the public-facing pitch.
