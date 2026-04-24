# Projects

Your projects live here. This directory is **gitignored** (except for this README) — your work stays on your machine and never ships with the kit.

## Starting a new project

```bash
cp -r ../templates/roblox-game my-new-game
cd my-new-game
rokit install
wally install
rojo serve
```

See the **Creating a New Project** section in the root [`CLAUDE.md`](../CLAUDE.md) for the full walkthrough.

## Structure

Each project gets its own directory and its own `CLAUDE.md`. Workspace conventions live in the root `CLAUDE.md`; project-specific rules override them locally.

```
projects/
├── README.md          ← this file (shipped)
├── my-new-game/       ← your work (gitignored)
├── another-project/   ← also gitignored
└── ...
```
