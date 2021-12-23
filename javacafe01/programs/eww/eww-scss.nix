{ theme }:

with theme.colors;

''
  * {  
    all: unset;
    font-size: 14px;
    font-family: "Sarasa K Mono", "FiraCode Nerd Font Mono";
    font-weight: 400;
  }

  /* Variables */
  $highlight: #${c8};
  $highlight-ws: #${c8};

  .main-bar {
    padding-top: 3px;
    padding-bottom: 3px;
  }

  .main-bar {
    background: #10171e;
  }

  .right-side {
    margin-right: 15px;
  }

  scale trough {
    all: unset;
    background-color: #${lbg};
    border-radius: 50px;
    min-height: 7px;
    min-width: 70px;
    margin: 0 5px 0 20px;
  }

  scale trough highlight {
    all: unset;
    background: #${c0};
    border-radius: 10px;
  }

  .launcher-icon {
    margin-left: 15px;
  }

  .mpd-name {
    font-size: 20px;
  }

  .mpd {
    color: #fbdf90;
    padding: 2px 0px 2px 0px;
    margin-left: 20px;
    border-radius: 3;
  }

  .workspaces {
    color: #${c5};
    padding: 2px 10px;
  }

  .volume {
    padding: 2px 0px 2px 10px;
    border-radius: 3;
    color: #${c6};
  }

  .battery {
    color: #${c4};
    padding: 2px 0px 2px 0px;
    border-radius: 3;
  }

  .battery-icon {
    padding-left: 5px;
    font-size: 12px;
  }

  .network {
    color: #${c3};
    padding: 2px 1px 2px 11px;
  }

  .network-icon {
    font-size: 17px;
  }

  .network-ssid {
    padding-right: 10px;
  }

  .light {
    color: #${c9};
    padding: 2px 5px 2px 9px;
    font-size: 17px;
  }

  .date {
    background: $highlight;
    color: #${fg};
    padding: 2px 10px;
    padding-right: 0px;
    border-radius: 3;
  }
  .date_alt {
    padding-right: 6px;
  }

  .sidebar {
    all: unset;
  }

  .calendar {
    padding: 15px 15px 15px 15px;
    background: #${dbg};
    border-radius: 10px;
    margin-bottom: 0px;
    color: #${fg};
  }

  .media {
    padding-top: 15px;
    padding-bottom: 12px;
  }

  .image {
    padding-left: 4px;
  }

  .metadata {
    font-weight: 600;
  }

  .power-menu {
    margin-top: 00px;
    padding-top: 4px;
    padding-bottom: 4px;
  }

  .power-icon {
    font-size: 45px;
    padding: 0px 13px 0px 13px;
    background: #${bg}; 
    border-radius: 10px;
    margin-bottom: 10px;
  }


  .power-poweroff {
    font-size: 45px;
    margin-top: 2px;
    padding: 2px 6px 3px 6px;
    margin-bottom: 10px;
    background: #${bg}; 
    border-radius: 9px;
  }

  .sidebar  {
    color: $highlight-ws;
    background:  #${dbg};
    border-radius: 10px;
    padding: 20px;
  }
''
