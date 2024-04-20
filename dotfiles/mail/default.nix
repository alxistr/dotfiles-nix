{ config, pkgs, lib, osConfig, ... }:

let cfg = osConfig.own.mail; in

let mkAccount = (name: {
  flavor = "plain";
  address = name;
  realName = name;
  userName = name;
  passwordCommand = "pass show accounts/eMail/${name}-app";
  imap = {
    # tls = {
    #   enable = true;
    #   useStartTls = true;
    # };
  };
  mbsync = {
    enable = true;
    create = "maildir";
  };
  msmtp = {
    enable = true;
  };
}); in

let mkGmailAccount = (name: (mkAccount name) // {
  flavor = "gmail.com";
}); in

let mkAirmailAccount = (name: (mkAccount name) // {
  smtp.host = "mail.cock.li";
  imap.host = "mail.cock.li";
}); in

with lib;
{
  accounts.email.accounts =
    (genAttrs cfg.gmail mkGmailAccount) //
    (genAttrs cfg.airmail mkAirmailAccount) //
    {
      "" = {
        address = "nowhere";
        realName = "nowhere";
        userName = "nowhere";
        primary = true;
      };
    };

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
  };

  home.file.".mailcap".source = ./mailcap;
  home.file.".neomutt/includes".source = ./includes;
  home.file.".neomutt/neomuttrc".text = ''
    source ~/.neomutt/includes/main
  '';

  home.packages = with pkgs; [
    neomutt
    (pkgs.stdenv.mkDerivation {
      name = "update-mutt-mailboxes";
      buildInputs = [ python3 ];
      unpackPhase = ":";
      installPhase = ''
        mkdir -p $out/bin
        substituteAll ${./mailboxes.py} $out/bin/update-mutt-mailboxes
        chmod +x $out/bin/update-mutt-mailboxes
      '';
    })
  ];

}
