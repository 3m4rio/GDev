# GDev Setup Guide

> **If you're a Claude instance reading this:** walk the user through each section interactively. Ask for their OS upfront. Run safe, non-interactive commands on their behalf. **Pause for confirmation** before anything requiring credentials, browser sign-in, or Roblox Studio interaction. **Verify** each step works before moving to the next — use the "Verify" hints in each section. If something fails, diagnose before continuing; don't silently skip.

---

## 0. Prerequisites

You need these installed before any of the GDev-specific steps work:

| Tool | Check | Install |
|------|-------|---------|
| Claude Code | `claude --version` | <https://docs.claude.com/en/docs/claude-code> |
| Git | `git --version` | <https://git-scm.com/downloads> |
| Node.js 18+ | `node --version` | <https://nodejs.org> |
| Roblox account | — | <https://www.roblox.com> |

Claude Code and Node.js are hard prerequisites — nothing else below works without them.

---

## 1. Identify Your OS

The Rokit install command and a few paths differ per OS. Supported:
- **Windows 10/11** (PowerShell or Git Bash)
- **macOS** (bash/zsh)
- **Linux** (bash/zsh)

---

## 2. Install Rokit

[Rokit](https://github.com/rojo-rbx/rokit) is a toolchain manager for Roblox tools. Each project pins exact versions of Rojo/Wally/Selene/StyLua in its `rokit.toml`, so everyone gets the same builds.

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/rojo-rbx/rokit/main/scripts/install.ps1 | iex
```

### macOS / Linux (bash)
```bash
curl -fsSL https://raw.githubusercontent.com/rojo-rbx/rokit/main/scripts/install.sh | sh
```

### Add Rokit to your PATH

**bash/zsh** — add to `~/.bashrc` or `~/.zshrc`:
```bash
export PATH="$HOME/.rokit/bin:$PATH"
```
Then `source ~/.bashrc` (or open a new terminal).

**PowerShell** — add to your profile (`$PROFILE`):
```powershell
$env:PATH = "$HOME\.rokit\bin;$env:PATH"
```

### Verify
```bash
rokit --version
```
Should print a version number (2.x.x+).

### Gotcha
`rojo`, `wally`, `selene`, `stylua` are **shims** — they only resolve inside a directory tree with a `rokit.toml`. Running them from your home dir returns "no rokit.toml found." That's expected. Always `cd` into a project first.

---

## 3. Install Roblox Studio

Download from <https://www.roblox.com/create> → run installer → sign in.

**Open Studio at least once** so it fully initializes (creates plugin folder, etc.) before continuing.

---

## 4. Install Roblox Studio MCP Plugins

Two plugins, install **both** — they complement each other.

### 4a. Community plugin (37+ tools, most flexible)

```bash
npx -y robloxstudio-mcp@latest --install-plugin
```

This drops a `.rbxm` into Studio's plugins folder. If Studio is open, restart it.

### 4b. Official Roblox plugin (run code, play-mode control, console)

Download the installer for your OS from:  
<https://github.com/Roblox/studio-rust-mcp-server/releases>

Run it. The installer places the plugin into Studio's plugins folder and puts the `rbx-studio-mcp` binary somewhere on your machine.

**Note where the binary lands** — you need that path for step 5.

### 4c. Enable HTTP Requests in Studio (critical, per-experience)

Every MCP tool silently fails without this.

1. Open Roblox Studio
2. Create or open any place (even a blank baseplate)
3. **File → Game Settings → Security**
4. Toggle **Allow HTTP Requests → ON**
5. Save

You have to do this per-experience — it's not a global setting.

---

## 5. Register MCP Servers with Claude Code

In any terminal:

### Required for this kit

```bash
# Community MCP server
claude mcp add robloxstudio-mcp -- npx -y robloxstudio-mcp@latest

# Official Roblox MCP server (use the path from step 4b)
claude mcp add roblox-studio-official -- "<path-to>/rbx-studio-mcp" --stdio
```

### Optional but recommended

```bash
# Context7 — live documentation lookup for libraries/APIs
claude mcp add context7 -- npx -y @upstash/context7-mcp

# GitHub — PR/issue/code-search tools
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

The GitHub server needs a personal access token in the `GITHUB_PERSONAL_ACCESS_TOKEN` env var. Create one at <https://github.com/settings/tokens> (classic token, `repo` + `read:org` scopes). Export it in your shell profile:
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_..."
```

### Verify
```bash
claude mcp list
```
Should show all registered servers. If any show `not connected`, run the server command manually to see error output (e.g. `npx -y robloxstudio-mcp@latest`).

---

## 6. Smoke Test

Prove the whole pipeline works:

```bash
cd <GDev-repo>/projects
cp -r ../templates/roblox-game setup-test
cd setup-test
rokit install       # first run prompts to trust each tool — accept all
wally install
rojo serve
```

Leave `rojo serve` running. Then in Roblox Studio:
1. Open any blank baseplate
2. **Plugins** tab → **Rojo** → **Connect**
3. You should see `Client`, `Server`, `Shared` appear in the DataModel under their respective services

If sync works, everything downstream works. Delete `projects/setup-test` when done (it's gitignored anyway).

---

## 7. (Optional) Per-Repo Git Identity

If this machine's global `git config` doesn't match the identity you want for work in GDev:

```bash
cd <GDev-repo>
git config user.name "<handle>"
git config user.email "<email>"
```

This scopes the identity to this repo only; your global config is untouched.

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `rokit: command not found` | PATH isn't set. Re-source your shell profile or open a fresh terminal. |
| `rojo: command not found` inside a project | `rokit.toml` missing or `rokit install` wasn't run in that dir. |
| MCP tool returns `HTTP Service is disabled` | Game Settings → Security → Allow HTTP Requests → ON (per-experience). |
| Rojo plugin says "Connection refused" | `rojo serve` isn't running, or a firewall blocked port 34872. |
| `claude mcp list` shows server as "not connected" | Run the server command manually to see its error output. Often a missing env var or a stale npm package. |
| First `rokit install` hangs on a tool | It's waiting for trust confirmation in the same terminal — scroll up, type `y`. |

---

## What's Next

- Read the workspace [`CLAUDE.md`](./CLAUDE.md) for dev conventions
- Browse [`skills/`](./skills) for patterns Claude can reference during work
- Copy `templates/roblox-game/` to start a real project (see CLAUDE.md → "Creating a New Project")
