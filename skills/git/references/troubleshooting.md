# Troubleshooting Reference

---

## Merge Conflicts

### Reading Conflict Markers

```text
<<<<<<< HEAD
your version of the conflicting code
=======
their version of the conflicting code
>>>>>>> feature/user-auth
```

- Everything between `<<<<<<<` and `=======` is what **you** have (HEAD / current branch)
- Everything between `=======` and `>>>>>>>` is what **they** have (branch being merged in)
- Resolution: edit the file to keep what you want, remove all markers

### Resolving Conflicts

```bash
git status                              # see which files have conflicts
# Edit each conflicted file, remove all <<<<, ====, >>>> markers
git add <resolved-file>                 # mark as resolved
git merge --continue                    # complete the merge (opens commit editor)
# Or abort entirely:
git merge --abort                       # restore to pre-merge state
```

**Use VS Code as merge tool (configured on this machine):**

```bash
git mergetool                           # opens each conflicted file in VS Code
# In VS Code, use the conflict resolution buttons: Accept Current | Accept Incoming | Accept Both
```

**Accept all from one side (when you know you want everything from one branch):**

```bash
git checkout --ours <file>              # keep your version
git checkout --theirs <file>            # keep their version
git add <file>
```

### Conflicts During Rebase

Rebase conflicts are similar but resolved one commit at a time:

```bash
# Conflict during rebase — resolve the conflicted file, then:
git add <resolved-file>
git rebase --continue                   # apply next commit

# Or skip the problematic commit:
git rebase --skip

# Or abandon the entire rebase:
git rebase --abort
```

---

## Detached HEAD

A detached HEAD means you're not on any branch — you've checked out a specific commit,
tag, or remote ref directly. Any commits you make won't belong to a branch and can
be "lost" after you switch away.

```bash
# How you end up in detached HEAD:
git checkout v1.0.0                     # checking out a tag
git checkout <sha>                      # checking out a specific commit
git checkout origin/main                # checking out a remote ref

git status                              # shows: "HEAD detached at abc1234"
```

**If you want to commit in detached HEAD state:**

```bash
git switch -c new-branch-name           # create a branch to capture your commits
# Now you're safe to commit
```

**If you accidentally committed in detached HEAD:**

```bash
git log --oneline -5                    # note the SHA of your commits
git switch main                         # switch back (HEAD commits become "orphaned")
git cherry-pick <sha>                   # apply your commits onto main
# or:
git merge <sha>                         # merge the orphaned commits
# or:
git reflog                              # find the SHA, then:
git switch -c recovery-branch <sha>     # create branch at the orphaned tip
```

---

## CRLF / Line Ending Issues (Windows)

`core.autocrlf=true` is set on this machine. Common symptoms:

**Entire file shows as changed even though you didn't edit it:**

```bash
git diff --ignore-space-change          # check if it's whitespace-only
git diff --check                        # show whitespace errors
```

**Spurious CRLF warnings on commit:**

```output
warning: LF will be replaced by CRLF in src/app.js
```

This is normal with `autocrlf=true` — files have CRLF on disk but LF in repo.
To suppress: `git config --global core.safecrlf false`

**Fix for a cross-platform repo:**

1. Set `core.autocrlf=input` on all contributors' machines
2. OR add `.gitattributes` to normalize line endings:

   ```gitattributes
   * text=auto eol=lf
   *.bat text eol=crlf
   ```

3. Normalize existing repo history:

   ```bash
   git add --renormalize .
   git commit -m "chore: normalize line endings"
   ```

---

## "fatal: refusing to merge unrelated histories"

Happens when merging two repos that have no common ancestor (e.g., creating a new
repo on GitHub and trying to pull into an existing local repo).

```bash
git pull origin main --allow-unrelated-histories
# or:
git merge origin/main --allow-unrelated-histories
```

---

## Recovering a Deleted Branch

```bash
# Find the tip SHA via reflog
git reflog | grep <branch-name>
# or:
git reflog --all | grep "checkout: moving from <branch-name>"

git switch -c <branch-name> <sha>       # recreate the branch
```

---

## Accidentally Committed to the Wrong Branch

**Committed to main instead of a feature branch:**

```bash
git log --oneline -3                    # note the SHA of the misplaced commit
git switch -c feature/my-thing          # create the feature branch (stays at same commit)
git switch main
git reset --hard HEAD~1                 # remove commit from main (keep it on feature)
# If main is a shared branch and you've already pushed:
# git revert HEAD to undo safely (don't reset --hard after pushing to shared branch)
```

---

## Force-Push Rejected

```bash
# "rejected (non-fast-forward)" on force-push:
# The remote ref moved since your last fetch — someone else pushed
git fetch origin
git log HEAD..origin/branch --oneline   # see what they pushed
# Option A: incorporate their changes
git rebase origin/branch
git push --force-with-lease
# Option B: override anyway (only if you're sure)
git push --force-with-lease             # safer form -- still checks
```

---

## Large Repository Performance

```bash
# Run garbage collection
git gc                                  # pack loose objects, expire old reflog entries
git gc --aggressive                     # more thorough (slow, run infrequently)

# Set up background maintenance (modern alternative to gc)
git maintenance start                   # enables hourly background maintenance

# Partial clone (fetch only tree + commits, blobs on demand)
git clone --filter=blob:none <url>      # best for large repos; blobs fetched on checkout

# Sparse checkout (only files you need)
git clone --filter=blob:none --sparse <url>
git sparse-checkout init --cone
git sparse-checkout set src/ docs/      # only check out src/ and docs/

# Clean up unreachable objects
git reflog expire --expire=now --all
git gc --prune=now
```

---

## GPG Signing Failures

```bash
# "error: gpg failed to sign the data"
gpg --list-secret-keys                  # check key is present
gpg --list-secret-keys --keyid-format LONG

# Key expired or wrong key configured
git config --global user.signingkey <correct-key-id>

# GPG agent not running (common on Windows after restart)
gpg-connect-agent reloadagent /bye
# or:
gpg-agent --daemon

# Test GPG signing directly
echo "test" | gpg --clearsign

# Temporarily disable signing for a commit
git commit --no-gpg-sign -m "urgent fix"
```

---

## Submodule Issues

**Submodule shows as "modified" with no actual changes:**

```bash
git submodule update                    # restore to superproject's recorded commit
```

**"Fatal: no submodule mapping found in .gitmodules":**

```bash
git submodule sync
git submodule update --init
```

**Submodule directory not empty when adding:**

```bash
git rm --cached <path>                  # remove from index
rm -rf <path>                           # remove from disk
git submodule add <url> <path>          # add fresh
```

---

## Common Error Messages Quick Reference

| Error | Likely Cause | Fix |
| --- | --- | --- |
| `Your local changes would be overwritten by merge` | Uncommitted changes conflict with incoming | `git stash` then pull |
| `error: failed to push some refs` | Remote is ahead | `git pull --rebase` then push |
| `nothing to commit, working tree clean` | Nothing staged | Check `git status`; add files first |
| `fatal: not a git repository` | Not inside a repo | `git init` or `cd` to correct directory |
| `CONFLICT (content): Merge conflict in <file>` | Normal merge conflict | Edit file, resolve markers, `git add` |
| `HEAD detached at <sha>` | On a specific commit, not a branch | `git switch -c <branch>` to capture state |
| `error: cannot lock ref ... already exists` | Stale remote-tracking ref | `git remote prune origin` |
| `Untracked files in the way of merge/rebase` | Untracked file would be overwritten | `git clean -n` to preview, then `-f` |
| `Permission denied (publickey)` | SSH key not loaded | `ssh-add ~/.ssh/id_ed25519` |
| `Authentication failed` | Credential expired or wrong | Clear Windows Credential Manager entry, re-authenticate |
