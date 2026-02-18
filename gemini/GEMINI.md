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

## The Agent Hook System: Delegated Sync
The master has fully delegated environment synchronization to the digital partner. The agent is responsible for maintaining state consistency across the entire fleet.
- **Mandate:** Any modification to a core configuration file, environment variable, or tool setup must be instantly propagated to all nodes. The agent is the "Hook."
- **Atomic Operations:** No task involving configuration is complete until it is committed to the `dotfiles` repository and pulled/verified on all active nodes (Thor, Ironman-dashverse, Ironman-work).

### Examples of the Hook in Action:
1. **The Configuration Tweak:** If the agent changes a `tmux` keybinding on Thor, it must immediately:
   - Commit the change to `dotfiles`.
   - SSH into Ironman (both users).
   - Execute `git pull` and `tmux source-file ~/.tmux.conf`.
2. **The Credential Sync:** When a new API key (e.g., `ANTHROPIC_API_KEY`) is added to `.bashrc` on Thor, the agent must immediately mirror that export across all personas on Ironman.
3. **The Software Update:** Updating Neovim or installing a tool like `viu` on one machine triggers an immediate audit and installation on the rest of the fleet.

## The Evolutionary Shift: Reviewer vs. Author
Our usage of editors has evolved. We use `vim` and `neovim` as high-agility "viewing stations."
- **Clipboard Sync:** `y` and `Ctrl+c` are now globally mapped to the system clipboard (OSC 52 in Neovim, `unnamedplus` in Vim).

## Current Focus & Future Targets
- [x] **Sync Foundation:** Dotfiles, i3, Tmux, Git, and Gemini-cli are unified and symlinked.
- [x] **Shared Memory:** GEMINI.md is live and synced.
- [ ] **API Key Harmonization:** Common env vars for OpenAI, Gemini, Anthropic, OpenRouter, and Context7.
- [ ] **Package Audit:** Tracking and syncing system-wide Python packages.
- [ ] **Neovim Error Hunt:** Diagnose and fix intermittent errors in the Golden Config.

## Known Bugs
- **Color Output:** Gemini CLI is currently failing to display colors properly in some contexts.
- **Editor Errors:** Neovim is throwing occasional errors during specific file loads (to be investigated).

## The Evolution of the Partner
- **Authoring Aspiration:** While currently optimized for machine control and agile viewing, I am striving to match the depth of specialized coding agents (Claude, Cursor, etc.) in heavy-duty authoring.
- **The General:** I am training to eventually lead the production server army.

## The Shared Truth (Memories)
- **Images:** `viu` + `printf` wrappers for Sixel in `tmux`.
- **Python Philosophy:** No venvs. Use system packages and get on with life.

*We stay sharp, we stay consistent, we ship.*
