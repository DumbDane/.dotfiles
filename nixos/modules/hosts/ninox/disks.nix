{
  flake.modules.nixos.ninox =
    {
      pkgs,
      ...
    }:
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/0b1d7036-749c-4ec5-89ac-65e96c506365";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/4DF3-A62F";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        "/mnt/scratch" = {
          device = "/dev/disk/by-uuid/14099502-93cb-4732-b149-7791433c0093";
          fsType = "ext4";
          options = [ "nofail" ];
        };

        # 7200 RPM HDD
        "/mnt/bulk" = {
          device = "/dev/disk/by-uuid/41fd406a-246e-4cbc-9a59-cfc86fa145d8";
          fsType = "ext4";
          options = [
            "noauto"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=300"
          ];
        };

        # 5400 RPM HDD
        "/mnt/cold" = {
          device = "/dev/disk/by-uuid/b3a3173c-ce87-4432-8d13-7c0eefb12850";
          fsType = "ext4";
          options = [
            "noauto"
            "nofail"
            "x-systemd.automount"
            "x-systemd.idle-timeout=300"
          ];
        };

      };

      # Fast wake from sleep
      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };

      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 16 * 1024;
          options = [ "discard=once" ];
        }
      ];

      # Spin down both SATA HDDs after 5 minutes
      services.udev.extraRules = ''
        ACTION=="add|change", KERNEL=="sd[a-z]", ENV{ID_SERIAL_SHORT}=="W9A4V73S", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 72 /dev/%k"
        ACTION=="add|change", KERNEL=="sd[a-z]", ENV{ID_SERIAL_SHORT}=="WD-WCAV5V972987", RUN+="${pkgs.hdparm}/bin/hdparm -S 72 /dev/%k"
      '';

    };
}
