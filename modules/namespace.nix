{ config, lib, ... }:
{
  # create a sub-tree of provided aspects.
  # the `profile` name is generic, use your own
  # as deep as you like, only that it ends in a provides tree.
  den.aspects.profile.provides = { };
  # expose outside your flake (optional)
  flake.pro = config.den.aspects.profile.provides;
  # setup for reading in modules
  _module.args.pro = config.den.aspects.profile.provides;
  # setup for writing directly to the canopy attribute
  imports = [
    (lib.mkAliasOptionModule [ "pro" ] [ "den" "aspects" "profile" "provides" ])
  ];
}

