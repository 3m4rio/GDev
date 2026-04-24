# Roblox Game Template

## Usage
Copy this entire folder to `projects/<your-game-name>/` then:
```bash
cd projects/<your-game-name>
export PATH="$HOME/.rokit/bin:$PATH"
rokit install
wally install
rojo serve
```

## What's Included
- Rojo project config with standard service mapping
- Rokit toolchain pinning (Rojo, Wally, Selene, StyLua)
- Wally package manifest
- Luau strict mode config
- Linter + formatter configs
- Starter scripts for server, client, and shared modules
- Project-specific CLAUDE.md with Roblox conventions
