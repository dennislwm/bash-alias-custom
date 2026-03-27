# Varlock + 1Password on macOS: Setup & Fixes

## Prerequisites

This document assumes the following are already in place. If starting from scratch, follow these guides first:

| Requirement | Link |
|-------------|------|
| macOS Big Sur 11.0+ | — |
| 1Password desktop app installed and signed in | https://1password.com/downloads/mac |
| 1Password CLI installed (`brew install 1password-cli`) | https://developer.1password.com/docs/cli/get-started |
| 1Password CLI integrated with desktop app (Touch ID) | https://developer.1password.com/docs/cli/app-integration |
| Varlock `^0.6.0` installed (`brew install varlock`) | https://varlock.dev |
| `.env.schema` initialized (`varlock init`) | https://varlock.dev/env-spec |

Verify the 1Password CLI integration before proceeding:

```bash
op whoami
```

---

## 1. Pin the Plugin to `>= 0.3.0`

In `.env.schema`, ensure the 1Password plugin is pinned to version `0.3.0` or newer:

```env-spec
# @plugin(@varlock/1password-plugin@0.3.0)
```

> **Why:** Versions `0.2.x` export an ESM module (`dist/plugin.js`). Varlock's plugin loader is a Bun binary that evaluates plugins in a CommonJS context (JavaScriptCore), causing:
> ```
> SyntaxError: Unexpected token '{'. import call expects one or two arguments.
> ```
> Version `0.3.0` switched the export to `dist/plugin.cjs`, fixing the issue.

If you have a stale cache from `0.2.x`, clear it:

```bash
rm -rf ~/.config/varlock/plugins-cache/varlock-1password-plugin_0.2*
```

---

## 2. Configure `@initOp` for Desktop App Auth

Use `allowAppAuth=true` alone — do not include `token=$OP_TOKEN` unless `OP_TOKEN` is declared as a schema item:

```env-spec
# @initOp(allowAppAuth=true)
```

> **Why:** If `@initOp` references `$OP_TOKEN` but `OP_TOKEN` is not declared in the schema, Varlock fails with:
> ```
> ref(): invalid dependency: OP_TOKEN
> ```

To restrict app auth to development only (recommended, as it connects with your full personal vault access):

```env-spec
# @initOp(allowAppAuth=forEnv(dev))
```

---

## 3. Resulting `.env.schema`

After applying the above changes and adding secrets from the Varlock vault, the schema looks like this:

```env-spec
# This env file uses @env-spec - see https://varlock.dev/env-spec for more info
#
# @defaultRequired=infer @defaultSensitive=true
# @generateTypes(lang=ts, path=env.d.ts)
# ----------
# @plugin(@varlock/1password-plugin@0.3.0)
# @initOp(allowAppAuth=true)

DB_PASS=op(op://Varlock/DB_PASS/password)
DB_USER=op(op://Varlock/DB_PASS/username)
```

The `op()` resolver takes a secret reference in the format `op://<vault>/<item>/<field>`. To find the correct path for any item, run:

```bash
op item get "<item-title>" --vault <vault-name> --format json
```

Or right-click any field in the 1Password desktop app and select **Copy Secret Reference**.

---

## 4. Load and Validate

```bash
varlock load
```

On first run (or after a session timeout), 1Password will prompt for Touch ID or your password. Subsequent runs within the session are silent.

> **Note:** `op signin` is never required. With `allowAppAuth=true`, the CLI authenticates via the desktop app integration automatically. `op signin` is only used when authenticating with a username and password without desktop app integration.

### Auto-load on every terminal session (Bash)

To have variables available automatically in every new terminal without running `varlock load` manually, add the following to `~/.bash_profile`:

```bash
# Load varlock environment variables
if pgrep -x "1Password" > /dev/null; then
  eval "$(varlock load --format shell)"
else
  echo "[varlock] 1Password is not running — environment variables not loaded. Open 1Password and start a new terminal session." >&2
fi
```

The error is written to stderr rather than failing silently, so it won't pollute command output piped to other tools.

For Zsh, add the same block to `~/.zprofile` instead. macOS terminals open login shells by default, making `~/.zprofile` the correct target — `~/.zshrc` won't run in login shells.

---

## 5. Project-Specific Schemas

Varlock does not automatically merge schemas from multiple directories. Instead, a project schema explicitly imports the global one using `@import()`, then adds its own variables. The global schema's plugin config and `@initOp` carry through — no need to repeat them.

**`~/my-project/.env.schema`** (project-specific):
```env-spec
# @import(~/.env.schema)

# Project-specific vars
API_KEY=op(op://Varlock/my-project/api-key)
```

Precedence rules: imported files are processed first; definitions in the importing file override those in the imported file. Multiple `@import()` calls are supported.

### Manual loading

The `~/.bash_profile` startup script loads the global schema (`~/.env.schema`) on every terminal. Project-specific vars are not included until you manually load the project schema from within the project directory.

```bash
cd ~/my-project
eval "$(varlock load --format shell)"
```

Touch ID will only prompt if the session has expired.

---

## 6. Scoping Access to a Specific Vault (Service Account)

The `allowAppAuth=true` setup in this document authenticates as your personal 1Password account, giving Varlock access to all vaults you can see. This is fine for local development, but is a security concern for shared projects or any environment where least-privilege access matters.

If you need to restrict Varlock to a specific vault — for example, a team vault containing only project secrets — you must use a **1Password service account** instead of desktop app auth. Service accounts are scoped to explicitly chosen vaults at creation time.

> **Enterprise accounts:** Service account creation requires the **Developer** section at your 1Password web portal. On enterprise plans (e.g., IBM), this may be restricted by your admin. If **Developer → Directory** is not visible at your portal, contact your IT team to request service account creation rights. Until then, `allowAppAuth=true` is the only available option.

### Create a vault-scoped service account

At your 1Password portal, go to **Developer → Directory → Create a Service Account**, select the vault(s) to grant access to, and set permissions. Or via CLI (if permitted):

```bash
op service-account create "my-scoped-account" --vault "MyVault:read_items" --raw
```

**Save the token immediately** — it is displayed only once and cannot be retrieved again.

### Store the token securely

Rather than storing the token in plaintext, save it as a 1Password item in a vault accessible via your personal account (Touch ID), then retrieve it dynamically:

```bash
op item create --category=password --title="my-service-account-token" --vault="MyVault" password="<paste-token>"
```

### Update `.env.schema` to use the token

Declare `OP_TOKEN` as a schema item before `@initOp`, retrieving it via `exec()`:

```env-spec
# @type=opServiceAccountToken @sensitive @required
OP_TOKEN=exec('op read "op://MyVault/my-service-account-token/password"')

# @plugin(@varlock/1password-plugin@0.3.0)
# @initOp(token=$OP_TOKEN)
```

This uses Touch ID to fetch the service account token, which then authenticates against the scoped vault — no plaintext anywhere.

### Caveats

**Vault access is immutable.** Permissions, vault access, and environment access cannot be changed after the service account is created. If your vault requirements change, you must create a new service account. Plan scope carefully before creation.

**Restricted vault types.** Service accounts cannot be granted access to Personal, Private, Employee, or default Shared vaults — only explicitly granted custom vaults.

**`OP_TOKEN` must be declared before `@initOp`.** If `@initOp` references `$OP_TOKEN` but `OP_TOKEN` is not declared as a schema item above it, Varlock fails with `ref(): invalid dependency: OP_TOKEN`.

**Enterprise CLI restriction.** Even if you have web portal access to create service accounts, the `op service-account create` CLI command may still return a 403 on enterprise accounts. Create the service account via the web portal instead.

**This also covers CI/CD.** Service accounts are the correct auth method for non-interactive environments (GitHub Actions, etc.) where Touch ID cannot prompt.

---

## Caveats

### `allowAppAuth` connects as your personal account
Desktop app auth authenticates as you — with your full personal vault access. The Varlock docs warn: *"This method is connecting as YOU who likely has more access than a tightly scoped service account."* Use it only for local development and non-production secrets.

### Desktop app must be running
`allowAppAuth=true` requires the 1Password desktop app to be open and unlocked. To temporarily disable app integration without changing your schema:

```bash
OP_BIOMETRIC_UNLOCK_ENABLED=false varlock load
```

### `.env.schema` is safe to commit — `.env` files are not
The schema stores only secret references (`op://...`), not resolved values. Never commit `.env` files containing plaintext secrets.

---

## Reference

| Resource | URL |
|----------|-----|
| Varlock 1Password Plugin docs | https://varlock.dev/plugins/1password |
| Varlock @env-spec specification | https://varlock.dev/env-spec |
| `@varlock/1password-plugin` on npm | https://www.npmjs.com/package/@varlock/1password-plugin |
| 1Password CLI — Get Started (macOS) | https://developer.1password.com/docs/cli/get-started |
| 1Password CLI — Desktop App Integration | https://developer.1password.com/docs/cli/app-integration |
| 1Password Service Accounts — Get Started | https://developer.1password.com/docs/service-accounts/get-started |
