# ssh-keygen Troubleshooting

## Common Errors

### "Permission denied"

**Cause:** Private key has wrong permissions (not 600).

**Fix:**

```bash
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### "Corrupted private key"

**Cause:** File damage or wrong format.

**Fix:**

```bash
# Verify format
ssh-keygen -l -f ~/.ssh/id_ed25519

# If corrupted, regenerate
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

### "Passphrase incorrect"

**Cause:** Wrong passphrase entered.

**Fix:**

```bash
# Retry or change passphrase
ssh-keygen -p -f ~/.ssh/id_ed25519
```

## Resources

- Manual: man ssh-keygen
