#!/bin/sh

nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
sudo umount /dev/sda?*
sudo dd if=./result/iso/nixos-24.05.20241230.b134951-x86_64-linux.iso of=/dev/sda
