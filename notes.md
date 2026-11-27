# Notes

## What is Nix?

I'm putting the horse before the cart.
Found a solution and am looking for problems to solve.
In the name of learning.

"Nix" is a somewhat overloaded term:

- The Nix package manager.
- The Nix programming language, used by the package manager.
- A build system.
- NixOS, the linux distrubtion built around the package manger.

Not to be confused with *nix, shorthand for Unix-like operating systems.

This introduction will focus on the **Nix package manager**.


## Wait, what's a package manager?

> A package manager is software that supports installing, upgrading, configuring, and removing software for the host system in a consistent manner.

Some examples that you may be familiar with:

- APT (Debian)
- Homebrew (Linux, MacOS)
- WinGet (Windows)


## What makes Nix different to other package managers?

What differentiates Nix is being:

- Reproducible
- Declarative


## Declarative?

- Most package managers are imperative.
- Describe the outcome, not the steps.
- Change of mindset from imperative
- While you can do adhoc commands, `nix-shell -p cowsay`, it is a temporary shell!
- Forces you to configure,  more easily sharable working environment
- Restore a system to a previous state without thinking about the transition process.
- Add cowsay to home

## Reproducible?

- Packages are built in isolation from each other.
- No undeclared dependencies, uninstalling a package cannot break another.
- If a package works on one machine, it will work on another.
- Look at how nix builds packages



## How does it work?

Note: you don't need to follow these steps to use Nix. This is to explain what goes on behind the scences.

1. Build a package
2. Store it in `/nix/store/`

Packages are stored in `/nix/store`


### How are Nix packages built?

See the [set-up guide](set-up-guide.md) if you're going through this later and would like to follow along!

The required parts are:

- [simple.c](examples/derivation/simple.c), the program that we want to package.
- [simple_builder.sh](examples/derivation/simple_builder.sh), the script that will compile our program. Note that in reality, there are generic builders.
- [simple.nix](examples/derivation/simple.nix), the Nix file that describes how to package our program.

#### Higher-level

To build a package:

```bash
nix-build ./examples/derivation/simple.nix
```

#### Lower-level

This is doing the following steps under the hood:


1. Create the derivation from its components:

```bash
nix-instantiate ./examples/derivation/simple.nix

# /nix/store/rxiwsyib03f5ynhj6rah4c5alks1nqkk-simple.drv
```

This creates a our derivation file, formatted and commented [here](./examples/derivation/simple.drv) for convenience:

2. Build the derivation:

```bash
nix-store -r /nix/store/rxiwsyib03f5ynhj6rah4c5alks1nqkk-simple.drv

# /nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-simple
```

3. Symlink the output to `./result/`

You can now run your program!

```bash
/nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-simple/simple

# Or use the symlink:
./result/simple
```

## Reliable?

- Cannot break other packages by uninstalling
- Easy to rollback to previous versions
- Each package version gets its own spot in the nix store
- Look at Nix store `ls -l /nix/store | grep python3`
- Add new version of python (python is a bad example btw)

### The Nix Store

All built packages live inside the read-only `/nix/store/`.

You may have noticed the package we built earlier has a really ugly path.

```
/nix/store/66mva2c1ydjkh4jp9xsmbf5dsaakrrng-simple
```

The hash `66mva2c1ydjkh4jp9xsmbf5dsaakrrng` is calculated based on all the input information.
Any changes to build parameters, dependencies, dependency verions, etc. will change the hash.
This guarantees that:

- Each different build of each package will get its own path in the store.
- A package built with the same inputs will always have the same path.


### Isn't it really slow if you have to build everything everytime?

No, because packages are immutable, we can use binary caches.

The official binary cache for Nixpkgs can be found at https://cache.nixos.org/

## What Problems can it solve?

### Project Specific Dependencies

Scenario: Working on multiple projects that require different versions of the same tools.

Other solutions

- Mise
- Docker

### Declarative Home Environment

- VSCode and extensions
- `home-manager switch --flake ./examples/home-manager`
- Use same setup everywhere
- WSL not always available


### CI/CD


### Server Management

- NixOS: configure the entire system using Nix
- NixOS VM web server
- https://github.com/Gabriella439/nixos-in-production/blob/main/manuscript/WebServer.md

## Why not use Nix?

- High learning 
- Terrible documentation
- Niche functional language

### Comparison to Docker

Nix:

- More reproducible: images are reproducible, build process isn't necessarily, but often that doesn't matter...
- Maybe slightly lighter as no


Docker:

- Isolated: Nix does not isolate, use Docker in Nix
- More easier to learn



## Comparison to other tools (Docker)



## End

Has uses where reproducibility or being able to rollback is very important
90% of the time, there is a more established solution (often Docker)

Thank you for listening, 