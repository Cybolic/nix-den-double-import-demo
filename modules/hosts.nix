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
  ];

  pro.test-user._.test-host =
    { toHost, fromUser }:
    {
      includes = [
        {
          nixos =
            { pkgs, ... }:
            {
              users.users.${fromUser.name}.packages = [ pkgs.hello ];
            };
        }
      ];
    };

}