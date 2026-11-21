# Lunch-and-learn Nix

An introduction to the Nix package manager

![alt text](docs/images/nix-logo.png)

---

## What is Nix?

- Package Manager?
- Programming Language??
- Linux Distribution????

Nix is all of these, but we will focus on the Nix **Package Manager**.

---

### Wait, what's a package manager?

> A package manager is software that supports installing, upgrading, configuring, and removing software for the host system in a consistent manner.

Examples:
- APT (Debian)
- Homebrew (Linux, MacOS)
- WinGet (Windows)

---

## What makes Nix different?

- Reproducible
- Declarative

---

### Reproducible?

- Packages are built in isolation from each other
- No undeclared dependencies, uninstalling a package cannot break another
- If a package works on one machine, it will work on another

![alt text](docs/images/it-works-on-my-computer.png)

---

### Declarative?

- Describe the outcome, not the steps
- Restore a system to a previous state without thinking about the transition process
- Harder to forget one-off commands or configuration changes

---

## How does it work?

1. Create derivation
2. 

Packages are stored in `/nix/store`

```
/nix/store/b6gvzjyb2pg0kjfwrjmg1vfhh54ad73z-firefox-33.1/
```

`b6gvzj...` is a cryptographic hash of the package's dependency build graph.

---

## Isn't it really slow if you have to build everything?

Cache binaries

---

## Why use Nix? What problems does it solve?

---

## Why not use Nix?

---

## Comparison to other tools (Docker)

---

## Simple flake

---

## Overlay

---

## Nix Develop

---

## Docker example

# References

- https://nixos.org/
- https://nixos.org/guides/nix-pills/
- https://nixos-and-flakes.thiscute.world/
