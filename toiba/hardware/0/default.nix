# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:
let
  name = "flow";
in {
  imports = [ 
    ./hardware-configuration.nix
    ../../common/wifi.nix
    ../../common/bluetooth.nix
    # ./plasma.nix 
    ../../programs/nginx-file-server.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true; 
  };

  networking.interfaces.wlp3s0.useDHCP = true;
}
