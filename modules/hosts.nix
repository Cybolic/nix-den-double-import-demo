{ den, pro, ... }:
{
  debug = true;

  den.hosts.x86_64-linux.test-host = {
    hostName = "TestHost";
    users.test-user = { };
  };

  den.aspects.test-host.nixos.users.users.test-user = {
    name = "Test User";
    isNormalUser = true;
  };

  den.default.includes = [
    den.aspects.routes
    den._.home-manager
  ];

  den.aspects.test-user.includes = [
    den._.define-user
    (den._.user-shell "zsh")
  ];

  pro.test_user._.for_test-host =
    {
      includes = [
        {
          nixos =
            { pkgs, ... }:
            {
              users.users.${fromUser.name}.packages = [ pkgs.hello ];
            };
          homeManager =
            { pkgs, ... }:
            {
              home.packages = [ pkgs.gnugrep ];
            };
        }
      ];
    };

  den.default.nixos.system.stateVersion = "25.05";
  den.default.homeManager.home.stateVersion = "25.05";

  flake-file.inputs.home-manager.url = "github:nix-community/home-manager/release-25.05";
  flake-file.inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
}
