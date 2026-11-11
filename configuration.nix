{ modulesPath, ... }: {
  system.stateVersion = "26.05";

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

boot.loader.efi.canTouchEfiVariables = false;

  disko.devices.disk.disk1.device = "/dev/sda";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZk6C/0mp4hzjy2LNdul1ubAP5D/lc5qo3bb+JKp1R9 alice@neonix"
  ];


  boot.initrd.availableKernelModules = [
  "hv_vmbus"
  "hv_storvsc"
  "sd_mod"
  "dm_mod"
  ];

  boot.initrd.services.lvm.enable = true;
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = false;

  networking.interfaces.eth0.ipv4.addresses = [
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
