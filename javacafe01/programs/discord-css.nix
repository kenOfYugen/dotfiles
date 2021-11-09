{ theme }:

with theme.colors;

''
  :root {
       --background-primary : #${bg};
       --background-secondary : #${bg};
       --background-secondary-alt : #${bg};
       --background-tertiary : #${bg};
       --background-floating : #${bg};
       --header-primary : #ffffff;
       --interactive-normal : #ffffff;
       --interactive-hover : #ECEFF4;
       --interactive-active : #ECEFF4;
       --interactive-muted : #ffffff;
       --text-normal : #ffffff;
       --text-link : #a5a9bd;
       --text-muted : #ffffff;
       --channeltextarea-background : #${dbg};
       --text-warning : #e06c75;
       --brand-experiment : #434C5E !important;
     }
     .container-1D34oG > div {
       background-color : var(--background-primary);
       border-left: 2px solid #${dbg};
       border-top: 2px solid #${dbg};
     }
     .item-3HknzM[aria-label~=Add] {
       background-color : #434C5E !important;
     }
     nav[aria-label="Servers sidebar"] {
      border-top: 2px solid #${dbg};
      border-right: 2px solid #${dbg};
      border-radius: 0 15px 0 0;
      margin-right: 20px;
    }
     .membersWrap-2h-GB4 {
       min-width : 0;
       border-top: 2px solid #${dbg};
       border-left: 2px solid #${dbg};
     }
     .panels-j1Uci_ {
       border-radius: 15px 15px 15px 15px;
       border: 2px solid #${dbg};
       background-color: #${bg};
       margin: 0 10px 10px 10px;
     }
     .root-1gCeng,
     .footer-2gL1pp {
       background-color: var(--background-primary) !important;
            border: 2px solid #${dbg};
     }
''
