{ ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "12px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#282828";
    background_1 = "#1D2021";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    yellow_dark = "#D79921";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    gray = "#a89984";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
      background: ${background_0};
    }

    window#waybar {
      background: #282828;
      border-top: 1px solid #928374;
    }

    tooltip {
      background: ${background_0};
      border: 1px solid ${border_color};
    }

    tooltip label {
      margin: 5px;
      color: ${text_color};
    }

    #workspaces {
      padding-left: 15px;
    }
    #workspaces button {
      color: ${yellow_dark};
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }
    #workspaces button.empty {
      color: ${gray};
    }
    #workspaces button.active {
      color: ${orange};
    }

    #clock {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
      color: ${blue};
    }

    #tray {
      margin-left: 5px;
      margin-right: 5px;
      color: ${text_color};
    }

    #tray menu {
      background: ${background_1};
      border: 1px solid ${border_color};
      padding: 8px;
      color: ${text_color};
    }

    #tray menuitem {
      padding: 1px;
    }

    #pulseaudio, #network, #cpu, #memory, #temperature, #custom-notification {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 10px;
      color: ${text_color};
    }

    #pulseaudio, #language {
      margin-left: 15px;
    }

    #custom-notification {
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: ${text_color};
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }
  '';
}
