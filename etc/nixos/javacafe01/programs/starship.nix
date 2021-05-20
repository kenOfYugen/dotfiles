{
  character = {
    error_symbol = "[>](bold red)";
    success_symbol = "[>](bold purple)";
    vicmd_symbol = "[>](bold yellow)";
    format = "$symbol ";
  };

  format = "$all";

  hostname = {
    ssh_only = true;
    format = "[$hostname](bold blue) ";
    disabled = false;
  };

  line_break.disabled = true;
  directory.disabled = true;
  nodejs.disabled = true;
  nix_shell.symbol = "(bold blue)";
  package.symbol = "📦  ";
}
