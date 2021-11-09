{ theme }:

with theme.colors;

''
  * {
      border: 0px solid rgba(40, 44, 52, 0.0);
      border-radius: 3px;
      font-family: 'Sarasa Mono K', 'Font Awesome 5 Free';
      font-weight: 700;
      font-size: 12px;
      min-height: 0;
  }

  window#waybar {
      background-color: #${dbg};
      border: transparent;
      color: #bbc2cf;
      transition-property: background-color;
      transition-duration: .5s;
      border-radius: 0;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }


  window#waybar.chromium {
      background-color: #000000;
      border: none;
  }

  #workspaces button {
      padding: 5px 5px;
      background-color: transparent;
      color: #ffffff;
  }

  #workspaces button:hover {
      background: #${c0};
  }

  #workspaces button.focused {
      background-color: #${c8};
      color: #${c7};
  }

  #workspaces button {
      background-color: transparent;
      color: #${c15};
  }

  #workspaces button.urgent {
      background-color: #eb4d4b;
  }

  #mode {
      background-color: #64727D;
      border: 3px solid #ffffff;
  }

  #battery,
  #cpu,
  #memory,
  #disk,
  #temperature,
  #backlight,
  #network,
  #pulseaudio,
  #custom-media,
  #workspaces,
  #clock,
  #tray,
  #mode,
  #idle_inhibitor,
  #custom-firefox,
  #mpd {
      padding: 0 10px;
      margin: 4px 4px 4px 4px;
      color: #1e2127;
  }

  #window,
  /* #workspaces {
      margin: 4px 4px 4px 0px;
      padding: 0px 4px;
  }
  */

  #clock {
      background-color: #${c4};
  }

  #battery {
      background-color: #${c6};
      color: #000000;
  }

  #battery.charging, #battery.plugged {
      color: #ffffff;
      background-color: #${c2};
  }

  @keyframes blink {
      to {
          background-color: #${c6};
          color: #000000;
      }
  }

  #battery.critical:not(.charging) {
      background-color: #${c1};
      color: #ffffff;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
  }

  label:focus {
      background-color: #000000;
  }

  #cpu {
      background-color: #${c3};
      color: #2e3440;
  }

  #custom-firefox {
      background-color: #d19a66;
      color: #2e3440;
  }

  #memory {
      background-color: #${c5};
  }

  #disk {
      background-color: #964B00;
  }

  #backlight {
      background-color: #90b1b1;
  }

  #network {
      background-color: #${c13};
  }

  #network.disconnected {
      background-color: #${c9};
  }

  #pulseaudio {
      background-color: #ebcb8b;
      color: #2e3440;
  }

  #pulseaudio.muted {
      background-color: #90b1b1;
      color: #2a5c45;
  }

  #custom-media {
      background-color: #66cc99;
      color: #2a5c45;
      min-width: 100px;
  }

  #custom-media.custom-spotify {
      background-color: #66cc99;
  }

  #custom-media.custom-vlc {
      background-color: #ffa000;
  }

  #temperature {
      background-color: #f0932b;
  }

  #temperature.critical {
      background-color: #eb4d4b;
  }

  #tray {
      background-color: #2980b9;
  }

  #idle_inhibitor {
      background-color: #2d3436;
  }

  #idle_inhibitor.activated {
      background-color: #ecf0f1;
      color: #2d3436;
  }

  #mpd {
      background-color: #98c379;
      color: #2e3440;
  }

  #mpd.disconnected {
      background-color: #98c379;
  }

  #mpd.stopped {
      background-color: #98c379;
  }

  #mpd.paused {
      background-color: #98c379;
  }

  #language {
      background: #00b093;
      color: #740864;
      padding: 0 5px;
      margin: 0 5px;
      min-width: 16px;
  }
''
