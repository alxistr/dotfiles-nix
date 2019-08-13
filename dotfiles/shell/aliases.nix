{
  ".." = "cd ..";
  ll = "ls -lh";
  la = "ls -ACF";
  l = "ls -FAhnl";
  dmesg-less = "sudo dmesg --color=always | less -R";
  cal3 = "cal -3";
  xlock = "i3lock -c 000000 -f";
  kind-kubeconfig = ''export KUBECONFIG="$(kind get kubeconfig-path)"'';
}
