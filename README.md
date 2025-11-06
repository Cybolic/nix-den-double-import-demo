# A minimal reproduction of the double import bug in den

Run:
    $ nix repl --expr "builtins.getFlake \"$PWD\"" --show-trace

and then inspect:
`nixosConfigurations.test-host.config.users.users.test-user.packages`
there'll be two entries for the same `nixpkgs.hello` package.
