{
  description = "System-wide Ubuntu packages managed by a flake";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Python environment
      systemPython =
        pkgs.python312.withPackages (ps: with ps; [ numpy matplotlib ]);

    in {
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
        ];
      };
    };
}

