{lib, ...}: let
  inherit (lib) mapAttrs' nameValuePair removeSuffix;
  inherit (builtins) readDir;
in {
  files = mapAttrs' (
    name: _:
      nameValuePair "ftplugin/${removeSuffix ".nix" name}.lua"
      {
        imports = [./ft/${name}];
      }
  ) (readDir ./ft);
}
