{pkgs, ...} :
let
  # how to move to home.nix and load this
  theme = builtins.fromJSON (builtins.readFile /home/dt/.config/nixpkgs/gruvbox-dark-soft.json);
  color = theme.base0B;
  fg = theme.base00;
  bg = theme.base02;
  mod = "Mod1";

  palette = (background: border: text: childBorder: indicator: {inherit background border text childBorder indicator;});
  keys = (commands: builtins.listToAttrs 
    (map (x: {name = "${mod}+${x}"; value = (builtins.getAttr x commands);}) 
    (builtins.attrNames commands))); # thanks balsoft

  ws = (w: builtins.listToAttrs 
    ((map (x: {name = x; value = "workspace ${builtins.getAttr x w}";}) (builtins.attrNames w)) ++ 
     (map (x: {name = "Shift+${x}"; value = "move container to workspace ${builtins.getAttr x w}";}) (builtins.attrNames w))));  

  countWS = 10; 
  generatedWS = builtins.listToAttrs (map (x: {name = toString x; value = toString x;}) (builtins.genList (x: x) countWS));
in {
  enable = true;
  config = {
    fonts = [ "Terminus 8" ];

/*
    colors = {
      background = bg;
      focused = palette bg color color bg bg;
      focusedInactive = palette bg bg fg bg bg;  
      placeholder = palette bg bg fg bg bg;
      unfocused = palette bg bg fg bg bg;
      urgent = palette color bg bg bg color;
    };
    */
    
    keybindings = keys ({
      "h" = "focus left";
      "j" = "focus down";
      "k" = "focus up";
      "l" = "focus right";

      "Shift+h" = "move left";
      "Shift+j" = "move down";
      "Shift+k" = "move up";
      "Shift+l" = "move right";

      "v" = "split v";
      "Shift+v" = "split h";

      "f" = "fullscreen toggle";
      "r" = "mode resize";
      "Shift+r" = "restart";
      "q" = "kill";
      "space" = "mode_toggle";

      "b" = "exec ${pkgs.chromium}/bin/chromium";
      "d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
      "Return" = "exec ${pkgs.termite}/bin/termite";
    } // ws (generatedWS // {"0" = "10";})); # generate workspace

    modes = {
      resize = {
        "h" = "resize shrink width 10 px or 10 ppt";
        "j" = "resize shrink height 10 px or 10 ppt";
        "k" = "resize grow height 10 px or 10 ppt";
        "l" = "resize grow width 10 px or 10 ppt";
        "Escape" = "mode default";
        "Return" = "mode default";
        "${mod}" = "mode default";
      };
    };

    bars = [{
      fonts = [ "Terminus 8" ];
      "mode" = "dock";
      "position" = "top";
    }];

    startup = [
      { command = "feh --no-fehbg --bg-fill ~/.config/nixpkgs/linear_gradient.png"; }
    ];
  };
} 