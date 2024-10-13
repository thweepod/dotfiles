# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

 # Enable OpenGL
 hardware.graphics = {
   enable = true;
   enable32Bit = true;
};

services.xserver.videoDrivers = ["nvidia"];

hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  powerManagement.finegrained = false;
  open = false;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

   imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./steam.nix
      ./vim.nix
    ];

  # Boot options
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

 
 
 # Enable Pulse/Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tripod = {
    isNormalUser = true;
    description = "tripod";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "audio" ];
    packages = with pkgs; [
      (pkgs.nnn.override { withNerdIcons = true;})
     # (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
      (pkgs.wrapOBS { plugins = [ pkgs.obs-studio-plugins.obs-vkcapture ]; })
      firefox
      discord
      discover-overlay
     # vesktop
      grimblast
      kitty
      openshot-qt
      samrewritten
      stremio
      vlc
  ];
   };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
  btop
  dbus
  git
  libnotify
  libratbag
  libva
  keepassxc
  mako
  nix-search-cli
  openssh
  patchutils
  pavucontrol
  phinger-cursors
  piper
  rofi-wayland
  protonup
  swappy
  swaybg
  veracrypt
  waybar
  wl-clipboard
  xwaylandvideobridge
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.hyprland.enable = true;
  programs.xwayland.enable = true;


  environment.sessionVariables = {
  # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
  # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  # Firefox fix
    MOZ_ENABLE_WAYLAND = 0;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Screensharing

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
  ];
 };

  # Fonts

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    iosevka
    font-awesome
    jetbrains-mono
    liberation_ttf
    fira-code
    fira-code-nerdfont
    fira-code-symbols
    font-awesome
    mplus-outline-fonts.githubRelease
    nerdfonts
    dina-font
    proggyfonts
  ];


  # List services that you want to enable:
   
   hardware.ckb-next.enable = true; 
   programs.wshowkeys.enable = true;
   programs.noisetorch.enable = true; 
   programs.mtr.enable = true;
   programs.nix-ld.enable = true; 
   services.flatpak.enable = true;
   services.ratbagd.enable = true;
   hardware.xone.enable = true;
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
