# cloudflare-speed-cli-nix
A Nix flake for **cloudflare-speed-cli**, A CLI for internet speed test via cloudflare.
Original upstream source: [kavehtehrani/cloudflare-speed-cli](https://github.com/kavehtehrani/cloudflare-speed-cli)

> [!IMPORTANT]
> You must have Nix Experimental Features (`flakes` and `nix command`) enabled.
> See the [NixOS Wiki](https://nixos.wiki/wiki/flakes) for instructions on how to enable them.

## Quick Start

Run it instantly without installing:

```bash
nix run github:shtts/cloudflare-speed-cli-nix
```

Or enter a shell with `cloudflare-speed-cli` available:

```bash
nix shell github:shtts/cloudflare-speed-cli-nix
```

---

## Installation

### Step 1: Add to `flake.nix`

1. Add the repository to your `inputs`.
2. Pass `inputs` to your configuration using `specialArgs` (for NixOS) or `extraSpecialArgs` (for Home Manager).

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # 1. Add cloudflare-speed-cli-nix to inputs
    cloudflare-speed-cli-nix.url = "github:shtts/cloudflare-speed-cli-nix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.my-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # 2. Pass inputs to configuration.nix
      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix
        
        # If using Home Manager as a module:
        home-manager.nixosModules.home-manager
        {
          # 3. Pass inputs to home.nix
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.yourname = ./home.nix;
        }
      ];
    };
  };
}
```

### Step 2: Add to Package List

#### NixOS (`configuration.nix`)

```nix
{ pkgs, inputs, ... }: # <-- Ensure 'inputs' is included here

{
  environment.systemPackages = [
    pkgs.git
    pkgs.vim
    
    # Install cloudflare-speed-cli
    inputs.cloudflare-speed-cli-nix.packages.${pkgs.system}.default
  ];
}
```

#### Home Manager (`home.nix`)

```nix
{ pkgs, inputs, ... }: # <-- Ensure 'inputs' is included here

{
  home.packages = [
    # Install cloudflare-speed-cli
    inputs.cloudflare-speed-cli-nix.packages.${pkgs.system}.default
  ];
}
```
