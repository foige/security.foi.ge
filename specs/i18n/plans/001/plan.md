---
spec: i18n/specs/001
description: Per-file English translation of FOI Security
status: draft
created: 2026-04-07
---

## Exit gate (every phase)

- `uv run mkdocs build` completes without errors
- New `.en.md` file exists and is well-formed markdown
- All changes committed

## Reviewers

| Role | Agent | Model |
|------|-------|-------|
| Reviewer A | — | opus |
| Reviewer B | — | codex |

---

## Phase 0: i18n infrastructure setup

status: done

Set up mkdocs-static-i18n plugin so the site can serve both languages.

### Intent

After this phase, `uv run mkdocs build` produces a site with a language switcher.
Georgian remains the default. English pages appear when `.en.md` files exist.
No content is translated yet — just the infrastructure.

### Key files

- `pyproject.toml` — add `mkdocs-static-i18n` dependency
- `mkdocs.yml` — add i18n plugin config, set default language to `ka`

### Constraints

- Do NOT modify any existing `.md` content files
- Do NOT change the Georgian site's URLs or behavior
- The i18n plugin must be `mkdocs-static-i18n` (ADR-00062)

### Implementation notes

- Plugin config: `default_language: ka`, `languages: {ka: {name: ქართული}, en: {name: English}}`
- Material theme will auto-generate the language switcher
- `uv lock` must be run after adding the dependency

### Tasks

```tasks
- text: Add mkdocs-static-i18n to pyproject.toml dependencies
  builder: 004-claude-build
  commit: phase-0
- text: Configure i18n plugin in mkdocs.yml
  builder: 004-claude-build
  commit: phase-0
- text: Run uv lock && uv run mkdocs build — verify site builds with language switcher
  builder: 004-claude-build
  commit: phase-0
```

### Acceptance criteria

```criteria
- text: Site builds successfully with i18n plugin configured
  traces: [REQ-00057]
  layer: L5
  artifact: mkdocs.yml
- text: Georgian URLs are unchanged from pre-i18n state
  traces: [REQ-00057]
  layer: L5
  artifact: mkdocs.yml
```

---

## Phase 1: includes/device_has_updates.en.md

status: done

### Intent

Translate the "ensure your device receives updates" warning snippet.

### Key files

- `includes/device_has_updates.md` — Georgian original (14L), read fully
- `includes/device_has_updates.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use terminology from spec glossary (specs/i18n/specs/001/spec.md § Terminology Glossary)
- Preserve exact markdown structure (admonition type, formatting)
- No Georgia-specific adaptations needed for this file

### Tasks

```tasks
- text: Read includes/device_has_updates.md fully, create includes/device_has_updates.en.md
  builder: 004-claude-build
  commit: 95abba4
```

### Acceptance criteria

```criteria
- text: English include file exists and mirrors Georgian structure
  traces: [REQ-00058]
  layer: L5
  artifact: includes/device_has_updates.en.md
```

---

## Phase 2: includes/foi_security_policy.en.md

status: done

### Intent

Translate the one-line FOI Security Policy auto-activation note.

### Key files

- `includes/foi_security_policy.md` — Georgian original (1L), read fully
- `includes/foi_security_policy.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "FOI Security Policy" as the product name (spec glossary)

### Tasks

```tasks
- text: Read includes/foi_security_policy.md fully, create includes/foi_security_policy.en.md
  builder: 004-claude-build
  commit: 4200488
```

### Acceptance criteria

```criteria
- text: English include file exists and mirrors Georgian structure
  traces: [REQ-00058]
  layer: L5
  artifact: includes/foi_security_policy.en.md
```

---

## Phase 3: includes/mobile_biometrics.en.md

status: done

### Intent

Translate the biometric authentication recommendation snippet.

### Key files

- `includes/mobile_biometrics.md` — Georgian original (14L), read fully
- `includes/mobile_biometrics.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Biometric Authentication" per glossary
- Preserve all material icons and formatting

### Tasks

```tasks
- text: Read includes/mobile_biometrics.md fully, create includes/mobile_biometrics.en.md
  builder: 004-claude-build
  commit: 840fe8f
```

### Acceptance criteria

```criteria
- text: English include file exists and mirrors Georgian structure
  traces: [REQ-00058]
  layer: L5
  artifact: includes/mobile_biometrics.en.md
```

---

## Phase 4: includes/password_paper_storage.en.md

status: done

### Intent

Translate the password paper storage warning snippet.

### Key files

- `includes/password_paper_storage.md` — Georgian original (16L), read fully
- `includes/password_paper_storage.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Password Manager" and "Master Password" per glossary

### Tasks

```tasks
- text: Read includes/password_paper_storage.md fully, create includes/password_paper_storage.en.md
  builder: 004-claude-build
  commit: d6c4ab2
```

### Acceptance criteria

```criteria
- text: English include file exists and mirrors Georgian structure
  traces: [REQ-00058]
  layer: L5
  artifact: includes/password_paper_storage.en.md
```

---

## Phase 5: includes/windows_edition_change.en.md

status: done

### Intent

Translate the Windows edition change instructions snippet.

### Key files

- `includes/windows_edition_change.md` — Georgian original (58L), read fully
- `includes/windows_edition_change.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Preserve all code blocks, video references, and UI element names (English UI names like "File Explorer", "Properties" stay as-is)

### Tasks

```tasks
- text: Read includes/windows_edition_change.md fully, create includes/windows_edition_change.en.md
  builder: 004-claude-build
  commit: 5c41ad1
```

### Acceptance criteria

```criteria
- text: English include file exists and mirrors Georgian structure
  traces: [REQ-00058]
  layer: L5
  artifact: includes/windows_edition_change.en.md
```

---

## Phase 6: docs/index.en.md

status: done

### Intent

Translate the homepage.

### Key files

- `docs/index.md` — Georgian original (36L), read fully
- `docs/index.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Preserve the "we decide for you" messaging (REQ-00025)
- No Georgia-specific content in this file

### Tasks

```tasks
- text: Read docs/index.md fully, create docs/index.en.md
  builder: 004-claude-build
  commit: b3ae822
```

### Acceptance criteria

```criteria
- text: English homepage mirrors Georgian structure and conveys the "we decide for you" value proposition
  traces: [REQ-00053, REQ-00054, REQ-00056]
  layer: L5
  artifact: docs/index.en.md
```

---

## Phase 7: docs/solutions/index.en.md

status: done

### Intent

Translate the solutions landing page.

### Key files

- `docs/solutions/index.md` — Georgian original (47L), read fully
- `docs/solutions/index.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Preserve Problem / Risk / Solution structure explanation

### Tasks

```tasks
- text: Read docs/solutions/index.md fully, create docs/solutions/index.en.md
  builder: 004-claude-build
  commit: e3f5175
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/index.en.md
```

---

## Phase 8: docs/solutions/passwords.en.md

status: done

### Intent

Translate the password manager guide — the longest and most critical solution page.

### Key files

- `docs/solutions/passwords.md` — Georgian original (560L), read fully
- `docs/solutions/passwords.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Password Manager", "Master Password", "Entropy (password strength)", "Brute-force" per glossary
- Preserve all Bitwarden configuration tables exactly
- Video references: keep links, add note that video is in Georgian
- Preserve all admonition types and markdown formatting

### Tasks

```tasks
- text: Read docs/solutions/passwords.md fully, create docs/solutions/passwords.en.md
  builder: 004-claude-build
  commit: 721fb1f
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all configuration tables preserved
  traces: [REQ-00053, REQ-00054, REQ-00056]
  layer: L5
  artifact: docs/solutions/passwords.en.md
```

---

## Phase 9: docs/solutions/mfa.en.md

status: done

### Intent

Translate the multi-factor authentication guide.

### Key files

- `docs/solutions/mfa.md` — Georgian original (126L), read fully
- `docs/solutions/mfa.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Multi-factor Authentication (MFA)" per glossary — not "two-factor"
- Video references: keep links, add note that video is in Georgian

### Tasks

```tasks
- text: Read docs/solutions/mfa.md fully, create docs/solutions/mfa.en.md
  builder: 004-claude-build
  commit: 7347b90
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, uses MFA terminology consistently
  traces: [REQ-00053, REQ-00054, REQ-00056]
  layer: L5
  artifact: docs/solutions/mfa.en.md
```

---

## Phase 10: docs/solutions/windows.en.md

status: done

### Intent

Translate the Windows configuration guide.

### Key files

- `docs/solutions/windows.md` — Georgian original (395L), read fully
- `docs/solutions/windows.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Security Chip (TPM)", "Recovery Key", "Data Encryption", "Ramdisk" per glossary
- Windows UI element names are already English — preserve as-is
- Video references: keep links, add note that video is in Georgian
- The "Microsoft is not your friend" section tone must match Georgian directness (CON-00029)

### Tasks

```tasks
- text: Read docs/solutions/windows.md fully, create docs/solutions/windows.en.md
  builder: 004-claude-build
  commit: 7bb7338
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, Windows-specific terminology correct
  traces: [REQ-00053, REQ-00054, REQ-00056]
  layer: L5
  artifact: docs/solutions/windows.en.md
```

---

## Phase 11: docs/solutions/macos.en.md

status: done

### Intent

Translate the macOS configuration guide.

### Key files

- `docs/solutions/macos.md` — Georgian original (283L), read fully
- `docs/solutions/macos.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Recovery Key", "Data Encryption" per glossary
- macOS UI element names are already English — preserve as-is
- Video references: keep links, add note that video is in Georgian

### Tasks

```tasks
- text: Read docs/solutions/macos.md fully, create docs/solutions/macos.en.md
  builder: 004-claude-build
  commit: a5c5a54
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054, REQ-00056]
  layer: L5
  artifact: docs/solutions/macos.en.md
```

---

## Phase 12: docs/solutions/ios.en.md

status: done

### Intent

Translate the iOS configuration guide.

### Key files

- `docs/solutions/ios.md` — Georgian original (58L), read fully
- `docs/solutions/ios.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- iOS UI element names are already English — preserve as-is

### Tasks

```tasks
- text: Read docs/solutions/ios.md fully, create docs/solutions/ios.en.md
  builder: 004-claude-build
  commit: 421f847
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/ios.en.md
```

---

## Phase 13: docs/solutions/android.en.md

status: done

### Intent

Translate the Android configuration guide.

### Key files

- `docs/solutions/android.md` — Georgian original (95L), read fully
- `docs/solutions/android.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Biometric Authentication", "Brute-force" per glossary
- Android UI element names are already English — preserve as-is

### Tasks

```tasks
- text: Read docs/solutions/android.md fully, create docs/solutions/android.en.md
  builder: 004-claude-build
  commit: e86dac3
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/android.en.md
```

---

## Phase 14: docs/solutions/messaging.en.md

status: done

### Intent

Translate the secure messaging (Signal) guide.

### Key files

- `docs/solutions/messaging.md` — Georgian original (95L), read fully
- `docs/solutions/messaging.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Signal UI element names are already English — preserve as-is

### Tasks

```tasks
- text: Read docs/solutions/messaging.md fully, create docs/solutions/messaging.en.md
  builder: 004-claude-build
  commit: d425b40
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/messaging.en.md
```

---

## Phase 15: docs/solutions/dns.en.md

status: done

### Intent

Translate the encrypted DNS guide.

### Key files

- `docs/solutions/dns.md` — Georgian original (196L), read fully
- `docs/solutions/dns.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Encrypted DNS" per glossary
- Preserve all IP addresses, URLs, and technical configuration values exactly

### Tasks

```tasks
- text: Read docs/solutions/dns.md fully, create docs/solutions/dns.en.md
  builder: 004-claude-build
  commit: 1c85197
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all technical values preserved
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/dns.en.md
```

---

## Phase 16: docs/solutions/vpn.en.md

status: done

### Intent

Translate the VPN guide. Has Georgia-specific content per divergence registry.

### Key files

- `docs/solutions/vpn.md` — Georgian original (44L), read fully
- `docs/solutions/vpn.en.md` — English translation to create
- `specs/i18n/specs/001/spec.md` § Divergence Registry — required reading

### Constraints

- Read the full Georgian file before writing anything
- DIVERGENCE: Remove Georgia-specific latency reasoning (50-60ms). Keep Germany recommendation for privacy law and Mullvad-owned servers.

### Tasks

```tasks
- text: Read docs/solutions/vpn.md fully, create docs/solutions/vpn.en.md with divergence applied
  builder: 004-claude-build
  commit: 5b2e463
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure with documented divergence applied
  traces: [REQ-00053, REQ-00054, CON-00060]
  layer: L5
  artifact: docs/solutions/vpn.en.md
```

---

## Phase 17: docs/solutions/antivirus.en.md

status: done

### Intent

Translate the antivirus guide.

### Key files

- `docs/solutions/antivirus.md` — Georgian original (66L), read fully
- `docs/solutions/antivirus.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything

### Tasks

```tasks
- text: Read docs/solutions/antivirus.md fully, create docs/solutions/antivirus.en.md
  builder: 004-claude-build
  commit: 0c6413f
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/antivirus.en.md
```

---

## Phase 18: docs/solutions/misconceptions.en.md

status: done

### Intent

Translate the cybersecurity misconceptions page.

### Key files

- `docs/solutions/misconceptions.md` — Georgian original (111L), read fully
- `docs/solutions/misconceptions.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Biometric Authentication" per glossary

### Tasks

```tasks
- text: Read docs/solutions/misconceptions.md fully, create docs/solutions/misconceptions.en.md
  builder: 004-claude-build
  commit: 9addc91
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/misconceptions.en.md
```

---

## Phase 19: docs/solutions/behavior.en.md

status: done

### Intent

Translate the general security behavior guide. Has Georgia-specific content per divergence registry.

### Key files

- `docs/solutions/behavior.md` — Georgian original (81L), read fully
- `docs/solutions/behavior.en.md` — English translation to create
- `specs/i18n/specs/001/spec.md` § Divergence Registry — required reading

### Constraints

- Read the full Georgian file before writing anything
- DIVERGENCE: Generalize Georgian protest/detention context to "high-risk situations" without Georgian specifics. The BFU/AFU advice is universal.

### Tasks

```tasks
- text: Read docs/solutions/behavior.md fully, create docs/solutions/behavior.en.md with divergence applied
  builder: 004-claude-build
  commit: d285212
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure with documented divergence applied
  traces: [REQ-00053, REQ-00054, CON-00060]
  layer: L5
  artifact: docs/solutions/behavior.en.md
```

---

## Phase 20: docs/solutions/hardware-keys.en.md

status: done

### Intent

Translate the hardware security keys analysis page.

### Key files

- `docs/solutions/hardware-keys.md` — Georgian original (198L), read fully
- `docs/solutions/hardware-keys.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "Security Chip (TPM)", "Biometric Authentication" per glossary

### Tasks

```tasks
- text: Read docs/solutions/hardware-keys.md fully, create docs/solutions/hardware-keys.en.md
  builder: 004-claude-build
  commit: 32843b1
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact: docs/solutions/hardware-keys.en.md
```

---

## Phase 21: docs/policies/index.en.md

status: not-started

### Intent

Translate the FOI Security Policy landing page.

### Key files

- `docs/policies/index.md` — Georgian original (31L), read fully
- `docs/policies/index.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Use "FOI Security Policy" as product name per glossary

### Tasks

```tasks
- text: Read docs/policies/index.md fully, create docs/policies/index.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 22: docs/policies/windows.en.md

status: not-started

### Intent

Translate the Windows security policy documentation — the most detailed policy page.

### Key files

- `docs/policies/windows.md` — Georgian original (1054L), read fully
- `docs/policies/windows.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Registry paths, DWORD values, and policy names are English — preserve exactly
- Translate only the Georgian explanation text for each parameter

### Tasks

```tasks
- text: Read docs/policies/windows.md fully, create docs/policies/windows.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all registry paths and values preserved exactly
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 23: docs/policies/macos.en.md

status: not-started

### Intent

Translate the macOS security policy documentation.

### Key files

- `docs/policies/macos.md` — Georgian original (295L), read fully
- `docs/policies/macos.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Policy parameter names are English — preserve exactly
- Translate only the Georgian explanation text

### Tasks

```tasks
- text: Read docs/policies/macos.md fully, create docs/policies/macos.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all policy parameter names preserved
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 24: docs/policies/ios.en.md

status: not-started

### Intent

Translate the iOS security policy documentation.

### Key files

- `docs/policies/ios.md` — Georgian original (179L), read fully
- `docs/policies/ios.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Policy parameter names are English — preserve exactly
- Translate only the Georgian explanation text

### Tasks

```tasks
- text: Read docs/policies/ios.md fully, create docs/policies/ios.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all policy parameter names preserved
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 25: docs/policies/browser.en.md

status: not-started

### Intent

Translate the browser security policy documentation.

### Key files

- `docs/policies/browser.md` — Georgian original (326L), read fully
- `docs/policies/browser.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Chrome/Brave/Firefox policy names and paths are English — preserve exactly
- Translate only the Georgian explanation text and tab labels

### Tasks

```tasks
- text: Read docs/policies/browser.md fully, create docs/policies/browser.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all policy paths preserved
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 26: docs/tools/password-generator/index.en.md

status: not-started

### Intent

Translate the password generator page. The generator JS is already bilingual — only the page text needs translation.

### Key files

- `docs/tools/password-generator/index.md` — Georgian original (222L), read fully
- `docs/tools/password-generator/index.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Preserve all HTML, JavaScript references, and SHA-256 checksums exactly
- The JS code and CSS are shared — do not duplicate or modify them

### Tasks

```tasks
- text: Read docs/tools/password-generator/index.md fully, create docs/tools/password-generator/index.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure, all script/checksum references preserved
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 27: docs/about/index.en.md

status: not-started

### Intent

Translate the about page. Has Georgia-specific content per divergence registry.

### Key files

- `docs/about/index.md` — Georgian original (58L), read fully
- `docs/about/index.en.md` — English translation to create
- `specs/i18n/specs/001/spec.md` § Divergence Registry — required reading

### Constraints

- Read the full Georgian file before writing anything
- DIVERGENCE: Remove სირცხვილია partnership reference
- DIVERGENCE: Generalize "Russian law" origin to "laws restricting digital privacy and freedom of expression"
- DIVERGENCE: Keep Digital Defenders mention and Matrix chat link

### Tasks

```tasks
- text: Read docs/about/index.md fully, create docs/about/index.en.md with divergences applied
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure with documented divergences applied
  traces: [REQ-00053, REQ-00054, CON-00060]
  layer: L5
  artifact:
```

---

## Phase 28: docs/about/tos.en.md

status: not-started

### Intent

Translate the terms of service page. Has Georgia-specific content per divergence registry.

### Key files

- `docs/about/tos.md` — Georgian original (104L), read fully
- `docs/about/tos.en.md` — English translation to create
- `specs/i18n/specs/001/spec.md` § Divergence Registry — required reading

### Constraints

- Read the full Georgian file before writing anything
- DIVERGENCE: Remove სირცხვილია partnership credit
- DIVERGENCE: Keep founder name, drop Georgian activism framing

### Tasks

```tasks
- text: Read docs/about/tos.md fully, create docs/about/tos.en.md with divergences applied
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure with documented divergences applied
  traces: [REQ-00053, REQ-00054, CON-00060]
  layer: L5
  artifact:
```

---

## Phase 29: docs/about/privacy.en.md

status: not-started

### Intent

Translate the privacy policy page.

### Key files

- `docs/about/privacy.md` — Georgian original (51L), read fully
- `docs/about/privacy.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- No Georgia-specific content in this file

### Tasks

```tasks
- text: Read docs/about/privacy.md fully, create docs/about/privacy.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 30: docs/about/trainers.en.md

status: not-started

### Intent

Translate the trainers guide.

### Key files

- `docs/about/trainers.md` — Georgian original (67L), read fully
- `docs/about/trainers.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything
- Pedagogical principles are universal — translate directly

### Tasks

```tasks
- text: Read docs/about/trainers.md fully, create docs/about/trainers.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Phase 31: docs/guide/prerequisites.en.md

status: not-started

### Intent

Translate the prerequisites page (currently not in nav but exists in docs).

### Key files

- `docs/guide/prerequisites.md` — Georgian original (42L), read fully
- `docs/guide/prerequisites.en.md` — English translation to create

### Constraints

- Read the full Georgian file before writing anything

### Tasks

```tasks
- text: Read docs/guide/prerequisites.md fully, create docs/guide/prerequisites.en.md
  builder:
  commit:
```

### Acceptance criteria

```criteria
- text: English file mirrors Georgian structure
  traces: [REQ-00053, REQ-00054]
  layer: L5
  artifact:
```

---

## Sign-off

| Agent | Role | File | Hash | Confirmation |
|-------|------|------|------|--------------|
| 002-claude-orchestrator (opus) | Author | specs/i18n/plans/001/plan.md | — | Direct write, dialectic waived by user |

## History

| Date | Phase | Agent | Partner | Commit | Change |
|------|-------|-------|---------|--------|--------|
| 2026-04-07 | all | 002-claude-orchestrator | n/a (waived) | — | Initial plan — 32 phases (1 infra + 31 per-file translation) |
