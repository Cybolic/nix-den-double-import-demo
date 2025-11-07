{ den, pro, lib, ... }:
let
  noop = _: { };

  by-platform-config = { host }:
    (pro.${host.system} or noop) { inherit host; };

  user-provides-host-config = { fromUser, toHost }:
    (pro.${fromUser.aspect}._.${toHost.aspect} or noop) { inherit fromUser toHost; };

  host-provides-user-config = { toUser, fromHost }:
    (pro.${fromHost.aspect}._.${toUser.aspect} or noop) { inherit toUser fromHost; };

  inspectParam = param:
    if lib.isAttrs param then lib.attrNames param
    else "param: ${param}";

  parametricTracing = self: param:
    builtins.trace (inspectParam param) (den.lib.parametric true self param);

in 
{
  # den.aspects.routes.__functor = den.lib.parametric true;
  den.aspects.routes.__functor = parametricTracing;
  den.aspects.routes.includes = [
    user-provides-host-config
    host-provides-user-config
    by-platform-config
  ];
}

