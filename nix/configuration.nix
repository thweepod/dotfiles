# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

#  services.xserver.videoDrivers = ["nvidia"];

#  hardware.nvidia = {
#    modesetting.enable = true;
#    powerManagement.enable = false;
#    powerManagement.finegrained = false;
#    open = false;
#    package = config.boot.kernelPackages.nvidiaPackages.beta;
#  };

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./steam.nix
    ./vim.nix
  ];

  # Boot options
# boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];

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
  services.pulseaudio.enable = false;
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
    extraGroups = ["networkmanager" "wheel" "gamemode" "audio"];
    packages = with pkgs; [
      (pkgs.nnn.override {withNerdIcons = true;})
      (pkgs.wrapOBS {plugins = [pkgs.obs-studio-plugins.obs-vkcapture];})
      discord
      discover-overlay
      #equibop
      go
      google-chrome
      grimblast
      kitty
      playerctl
      gcc
     #legcord
      libopus
      mlocate
      mpv
      mpvScripts.uosc
      openshot-qt
      remmina
      pulseaudio
      samrewritten
      stremio
      vivaldi
      vivaldi-ffmpeg-codecs
      vlc
      yazi
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    alejandra
    nodejs
    btop
    clipse
    dbus
    ffmpeg-full
    git
    hyprpaper
    libnotify
    libratbag
    libva
    keepassxc
    mediawriter
    nix-search-cli
    nixd
    nwg-look
    nushell
    openssh
    pavucontrol
    phinger-cursors
    piper
    protonup
    swappy
    swayosd
    swaynotificationcenter
    tofi
    udiskie
    waybar
    wlogout
    wl-clipboard
    xfce.thunar
   #xwaylandvideobridge
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
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set number
        set cc=80
        set list
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        if &diff
          colorscheme blue
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ctrlp nvim-lspconfig nvim-treesitter nvim-tree-lua];
      };
    };
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # Firefox fix
    MOZ_ENABLE_WAYLAND = 0;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Screensharing

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Fonts

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    iosevka
    nerd-fonts.iosevka
    font-awesome
    font-awesome_5
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    liberation_ttf
    fira-code
    nerd-fonts.fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.proggy-clean-tt
  ];

  # List services that you want to enable:

  hardware.ckb-next.enable = true;
  programs.wshowkeys.enable = true;
  programs.noisetorch.enable = true;
  programs.mtr.enable = true;
  programs.nix-ld.enable = true;
  services.udisks2.enable = true;
  services.sabnzbd.enable = true;
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
