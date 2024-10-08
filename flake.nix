{
  description = "Flake for Figma Linux";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {

      packages.x86_64-linux.default = pkgs.buildNpmPackage rec {
        pname = "figma-linux-hf";
        version = "0.11.5";

        src = pkgs.fetchFromGitHub {
          owner = "Figma-Linux";
          repo = "figma-linux";
          rev = "v${version}";
          hash = "sha256-9b2nLxPCqqNwPVcIhY1EKg215F4aPHQ35TbmZQ3t+Qs=";
        };

        npmDepsHash = "sha256-FqgcG52Nkj0wlwsHwIWTXNuIeAs7b+TPkHcg7m5D2og=";

        nativeBuildInputs = [ pkgs.copyDesktopItems ];

        dontNpmBuild = true;

        buildPhase = ''
          runHook preBuild

          npm i
          npm run build

          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p $out/node_modules
          mkdir -p $out/bin
          cp -r node_modules/* $out/node_modules
          cp package.json $out/package.json
          cp -r dist/* $out

          echo "${pkgs.electron}/bin/electron $out/main/main.js --enable-features=UseOzonePlatform --ozone-platform=wayland \"\$@\""  > $out/bin/figma-linux-hf
          chmod +x $out/bin/figma-linux-hf

          runHook postInstall
        '';

        env = { ELECTRON_SKIP_BINARY_DOWNLOAD = 1; };

        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "figma-linux-hf";
            desktopName = "Figma Linux HF";
            exec = "figma-linux-hf %U";
            terminal = false;
            startupWMClass = "figma-linux-hf";
            type = "Application";
            mimeTypes = [ "x-scheme-handler/figma" "application/figma" ];
          })
        ];

      };

    };
}
