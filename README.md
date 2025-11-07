# A minimal reproduction of the double import bug in den

Run:

```console
nix eval --override-input den github:vic/den/deps --refresh .#.nixosConfigurations.test-host.config.users.users.test-user.packages
```