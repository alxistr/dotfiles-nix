function which-n-where
    realpath (which $argv)
end

function nx-show-dependencies
  nix-store --query --references (which $argv)
end

function nx-show-rdependencies
  nix-store --query --referrers (which $argv)
end
