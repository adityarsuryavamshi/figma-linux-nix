# Figma Linux Nix

This repo provides a bare-bones flake for [Figma-Linux](https://github.com/Figma-Linux/figma-linux).

By bare-bones, I mean installing this flake only creates a `figma-linux-hf` executable which can launch the application. So no desktop items which includes things like icons etc.. Nonetheless you can launch the application using your favorite launcher like rofi, drun and so on.

## Installation

If you're already using flakes in your system, you probably already know what to do. The setup I'm mentioning is for the situation where you haven't completely moved to flakes.   

Add `(builtins.getFlake "github:adityarsuryavamshi/figma-linux-nix").packages.x86_64-linux.default`
in your `configuration.nix` inside `users.user.<username>.packages`, or wherever you typically install packages (Such as if you're using home-manager (though I haven't tested with it)).

Afterwards do the typical thing you do to install packages (like `nixos-rebuild switch` or home-manager equivalent), you should have `figma-linux-hf` available as an executable.


## Why

`figma-linux-hf` (figma linux hotfix) is not intended as a replacement for the official package, but currently a major bug (uneditable text) in figma-linux is fixed in the official repo but is not released a seperate version yet. Due to this, the fix is not yet available in the official nixpkgs. Other option of patching the official version is also not possible since the official version does not build from source.    
Ideally the version in nixpkgs will move to building from source which would be similar to this but creates desktop item entries and so on, so this is just a very short term fix for myself and others who can't use the app for now.

