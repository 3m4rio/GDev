# Skill: Scaffold a New Roblox Project

## When to Use
When the user wants to start a new Roblox game or experience.

## Steps
1. Ask for a project name
2. Copy `templates/roblox-game/` to `projects/<name>/`
3. Update `default.project.json` — set `"name"` to the project name
4. Update `wally.toml` — set `name = "<your-scope>/<project-name>"` (Wally scope is typically your GitHub username)
5. Update `CLAUDE.md` — replace `[Game Name]` with actual name
6. Initialize git inside the project: `git init`
7. Run `rokit install` to link tools
8. Run `wally install` to set up packages
9. Confirm ready and remind user to:
   - Open Studio and create/open the experience
   - **Game Settings > Security > Allow HTTP Requests → ON** (required per-experience for MCP)
   - Run `rojo serve` from the project directory
   - Connect via the Rojo plugin in Studio
