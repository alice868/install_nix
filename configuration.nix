{ modulesPath, ... }: {
  system.stateVersion = "26.05";
  imports = [
    (modulesPath + "/profile/qemu-guest.nix")
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  disko.devices.disk.disk1.device = "/dev/sda";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZk6C/0mp4hzjy2LNdul1ubAP5D/lc5qo3bb+JKp1R9 alice@neonix"
  ];
}
