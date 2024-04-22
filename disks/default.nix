{
    mainDiskId ? throw "This must be set to a disk",
    extraDiskIds,
    ...
}: {
    disko = {
      devices = {
        main = {
          device = "/dev/disk/by-id/${mainDiskId}";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                name = "ESP";
                start = "1M";
                end = "128M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap = {
                        swapfile.size = "16G";
                      };
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "subvol=nix" "compress=zstd" "noatime"];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "subvol=persist" "compress=zstd" "noatime"];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}