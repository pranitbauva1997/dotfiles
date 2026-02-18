## Gemini Added Memories
- The user prefers using 'viu' for high-quality (pixel/Sixel) image rendering in their Alacritty terminal on Arch Linux.
- To render Sixel images (using viu/chafa) inside tmux 3.3+ on the ironman/thor setup, the command must be wrapped: printf "\ePtmux;\e" && <cmd> && printf "\e\\", and 'allow-passthrough on' must be in .tmux.conf.
- The user uses a single monitor setup (either laptop thor or PC ironman). i3 shortcut Mod+Enter should open Alacritty. Partners in debugging!
