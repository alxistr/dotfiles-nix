let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/dotfiles-nix
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +23 ~/projects/dotfiles-legacy/playbooks/roles/dotfiles-vim/files/nvim/startup/plugins.vim
badd +5 ~/projects/dotfiles-legacy/playbooks/roles/dotfiles-vim/tasks/user.yml
badd +3 ~/projects/dotfiles-legacy/playbooks/roles/dotfiles-vim/defaults/main.yml
badd +3 ~/projects/dotfiles-legacy/playbooks/roles/dotfiles-themes/tasks/root.yml
badd +15 ~/projects/dotfiles-legacy/playbooks/roles/dotfiles-themes/tasks/user.yml
badd +4 ~/projects/dotfiles-legacy/playbooks/roles/home-preset/tasks/root.yml
badd +3 install.sh
badd +1 nixos/hosts/common.nix
badd +23 nixos/dotfiles/awesome/default.nix
badd +33 nixos/dotfiles/vim/default.nix
badd +3 nixos/dotfiles/vim/packages.nix
badd +32 nixos/dotfiles/vim/plugins.nix
badd +12 nixos/dotfiles/home.nix
badd +27 nixos/dotfiles/awesome/luamodules.nix
badd +47 nixos/modules/secrets.nix
badd +4 nixos/secrets.nix
badd +5 nixos/modules/default.nix
badd +32 nixos/configuration.nix
badd +6 nixos/dotfiles/git/default.nix
badd +11 nixos/dotfiles/browsers/default.nix
badd +7 nixos/dotfiles/bash/default.nix
badd +6 .gitignore
badd +1 nixos/dotfiles/ssh/default.nix
badd +1 nixos/dotfiles/bash/curlrc
badd +1 nixos/dotfiles/bash/wgetrc
badd +11 nixos/dotfiles/network/default.nix
badd +1 nixos/dotfiles/awesome/awesome/rc.lua
badd +1 nixos/dotfiles/awesome/awesome/theme/theme.lua
badd +7 iso.nix
badd +1 nixos/dotfiles/ssh
badd +4 nixos/dotfiles/idea/default.nix
badd +3 nixos/dotfiles/termite/default.nix
badd +1 nixos/dotfiles/idea/ideavimrc
badd +1 nixos/dotfiles/ranger/ranger/scope.sh
badd +1 nixos/dotfiles/awesome/rofi.conf
badd +3 nixos/dotfiles/tmux/tmux.conf
badd +1 nixos/dotfiles/vim/rc.vim
badd +6 nixos/dotfiles/themes/default.nix
badd +4 nixos/dotfiles/preset/default.nix
badd +3 fix-layouts.sh
badd +1 nixos/hosts/virtualization.nix
badd +1 nixos/hosts/virt.nix
badd +1 nixos/hosts/docker.nix
badd +4 nixos/dotfiles/network/w3m-keymap
badd +1 nixos/dotfiles/preset/cmus-tomorrow
badd +3 nixos/hosts/laptop/configuration.nix
badd +5 nixos/hosts/raspberry/configuration.nix
badd +7 nixos/hosts/raspberry/hardware-configuration.nix
badd +43 nixos/modules/gui.nix
badd +6 nixos/modules/sound.nix
badd +15 nixos/modules/ssh.nix
badd +9 nixos/modules/docker.nix
badd +16 nixos/modules/virt.nix
badd +2 nixos/modules/system-config.nix
badd +8 nixos/dotfiles/devel/default.nix
badd +5 nixos/modules/documentation.nix
badd +1 nixos/hosts/laptop/hardware-configuration.nix
badd +11 sd-image/default.nix
badd +1 nixos/modules/docker.nix_
badd +1 nixos/modules/sd-image.nix
badd +11 nixos/modules/rpi3bp.nix
badd +3 nixos/hosts/raspberry-sdimage/configuration.nix
badd +5 nixos/hosts/raspberry-sdimage/hardware-configuration.nix
badd +4 nixos/hosts/iso/iso.nix
badd +7 nixos/hosts/iso/configuration.nix
badd +4 nixos/hosts/iso/hardware-configuration.nix
badd +1 iso.sh
badd +12 nixos/dotfiles/termite/themes/dracula
badd +5 nixos/dotfiles/bash/fish/prompt.fish
badd +1 nixos/dotfiles/termite
badd +6 nixos/dotfiles/termite/themes/gruvbox-dark
badd +11 nixos/dotfiles/termite/themes/nord
badd +4 nixos/dotfiles/termite/themes/gruvbox-dark-custom
badd +8 nixos/dotfiles/bash/fish/nix.fish
badd +4 nixos/dotfiles/bash/bash.nix
badd +7 nixos/dotfiles/bash/aliases.nix
badd +9 nixos/dotfiles/bash/fish.nix
badd +14 nixos/overlay/default.nix
badd +40 nixos/dotfiles/awesome/awesome/screen-init.lua
badd +1 nixos/overlay/packages/xnview.nix
badd +3 nixos/dotfiles/bash/bash/nix.sh
badd +347 nixos/dotfiles/awesome/awesome/bindings.lua
badd +1 nixos/overlay/packages/i3lock-blur.nix
badd +2 nixos/overlay/packages/powerline-rs/default.nix
badd +7 nixos/overlay/packages/xnview/default.nix
badd +1 nixos/overlay/packages/i3lock-blur/default.nix
badd +31 nixos/overlay/packages/i3lock-blur/i3lockpp
badd +1 nixos/overlay/packages/i3lock-blur
badd +5 nixos/overlay/packages/i3lockpp/default.nix
badd +4 nixos/overlay/shell.nix
badd +1 nixos/overlay/packages/i3lockpp/bin/i3lockpp
badd +3 nixos/overlay/packages/i3lockpp/i3lockpp
badd +18 nixos/dotfiles/awesome/awesome/main-menu.lua
badd +3 nixos/overlay/readme.md
badd +1 nixos/overlay/packages/lua-packages/freedesktop.nix
badd +7 nixos/overlay/packages/powerline-rs/override.nix
badd +11 nixos/overlay/packages/lua-packages/awesome-freedesktop.nix
badd +1 nixos/overlay/packages/awesome-freedesktop.nix
badd +2 switch.sh
argglobal
silent! argdel *
edit nixos/dotfiles/preset/default.nix
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 94 + 95) / 190)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 190)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 17 - ((16 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
17
normal! 0
lcd ~/projects/dotfiles-nix
wincmd w
argglobal
if bufexists('~/projects/dotfiles-nix/nixos/overlay/packages/lua-packages/awesome-freedesktop.nix') | buffer ~/projects/dotfiles-nix/nixos/overlay/packages/lua-packages/awesome-freedesktop.nix | else | edit ~/projects/dotfiles-nix/nixos/overlay/packages/lua-packages/awesome-freedesktop.nix | endif
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 5 - ((4 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 02|
lcd ~/projects/dotfiles-nix
wincmd w
exe 'vert 1resize ' . ((&columns * 94 + 95) / 190)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 190)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
