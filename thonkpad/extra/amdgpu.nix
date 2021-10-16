{ config, pkgs, lib, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver = { 
    videoDrivers = [ "amdgpu" ];
    config = ''
    Section "Device"
	Identifier "AMD"
	Driver "amdgpu"
	Option "TearFree" "true"
	Option "DRI" "3"
	Option "VariableRefresh" "true"
    EndSection
    '';
  };
 }
