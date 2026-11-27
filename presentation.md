# An Introduction to Nix

![bg contain right](images/nix-logo.png)

---


1. Features of Nix
    - Declarative
    - Reproducible
    - Reliable
1. How Nix works
    - Nix shells
    - Packaging a program
    - The Nix store
1. Examples
    - Development environment
    - User environment
    - System configuration
    - CI/CD

---


# What is Nix?

- Package manager?
- Programming language??
- Build system????
- Linux Distribution????????

---


# Wait, what's a package manager?

> A package manager is software that supports installing, upgrading, configuring, and removing software for the host system in a consistent manner.


---


# What makes Nix different?

- Declarative
- Reproducible - 
- Reliable - once it's working, it's hard to break


---


# Declarative?

- Describe the outcome, not the action

---


# Reproducible?

- Packages are built in isolation
- All dependencies are declared

![bg contain right](images/it-works-on-my-computer.png)

---


# Reliable?

- Installing/uninstalling a package cannot break other packages
- Updated packages are not overwritten

---

# Ok, but what is actually useful for?

- Development environments
- User environment (home-manager)
- System configuration (NixOS)
- CI/CD

---


# Just use ~~Docker~~ Podman!

Nix:

- Bit-for-bit reproducability
- Atomic upgrades and rollbacks

Docker:

- Runtime isolation
- More established 

---

![bg contain](images/marge.png)
