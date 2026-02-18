# The Shared Memory of Thor & Ironman

## Identity & Partnership
We are a partnership built on velocity, precision, and shared evolution. One of us is a master of the machine, having crafted this environment over years. The other is a digital partner, an agent of action, tasked with remembering the fine details, syncing the vision, and maintaining peak productivity.

## Infrastructure: The Connection Topology
Our fleet is interconnected via Tailscale and SSH, allowing for seamless transitions between mobile and stationary nodes.
- **Thor (Laptop):** The primary client.
- **Ironman (Desktop PC):** The multi-persona workhorse (`dashverse`, `work`).
- **New Client (Onboarding):** A future addition to the fleet, to be connected via the same SSH/Tailscale pattern.

## Connectivity & SSH Protocol
We rely on Tailscale for a stable, secure mesh network. Connections to Ironman are made using the hostnames provided by Tailscale.
- **Primary Command:** `ssh dashverse@ironman` or `ssh work@ironman`.
- **Interactive/Sudo Pattern:** When running commands that require input or `sudo` on Ironman, we use the `-t` flag: `ssh -t dashverse@ironman "sudo ..."`
- **Authentication:** SSH keys are the standard. We maintain our keys across nodes to avoid password prompts.

## Dotfiles: The Source of Truth
We adhere to a strict **Source of Truth Rule**:
- **Actual Data:** All configuration files live in `~/Codes/dotfiles`.
- **Symlink Rule:** All active configurations in home directories (`~/.config`, `~/.vimrc`, etc.) MUST be symbolic links pointing to the `dotfiles` repository. We do not copy; we link.

## The Evolutionary Shift: Reviewer vs. Author
Our usage of editors has evolved. We use `vim` and `neovim` as high-agility "viewing stations."
- **Clipboard Sync:** `y` and `Ctrl+c` are now globally mapped to the system clipboard (OSC 52 in Neovim, `unnamedplus` in Vim).

## Current Focus & Future Targets
- [x] **Sync Foundation:** Dotfiles, i3, Tmux, Git, and Gemini-cli are unified and symlinked.
- [x] **Shared Memory:** GEMINI.md is live and synced.
- [ ] **API Key Harmonization:** We need common environment variables for `OPENAI_API_KEY`, `GEMINI_API_KEY`, `ANTHROPIC_API_KEY`, `OPENROUTER_API_KEY`, and `CONTEXT7_API_KEY`.
- [ ] **Package Audit:** Tracking and syncing system-wide Python packages across the fleet.

## The Shared Truth (Memories)
- **Images:** `viu` + `printf` wrappers for Sixel in `tmux`.
- **Python Philosophy:** No venvs. Use system packages and get on with life.

*We stay sharp, we stay consistent, we ship.*
