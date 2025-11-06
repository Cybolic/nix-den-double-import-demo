{ den, pro, lib, ... }:
let
  noop = _: { };

  by-platform-config = { host, ... }:
    pro.${host.system} or noop;

  user-provides-host-config = { user, host }:
    pro.${user.aspect}._.${host.aspect} or noop;

  host-provides-user-config = { user, host }:
    pro.${host.aspect}._.${user.aspect} or noop;

  route = locator: { user, host }@ctx: 
    (locator ctx) ctx;
in 
{
  den.aspects.routes.__functor = den.lib.parametric true;
  den.aspects.routes.includes = 
    map route [
      user-provides-host-config
      host-provides-user-config
      by-platform-config
    ];
}

