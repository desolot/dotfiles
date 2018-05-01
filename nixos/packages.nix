{ pkgs, ... }:
{
  environment = {
	systemPackages = with pkgs; [ zsh rofi firefox ];
  };
}
