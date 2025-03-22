# Airgapped NixOS live #
Very simple NixOS configuration to create an airgapped live USB.   
My usecase: Sparrow wallet 

## How to use it ##
Steps:
- setup your user in configuration.nix:
- - choose the packages you need;
- - create the hashed password with `mkpasswd -m sha-512`;
- blacklist your machine kernel modules:
- - use `lshw -c network`, `lshw -c communication` to find drivers used for Wi-Fi, Ethernet and Bluetooth;
- - double check your drivers and who uses them by `lsmod | grep <driver_name>`;
- - add the ones you found and feel should be blacklisted into hardware-configuration.nix `blacklistedKernelModules` list;
- find your USB stick with `lsblk`;
- format the stick if necessary (I usally go with `gparted`);
- build the configuration and flash your USB `sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake './#airgapped' --disk main /dev/sda`;
- Enjoy your new NixOS airgapped live.


## Issues ##
I haven't been able to make it run in a qemu vm, it freezes on "Booting from disk..." and the command show a warning about raw format.   
