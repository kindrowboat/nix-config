{ config, lib, pkgs, ... }:
let
  defaults = {
    realName = "Stef Dunlap";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      mu.enable = true;
      thunderbird.enable = true;
  };
in
{

  accounts.email.accounts = {
    stef = defaults // {
      primary = true;
      address = "stef@kindrobot.ca";
      userName = "stef@kindrobot.ca";
      passwordCommand = "pass show muw/stef@kindrobot.ca";
      imap.host = "imap.migadu.com";
      smtp.host = "smtp.migadu.com";
    };
    hello = defaults // {
      address = "hello@kindrobot.ca";
      userName = "hello@kindrobot.ca";
      passwordCommand = "pass show muw/hello@kindrobot.ca";
      imap.host = "imap.migadu.com";
      smtp.host = "smtp.migadu.com";
    };
    team = defaults // {
      address = "kindrobot@tilde.team";
      userName = "kindrobot";
      passwordCommand = "pass show muw/kindrobot@tilde.team";
      imap.host = "imap.tilde.team";
      smtp.host = "smtp.tilde.team";
    };
    gmail = defaults // {
      address = "apocryphalauthor@gmail.com";
      userName = "apocryphalauthor@gmail.com";
      passwordCommand = "pass show muw/apocryphalauthor@gmail.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
        patterns = ["INBOX" "Drafts" "Trash" "Sent" "Archives.*"];
      };
    };
  };
}
