{ den, pro, ... }:
{
  debug = true;

  den.hosts.x86_64-linux.test-host = {
    hostName = "TestHost";
    users.test-user = { };
  };

  den.aspects.test-host =
    { host, ... }:
    {
      nixos.users.users.test-user = {
        name = "Test User";
        isNormalUser = true;
      };
    };

  den.default.includes = [
    den.aspects.routes
  ];

  pro.test-user._.test-host =
    { host, user}:
    {
      includes = [
        {
          nixos =
            { pkgs, ... }:
            {
              users.users.${user.name}.packages = [ pkgs.hello ];
            };
        }
      ];
    };
