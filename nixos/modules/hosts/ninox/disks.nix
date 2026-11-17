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

        # "/mnt/scratch" = {
        #   device = "/dev/disk/by-uuid/4813F8CE35CC8FA0";
        #   fsType = "ext4";
        #   options = [ "nofail" ];
        # };

        # # 7200 RPM HDD
        # "/mnt/bulk" = {
        #   device = "/dev/disk/by-uuid/4813F8CE35CC8FA0";
        #   fsType = "ext4";
        #   options = [
        #     "noauto"
        #     "nofail"
        #     "x-systemd.automount"
        #     "x-systemd.idle-timeout=600"
        #   ];
        # };

        # # 5400 RPM HDD
        # "/mnt/cold" = {
        #   device = "/dev/disk/by-uuid/4813F8CE35CC8FA0";
        #   fsType = "ext4";
        #   options = [
        #     "noauto"
        #     "nofail"
        #     "x-systemd.automount"
        #     "x-systemd.idle-timeout=600"
        #   ];
        # };

        # Spin down both SATA HDDs after 5 minutes
        # services.udev.extraRules = ''
        #   ACTION=="add|change", KERNEL=="sd[a-z]", ENV{ID_SERIAL_SHORT}=="W9A4V73S", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 60 /dev/%k"
        #   ACTION=="add|change", KERNEL=="sd[a-z]", ENV{ID_SERIAL_SHORT}=="WD-WCAV5V972987", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 60 /dev/%k"
        # '';

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
    };
}
