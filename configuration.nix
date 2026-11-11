{ modulesPath, ... }: {
  system.stateVersion = "26.05";
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
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

  boot.initrd.systemd.enable = true;
  boot.initrd.services.lvm.enable = true;

  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = false;

  networking.interfaces.eth0.ipv4.address = [
    {
      address = "172.16.0.169";
      prefixLength = 24;
    }
  ];

  networking.defaultGateway = "172.16.0.1";

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}
