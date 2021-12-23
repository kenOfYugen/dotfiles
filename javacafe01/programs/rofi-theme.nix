{ config, theme, ... }:

with theme.colors;
let inherit (config.lib.formats.rasi) mkLiteral;

in
{
  "*" = {
    text-color = mkLiteral "#3b4b58";
    background-color = mkLiteral "rgba(0, 0, 0, 0%)";
  };

  "#window" = { transparency = "background"; };

  "#mainbox" = {
    padding = mkLiteral "20px 0px 20px 0px";
    background-color = mkLiteral "#${bg}";
    border = mkLiteral "0px";
    border-color = mkLiteral "#${dbg}";
    border-radius = mkLiteral "0px";
    children = map mkLiteral [ "inputbar" "message" "listview" ];
  };

  "#inputbar" = { margin = mkLiteral "0px 0px 20px 20px"; };

  "#element" = { padding = mkLiteral "12px 12px 12px 12px"; };

  "#element-icon" = {
    horizontal-align = mkLiteral "0.5";
    vertical-align = mkLiteral "0.5";
    padding = mkLiteral "0px 10px 0px 5px";
  };

  "#element selected" = {
    background-color = mkLiteral "#${c0}";
    text-color = mkLiteral "#${c8}";
  };

  "#inputbar" = {
    children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
  };

  "#textbox-prompt-colon" = {
    expand = false;
    str = " ";
    text-color = mkLiteral "#${c6}";
    margin = mkLiteral "0px 0.3em 0em 0em";
  };
}

