{
  flake.modules.nixos.proxmox-lxc = { modulesPath, ... }: {
    imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];
  };
}
