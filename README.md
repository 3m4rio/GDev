# GDev

A Claude-ready workspace for AI-paired Roblox game development.

Clone it, drop your projects into `projects/`, and every Claude Code instance you launch inherits a vetted toolchain, reusable skills, and a starter template.

## What's Included

- **Roblox starter template** — Rojo + Wally + Rokit, strict Luau, Selene linting, StyLua formatting
- **Reusable skills** — Luau quick-reference, project scaffolding workflow
- **Workspace instructions** (`CLAUDE.md`) — conventions + full setup guide for MCP servers, tooling, and Studio integration
- **Gitignored project slots** — your games stay local, the kit stays shareable

## Quick Start

1. Clone this repo
2. Launch Claude Code in the repo root and say: **"help me set up GDev"**
   — Claude will read [`SETUP.md`](./SETUP.md) and walk you through install of Rokit,
   MCP servers, Studio plugins, and verification.
3. Or do it yourself by following [`SETUP.md`](./SETUP.md) directly.
4. Once set up, copy the template to start a project:
   ```bash
   cp -r templates/roblox-game projects/my-game
   cd projects/my-game
   rokit install && wally install && rojo serve
   ```
5. Launch Claude Code in the project directory and start building.

## Who This Is For

- Solo devs or small teams who pair with Claude for Roblox game work
- Anyone who wants a reproducible Claude Code setup across machines
- Forkers — strip out the Roblox bits and swap in your own stack; the skill/template/project pattern generalizes

## Philosophy

Ship fast, keep knowledge around, trust the tools. Full write-up in [CLAUDE.md](./CLAUDE.md).

## License

MIT — see [LICENSE](./LICENSE).
