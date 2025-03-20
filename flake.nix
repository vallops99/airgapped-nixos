{
  description = "Airgapped NixOS";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  outputs = { self, nixpkgs }: {
    nixosConfigurations.airgapped-iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, modulesPath, ... }: {
          imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
          environment.systemPackages = [ pkgs.sparrow ];

          boot.blacklistedKernelModules =
            let
              modulesFile = builtins.readFile ./blacklist.txt;
              # Filter out empty lines and whitespace
              modulesList = lib.filter
                (x: x != "" && builtins.match "^[ \t]*$" x == null)
                (lib.splitString "\n" modulesFile);
            in modulesList;

          networking.networkmanager.enable = false;

          hardware.bluetooth.enable = false;

          networking.interfaces = {};
          networking.firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
            rejectPackets = true;
          };
        })
      ];
    };
  };
}
