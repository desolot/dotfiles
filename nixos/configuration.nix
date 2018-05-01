# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
  [
      	./hardware-configuration.nix # Include results of the hardware scan.
	./packages.nix # Include package list and program configs.
  ];

  # https://bugzilla.kernel.org/show_bug.cgi?id=110941
  boot.kernelParams = [ "intel_pstate=no_hwp" ];

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  # Use the GRUB 2 boot loader.
  boot.loader = {
	grub.enable = true;
  	grub.version = 2;
  	grub.device = "nodev";
  	grub.efiSupport = true;
  	efi.canTouchEfiVariables = true;
	grub.gfxmodeEfi = "1366x768";
  };

  boot.initrd.luks.devices = [
    	{
      		name = "root";
      	device =	 "/dev/disk/by-uuid/0bae8df6-b3e5-486d-9020-503b50e6eae6";
      	preLVM = true;
      	allowDiscards = true;
    	}
  ];

  # Networking
  networking={
    	usePredictableInterfaceNames = false;
    	networkmanager.enable = true;
  };

  # timeZone
  time.timeZone = "UK/London";

  # Dekstop Environment
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.windowManager = {
    	i3 = {
      		enable = true;
      		package = pkgs.i3-gaps;
    	};
    	default = "i3";
  };

  programs = {
	zsh = {
		enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
	};
  };

  # User configuration
  users = {
	users.adam = {
    	  	isNormalUser = true;
    	  	home = "/home/adam";
    	  	description = "Adam Moneim";
    	  	extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.zsh; 
	};
  };
}
