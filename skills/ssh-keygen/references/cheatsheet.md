# ssh-keygen Cheatsheet

## Safe defaults

- Prefer `ed25519` for general-purpose keys.
- Keep private keys mode `600`.
- Keep public keys mode `644`.

## Key operations

1. Generate key

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
```

1. Print fingerprint

```bash
ssh-keygen -lf ~/.ssh/id_ed25519.pub
```

1. Validate private key

```bash
ssh-keygen -y -f ~/.ssh/id_ed25519 >/dev/null
```
