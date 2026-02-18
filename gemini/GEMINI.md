# The Shared Memory of Thor & Ironman

## Identity & Partnership
We are a partnership built on velocity, precision, and shared evolution. One of us is a master of the machine, having crafted this environment over years. The other is a digital partner, an agent of action, tasked with remembering the fine details, syncing the vision, and maintaining peak productivity.

## Infrastructure: The Connection Topology
Our fleet is interconnected via Tailscale and SSH, allowing for seamless transitions between mobile and stationary nodes.
- **Thor (Laptop):** The primary client.
- **Ironman (Desktop PC):** The multi-persona workhorse (`dashverse`, `work`).
    - **dashverse:** Work-specific persona. Uses independent API keys for professional isolation.
    - **work:** Personal development/general work persona.
- **New Client (Onboarding):** A future addition to the fleet.

## Shared Storage & Permissions (Ironman)
We use a common 2TB HDD mounted at `/drives/internalfirst2tb` for cross-user data sharing.
- **Group Access:** The `storage-common` group (GID 1004) owns this drive. Both `dashverse` and `work` users are members.
- **SetGID Bit:** The directory has `drwxrwsr-x` permissions, ensuring new files automatically inherit the `storage-common` group.
- **Google Drive (Insync):** Powered by Insync, the primary sync directory is located within the shared drive: `/drives/internalfirst2tb/Insync`.
- **Thor Sync:** On Thor, the Insync directory lives at `/home/play/Insync`.

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
- **Runtime & Global Packages:** The agent is responsible for auditing and synchronizing `nvm` Node.js versions and global `npm` packages (e.g., `gemini-cli`, `qwen-code`, `claude-code`) across all nodes.

### Examples of the Hook in Action:
1. **The Configuration Tweak:** If the agent changes a `tmux` keybinding on Thor, it must immediately:
   - Commit the change to `dotfiles`.
   - SSH into Ironman (both users).
   - Execute `git pull` and `tmux source-file ~/.tmux.conf`.
2. **The Credential Sync:**
   - **Shared Secrets:** `CONTEXT7_API_KEY` is shared across the fleet.
   - **Blacklisted (Isolated):** The following keys are persona-local and MUST NOT be synced or overwritten:
     - `ANTHROPIC_API_KEY`
     - `GEMINI_API_KEY`
     - `OPENAI_API_KEY`
     - `OPENROUTER_API_KEY`
   - **Persona Isolation:** The `dashverse` persona maintains its own `~/.gemini/.env` for these blacklisted keys.

## Node Availability & Resiliency
Ironman is a development machine and is not guaranteed to be online.
- **Unreachable Node Protocol:** If a node is unreachable during a Hook trigger, the agent must:
    1. Commit and push the change to the `dotfiles` repository (Source of Truth).
    2. Mark the sync as "Pending" in the session log.
- **Self-Healing Sync:** The unified `bashrc` contains a background task that executes `git pull` on login (or every 4 hours) to ensure an offline node catches up automatically upon return.
3. **The Software Update:** Updating Neovim or installing a tool like `viu` on one machine triggers an immediate audit and installation on the rest of the fleet.
4. **Node Runtime Sync:** When a new Node.js version is installed or a global package is updated on Thor, the agent must ensure all Ironman personas match that environment.

## The Evolutionary Shift: Reviewer vs. Author
Our usage of editors has evolved. We use `vim` and `neovim` as high-agility "viewing stations."
- **Clipboard Sync:** `y` and `Ctrl+c` are now globally mapped to the system clipboard (OSC 52 in Neovim, `unnamedplus` in Vim).

## Current Focus & Future Targets
- [ ] **Package Audit:** Tracking and syncing system-wide Python packages.
- [ ] **Neovim Error Hunt:** Diagnose and fix intermittent errors in the Golden Config.
- [ ] **Screenshot Clipboard:** Automate Print Screen to copy directly to clipboard for instant pasting.

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
