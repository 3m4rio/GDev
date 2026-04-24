# [Game Name] — Roblox Project

## Tech Stack
- **Language:** Luau (strict mode)
- **Sync:** Rojo 7 — `rojo serve` for live sync, `rojo build -o game.rbxl` for builds
- **Packages:** Wally — `wally install` puts deps in Packages/
- **Lint:** Selene — `selene src/`
- **Format:** StyLua — `stylua src/`

## Directory → Roblox Mapping
| Folder | Roblox Service | Runs On |
|--------|---------------|---------|
| `src/server/` | ServerScriptService | Server only |
| `src/client/` | StarterPlayerScripts | Each client |
| `src/shared/` | ReplicatedStorage | Both |
| `src/test/` | TestService | Test runner |

## File Naming (Rojo)
- `*.server.luau` → Script (server)
- `*.client.luau` → LocalScript (client)
- `*.luau` → ModuleScript
- `init.*.luau` → becomes the parent folder's script

## Coding Rules
- `--!strict` at top of every file
- PascalCase: modules, services, types | camelCase: vars, functions | UPPER_SNAKE: constants
- Type all function params and returns
- `local` everything, no globals
- Services via `game:GetService()` at file top
- Shared code in `src/shared/`, never duplicate

## Security
- Never trust client input — validate on server
- No secrets in client-accessible locations
- Server-authoritative for gameplay-critical logic (damage, currency, inventory)

## Studio Setup (per-experience)
- **Game Settings > Security > Allow HTTP Requests → ON** (required for MCP plugins)

## Commands
```bash
rojo serve                    # Live sync with Studio
rojo build -o game.rbxl       # Build place file
wally install                 # Install packages
selene src/                   # Lint
stylua src/                   # Format
```
