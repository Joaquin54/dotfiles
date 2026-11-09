# CLAUDE.md: Neovim config rewrite

## What this is
A from-scratch Neovim config, built one phase at a time from a spec.
I use Neovim mainly to **review** code. You run in a separate tmux pane, never inside Neovim.

- **Config folder:** `~/dotfiles/.config/nvim-new` (part of my dotfiles repo, branch `nvim-rewrite`)
- **Run it with:** `NVIM_APPNAME=nvim-new nvim`
- **Lua namespace:** `jdev` (`lua/jdev/...`)
- **Spec (source of truth):** `nvim-config.md` in my Obsidian vault. I'll start you with `claude --add-dir <vault path>`, so read it from there.

The spec decides **what** and **why**. You write the Lua. If the spec and this file disagree, the spec wins. Tell me about the conflict.

## Before writing any code
1. Read `nvim-config.md` and the existing files in this folder.
2. Reply with a short plan for the phase I named: which files you'll create or change, what goes in each, and every key you'll map.
3. Flag anything that contradicts the spec, the existing config, or itself (wrong key, two plugins doing one job, a key that's a prefix of another).
4. Ask about anything the spec doesn't decide. **Don't fill gaps with your own preferences.**
5. Wait for my OK.

## Scope rules
- Implement **only** the phase I name. Don't start the next one, even if it looks easy.
- Only touch files inside `~/dotfiles/.config/nvim-new`. Exception: Phase 1 also edits my tmux config in `~/dotfiles/.config/tmux`.
- **Never** edit the old config (`~/dotfiles/.config/nvim` or `~/.config/nvim`).
- Only add plugins, keys and options that are in the spec. If something seems missing, ask; don't add it.
- Don't install system tools (Homebrew etc.). Tell me what's needed and I'll install it.
- Don't create test projects, sample files outside this folder, or drive the UI.

## Neovim 0.12: use these, not the old ways
| Use | Not |
|---|---|
| `vim.pack.add({...})`, one call in `plugins/init.lua` | lazy.nvim, packer, `lazy = false`, `priority`, `config = function()` specs |
| `vim.lsp.enable({...})` + `after/lsp/<name>.lua` returning a config table | `require("lspconfig").x.setup()`, mason-lspconfig `handlers` |
| `vim.lsp.config("name", {...})` only if a file in `after/lsp/` can't do it | assigning `vim.lsp.config.name = {...}` |
| `vim.uv` | `vim.loop` |
| `vim.diagnostic.jump({ count = 1 })` | `vim.diagnostic.goto_next()` / `goto_prev()` |
| `vim.keymap.set` with a `desc` on every mapping | `vim.api.nvim_set_keymap`, mappings without `desc` |
| `after/ftplugin/<ft>.lua` for per-language settings | FileType autocmds for indent |
| Built-in defaults (`gc`, `]d`/`[d`, `grn`, `gra`, `grr`, `gri`, `K`) | re-mapping what Neovim already provides |

## Code style
- Format all Lua with stylua, using `.stylua.toml` in this folder.
- One responsibility per file, as in the structure section of the spec.
- Core keymaps go in `lua/jdev/config/remap.lua`. **All plugin keymaps go in `lua/jdev/plugins/keymaps.lua`**, never scattered across plugin files.
- Shared helpers go in `lua/jdev/utils/init.lua`.
- Every autocmd goes in a named augroup with `clear = true`.
- No commented-out code, no disabled `.txt` files, no "maybe later" stubs. Git keeps the history.
- Comments explain **why**, not what.

## Verifying your work
Run all of these before saying a phase is done.

**1. Clean start (must print nothing):**
```sh
NVIM_APPNAME=nvim-new nvim --headless +qa 2>&1
```

**2. Every key you added or changed:**
```sh
NVIM_APPNAME=nvim-new nvim --headless "+verbose nmap <leader>yf" +qa 2>&1
```
Use `xmap` / `imap` for other modes. Check that the key points to the file you expect.

**3. No prefix collisions.** For every new mapping, confirm that no other mapping in the same mode starts with it, or is a prefix of it. Example: `<leader>x` and `<leader>xe` collide; `<leader>pf` and `<leader>ps` don't. List the mappings with `vim.api.nvim_get_keymap(mode)`.

**4. Health checks, when the phase asks for one:**
```sh
NVIM_APPNAME=nvim-new nvim --headless "+checkhealth vim.lsp" "+w! /tmp/health.txt" +qa
```
Then read `/tmp/health.txt`.

**5. Startup time, when relevant:**
```sh
NVIM_APPNAME=nvim-new nvim --headless --startuptime /tmp/st.log +qa && tail -1 /tmp/st.log
```

**Plugin installs:** when a phase adds plugins, tell me before verifying. I'll open Neovim once to approve the install, then you run the checks.

## Finishing a phase
1. Run every check above and show me the output.
2. Tick that phase's checkboxes in `nvim-config.md`.
3. Give me a short summary: files changed, keys added, anything you deliberately left out and why.
4. **Don't commit.** I review the diff in Neovim and commit myself. Don't stage files either; staging is how I mark changes as approved.

## Things that went wrong in my old config (don't repeat them)
- The same plugin defined more than once (three Harpoon specs, two copies of plenary)
- Options placed where the plugin manager ignores them (opts inside `keys`, autopairs options outside `opts`)
- Two language servers for one language (basedpyright + pylsp)
- A leader key that was a prefix of others, causing 1-second waits (`<leader>a` vs `<leader>a…`)
- A colorscheme autocmd that forced one scheme and broke `:colorscheme`
- Keymaps defined in three places for the same action
- Seven colorschemes and toy plugins loaded on every start
