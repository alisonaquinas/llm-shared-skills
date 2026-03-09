# ssh-keygen Advanced Usage

## Key Generation Options

```bash
# Ed25519 (recommended)
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "passphrase" -C "comment"

# RSA (legacy)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "comment"

# ECDSA
ssh-keygen -t ecdsa -b 256 -f ~/.ssh/id_ecdsa
```

## Key Conversion

```bash
# Export to different format
ssh-keygen -p -N "" -m pem -f ~/.ssh/id_ed25519

# Extract public key from private
ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/id_ed25519.pub
```

## Key Validation

```bash
# Fingerprint
ssh-keygen -lf ~/.ssh/id_ed25519.pub

# Visual fingerprint (randomart)
ssh-keygen -lv ~/.ssh/id_ed25519.pub

# Check key type
ssh-keygen -l -f ~/.ssh/id_ed25519
```

## Resources

- Manual: man ssh-keygen
