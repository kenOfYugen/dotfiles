{ config, ... }:

let inherit (config.lib.formats.rasi) mkLiteral;

in {
  "*" = {
    text-color = mkLiteral "#3b4b58";
    background-color = mkLiteral "rgba(0, 0, 0, 0%)";
  };

  "#window" = { transparency = "background"; };

  "#mainbox" = {
    padding = mkLiteral "20px 0px 20px 0px";
    background-color = mkLiteral "#131A21";
    border = mkLiteral "2px";
    border-color = mkLiteral "#10171e";
    border-radius = mkLiteral "5px";
    children = map mkLiteral [ "inputbar" "message" "listview" ];
  };

  "#inputbar" = { margin = mkLiteral "0px 0px 20px 20px"; };

  "#element" = { padding = mkLiteral "5px 3px 5px 20px"; };

  "#element selected" = {
    background-color = mkLiteral "#29343d";
    text-color = mkLiteral "#131A21";
  };

  "#inputbar" = {
    children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
  };

  "#textbox-prompt-colon" = {
    expand = false;
    str = " ";
    text-color = mkLiteral "#7ed491";
    margin = mkLiteral "0px 0.3em 0em 0em";
  };
}

