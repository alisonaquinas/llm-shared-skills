# ssh-keygen Installation and Setup

## Overview

ssh-keygen is part of OpenSSH package.

## Platform-Specific Installation

### macOS / Unix

Usually built-in. If missing:

```bash
brew install openssh    # macOS
apt-get install openssh-client  # Linux
```

## Verification

```bash
ssh-keygen -h
which ssh-keygen
```

## Resources

- Manual: man ssh-keygen
- OpenSSH: <https://www.openssh.com/>
