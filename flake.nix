{
  description = "System-wide Ubuntu packages managed by a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixgl,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nixgl.overlay ];
      };

      # Python environment
      systemPython = pkgs.python313.withPackages (
        ps: with ps; [
          numpy
          matplotlib
        ]
      );

    in
    {
      packages.${system}.default = pkgs.buildEnv {
        name = "system-packages";
        paths = with pkgs; [
          git
          vim
          curl
          wget
          lazygit
          neovim
          clang-tools
          openssh
          nmap
          fd
          feh
          xsel
          ripgrep
          systemPython
          htop
          tree
          ncdu
          uv
          sioyek
          vlc
          gnumake
          gcc
          libgcc
          cargo
          rustc
          terminator
          otpclient
          cachix
          direnv
          vscodium
          podman
          pympress
          kdePackages.okular
        ];
      };
    };
}
