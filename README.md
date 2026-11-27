# Lunch-and-learn Nix

An introduction to the Nix, a declarative package manager.


## Set-up

Disclaimer: I have only tried this on WSL, not MacOS.

### Windows Subsystem for Linux

Windows only of course.

```ps1
wsl --install --name Ubuntu-26.04
```


### Nix

```bash
# Single-user installation
# https://nixos.org/download/
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon

# Enable experimental features
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Test it
nix shell nixpkgs#cowsay
cowsay "Hello World!"
```


## How Nix works

### Getting Started

Installing a package can be as simple as:

```bash
nix-shell -p cowsay
```

However, packages installed this way are only available in the current shell.
To add packages permanently, see the [home-manager example](examples/home-manager/home.nix).

```bash
home-manager switch --flake ./examples/home-manager
```


### Simple derivation

Example code from https://nixos.org/guides/nix-pills/07-working-derivation.html

The required parts are:

- [simple.c](examples/derivation/simple.c), the program that we want to package.
- [simple_builder.sh](examples/derivation/simple_builder.sh), the script that will compile our program. Note that in reality, there are generic builders.
- [simple.nix](examples/derivation/simple.nix), the Nix file that describes how to package our program.

To build a package:

```bash
nix-build ./examples/derivation/simple.nix
```

This is doing the following steps under the hood:


1. Create the derivation from its components:

```bash
nix-instantiate ./examples/derivation/simple.nix

# /nix/store/rxiwsyib03f5ynhj6rah4c5alks1nqkk-my-simple-derivation.drv
```

This creates a our derivation file, formatted and commented [here](./examples/derivation/simple.drv) for convenience:

2. Build the derivation:

```bash
nix-store -r /nix/store/rxiwsyib03f5ynhj6rah4c5alks1nqkk-my-simple-derivation.drv

# /nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-my-simple-derivation
```

3. Symlink the output to `./result/`

You can now run your program!

```bash
/nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-my-simple-derivation/simple

# Or use the symlink:
./result/simple
```


### Nix Store

All built packages live inside the read-only `/nix/store/`.

You may have noticed the package we built earlier has a really ugly path.

```bash
/nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-my-simple-derivation
```

The hash `66mva2c1ydjkh4jp9xsmbf5dsaakrrng` is calculated based on all the input information.
Any changes to build parameters, dependencies, dependency versions, etc. will change the hash.
This guarantees that:

- Each different build of each package will get its own path in the store.
- A package built with the same inputs will always have the same path.


## Examples

### Development environments

When working on different projects with conflicting dependencies, Nix can create project-specific shells.

```bash
nix develop ./examples/spark-v3

nix develop ./examples/spark-v4
```


### User environments

Home-manager allows configuring a user environment, which can be reused across different devices.

```bash
home-manager switch --flake ./examples/home-manager
```


### Web server configuration

Example code from https://github.com/Gabriella439/nixos-in-production/blob/main/manuscript/WebServer.md

This example runs a NixOS virtual machine that serves an nginx web server.

```bash
cd examples/web-server
WWW="$PWD/www" nix run .
```

http://localhost:8080/


### CI/CD TODO

- Build using Nix, get same output locally, in CI, and on deployment.


## Presentation

```shell
# Build HTML
npx @marp-team/marp-cli@latest presentation.md

# Open in browser
start presentation.html
```


## LLM Use

- Claude was used for research.
- No code or other written content was made using LLMs.


## References

- https://nixos.org/
- https://nixos.org/guides/nix-pills/
- https://nixos-and-flakes.thiscute.world/
- https://github.com/Gabriella439/nixos-in-production/tree/main
