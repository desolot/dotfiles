# User profile Configuration style template 
# Password still needs to be added using passwd <username> as root

{ config, pkgs, ... }:

{
  imports = [ # Import other *.nix files.

  ];

  # User profile configuration.
  users.users = {
	<username> = {
		isSystemUser = <boolean>; # Set user as system user i.e. UID < 500
    	  	isNormalUser = <boolean>; # Set user as "real" user. Sets group = users i.e. UID > 1000, isSystemUser to false, createHome = true, home = /home/<username>, useDefaultShell = true.
		uid = <integer>; # Set UID. null = automatically assigned value.
		createHome = <boolean>; # Create home directory for user.
    	  	home = "<home directory>"; # Specify home directory.
    	  	description = "<Profile description>"; # Description of user profile.
		group = "<group>"; # Define user group.
    	  	extraGroups = [ "<group>" ]; # Set additional users groups i.e. "wheel" allows sudo access, "networkmanager" allows editing network config, etc.
		openssh.authorizedKeys.keys = [ "<ssh private Key>" ]; # Set user ssh key.
		shell = pkgs.<shell>;  # Set user shell.

		packages = [ # Set packages avaliable to single user.
			"<package1>" 
			"<package2>" 
		];
	};
  };
}

