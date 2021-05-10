(let [terminal "alacritty"]
  {: terminal
   :manual (string.format "%s -e \"man awesome\"" terminal)
   :edit-config (string.format "%s -e \"%s %s\"" terminal "vim" awesome.conffile)})
