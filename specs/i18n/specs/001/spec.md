---
description: English translation of the FOI Security site — full mirror with Georgia-specific adaptations.
status: draft
governs: docs/**/*.en.md
domain: content
depends_on:
- spec: product
  provides: audience, tone, content structure, terminology
superseded_by: null
superseded_reason: null
archived_reason: null
stale_reason: null
---

# English Translation

Required reading: [Product Spec](../../product/specs/001/spec.md)

## Purpose

Make FOI Security accessible to English-speaking users worldwide. The English version
is a structural mirror of the Georgian original — same pages, same flow, same opinionated
approach. Georgia-specific content is removed or adapted, with every such change
explicitly recorded.

## Requirements

```requirements
- id: REQ-00053
  status: active
  source: USR-00043
  text: >
    Every page in the Georgian site has a corresponding English translation.
    No page is excluded.
  verify:
    L3: >
      CI script enumerates all docs/*.md files (excluding .en.md) and verifies
      a corresponding .en.md file exists for each.

- id: REQ-00054
  status: active
  source: USR-00044
  text: >
    English pages mirror the structure of their Georgian counterpart: same
    headings, same section order, same prerequisite links. Structural
    divergence is only permitted where a Georgia-specific section is removed,
    and the removal is recorded in the divergence registry.
  verify:
    L3: >
      Linter compares heading structure of each .md / .en.md pair and flags
      unrecorded divergences.

- id: REQ-00055
  status: active
  source: USR-00045
  text: >
    All English content is AI-generated and human-reviewed. No AI-generated
    translation goes live without human approval.
  verify:
    L5: >
      Human reviewer confirms each translated page before it is merged.

- id: REQ-00056
  status: active
  source: USR-00048
  text: >
    English translation preserves the tone defined in the product spec
    (CON-00029, CON-00030): direct, practical, honest, no jargon without
    explanation, no condescension, no sugar-coating. Tonal parity with
    the Georgian original, not just factual accuracy.
  verify:
    L5: >
      Human reviewer evaluates tone of each translated page against
      product spec tonal constraints.

- id: REQ-00057
  status: active
  source: USR-00047
  text: >
    Translation uses mkdocs-static-i18n plugin with file suffix approach.
    Georgian files remain at their current paths (e.g., passwords.md).
    English files are created alongside them (e.g., passwords.en.md).
    Georgian is the default language.
  verify:
    L5: >
      Site builds and serves both languages. Language switcher appears.
      Georgian URLs are unchanged from pre-translation state.

- id: REQ-00058
  status: active
  source: USR-00049
  text: >
    Include-markdown files in includes/ each have an English variant
    (e.g., device_has_updates.en.md). English pages include the English
    variants.
  verify:
    L3: >
      CI script verifies every includes/*.md has a corresponding .en.md,
      and no .en.md page references a Georgian include.

- id: REQ-00059
  status: active
  source: USR-00051
  text: >
    A terminology glossary is established before translation begins.
    Every domain term used across multiple pages has one canonical English
    equivalent. Translators reference this glossary; the linter flags
    inconsistencies.
  verify:
    L3: >
      Terminology linter checks all .en.md files for glossary term
      consistency (no synonyms for the same concept across pages).
```

## Constraints

```constraints
- id: CON-00060
  status: active
  source: USR-00046
  text: >
    Georgia-specific content must not appear in the English version without
    adaptation. Every removal or adaptation is recorded in the divergence
    registry with the original content and rationale.
  verify:
    L3: >
      CI script checks that no known Georgia-specific markers appear in
      .en.md files (see divergence registry for the marker list).

- id: CON-00061
  status: active
  source: USR-00044
  text: >
    No structural additions in the English version. English pages must not
    contain sections, recommendations, or tools that don't exist in the
    Georgian original. Translation is a mirror, not a fork.
  verify:
    L3: >
      Heading-structure linter flags any heading in .en.md that has no
      counterpart in the corresponding .md file.
```

## Decisions

```decisions
- id: ADR-00062
  status: active
  text: >
    File suffix approach (passwords.en.md) over directory approach (en/passwords.md).
  rationale: >
    Current Georgian file paths stay unchanged — no broken links, no redirects.
    Translation can proceed page by page. Untranslated pages don't appear in
    English nav rather than showing Georgian fallback (which would confuse
    English-only readers).
  rejected:
    - >
      Directory approach (en/, ka/) — rejected because it requires moving all
      existing Georgian files, breaking all current URLs and git history.
    - >
      Separate mkdocs instances per language — rejected because it duplicates
      config, theme, and assets, creating maintenance burden.

- id: ADR-00063
  status: active
  text: >
    Video examples in English pages link to the same Georgian-language videos
    with a note that the video is in Georgian but the steps match the
    written instructions.
  rationale: >
    Re-recording all videos in English is out of scope and would delay
    translation indefinitely. The written step-by-step instructions are
    the primary content; videos are supplementary.
  rejected:
    - >
      Remove video sections from English pages — rejected because the videos
      still demonstrate the UI flow, which is language-agnostic (OS settings
      UIs are typically in the user's own language anyway).
    - >
      Subtitle the videos — rejected as disproportionate effort for
      supplementary content.

- id: ADR-00064
  status: active
  text: >
    CLI tool menu items (Georgian transliterated, e.g., "PIN Kodit Shesvlis
    Idzuleba") are not translated as part of this spec. The English docs
    reference the existing tool output as-is.
  rationale: >
    CLI tool internationalization is a software change, not a content
    translation. It requires its own spec. The transliterated menu items
    are readable enough for step-by-step following.
  rejected:
    - >
      Translate CLI tools as part of this spec — rejected because it mixes
      software and content domains.
```

## Non-goals

```nongoals
- id: NONGOAL-00065
  status: active
  text: >
    Internationalization of CLI tools (foi_tools.cmd, foi_tools.sh).
    These have Georgian transliterated menus. Tool i18n requires a
    separate software spec.

- id: NONGOAL-00066
  status: active
  text: >
    Video re-recording or subtitling in English. Videos are supplementary
    to written instructions.

- id: NONGOAL-00067
  status: active
  text: >
    Support for languages other than Georgian and English.
```

## Divergence Registry

Every Georgia-specific removal or adaptation in the English version is recorded here.
This registry is the canonical record — CON-00060 requires it.

| Page | Georgian content | English treatment | Rationale |
|------|-----------------|-------------------|-----------|
| about/index.md | სირცხვილია partnership reference | Remove | Georgia-specific civil society org, not meaningful to international audience |
| about/index.md | "Russian law" origin narrative | Generalize: "created in response to laws restricting digital privacy and freedom of expression" | The motivation is universal; the specific law is Georgian context |
| about/index.md | Digital Defenders funding mention | Keep | International org, relevant globally |
| about/tos.md | სირცხვილია partnership credit | Remove | Same as above |
| about/tos.md | "გიორგი ლუბარეცი, აქტივისტი" Georgia-specific framing | Keep name, drop location-specific context | Founder identity is relevant; Georgian activism framing is not |
| solutions/vpn.md | German servers recommended for Georgia latency (50-60ms) | Remove latency reasoning. Keep Germany recommendation for privacy law and owned servers. | Latency argument is Georgia-specific; privacy and ownership arguments are universal |
| about/index.md | Matrix chat link with Georgian context | Keep | Matrix is international |
| solutions/behavior.md | Georgian protest/detention context | Generalize to "high-risk situations" without Georgian specifics | The BFU/AFU advice is universal; the arrest scenario framing can be generalized |

## Terminology Glossary

Canonical English terms for concepts used across multiple pages. All .en.md files must use
these exact terms.

| Georgian | English | Notes |
|----------|---------|-------|
| პაროლების მენეჯერი | Password Manager | |
| მრავალბიჯიანი აუთენტიფიკაცია | Multi-factor Authentication (MFA) | Not "two-factor" — the guide covers scenarios with 3 factors |
| მონაცემთა შიფრაცია | Data Encryption | Not "disk encryption" (which is a subset) |
| აღდგენის გასაღები | Recovery Key | Always capitalized |
| უსაფრთხოების ჩიპი | Security Chip (TPM) | Spell out TPM on first use per page |
| ენტროპია / სირთულე | Entropy (password strength) | Always parenthetical explanation on first use |
| სისტემური პროფილი | Security Policy / System Profile | "FOI Security Policy" when referring to the product |
| დაშიფრული DNS | Encrypted DNS | |
| ბიომეტრიული აუთენტიფიკაცია | Biometric Authentication | |
| მთავარი პაროლი | Master Password | Bitwarden context |
| დროებითი საცავი | Ramdisk | Windows context only |
| ბრუტფორსი | Brute-force | Hyphenated |

## Translation Scope

Full inventory of files requiring translation:

**Solution pages** (12 files):
passwords.md, mfa.md, windows.md, macos.md, ios.md, android.md,
messaging.md, dns.md, vpn.md, antivirus.md, misconceptions.md,
behavior.md, hardware-keys.md

**Policy pages** (4 files):
policies/index.md, policies/windows.md, policies/macos.md,
policies/ios.md, policies/browser.md

**Tool pages** (1 file):
tools/password-generator/index.md

**About pages** (4 files):
about/index.md, about/tos.md, about/privacy.md, about/trainers.md

**Other** (3 files):
index.md, guide/prerequisites.md, solutions/index.md

**Includes** (5 files):
device_has_updates.md, foi_security_policy.md, mobile_biometrics.md,
password_paper_storage.md, windows_edition_change.md

**Total: 29 content files + 5 includes = 34 files**

## Sign-off

| Agent | Role | File | Hash | Confirmation |
|-------|------|------|------|--------------|
| 002-claude-orchestrator (opus) | Author | specs/i18n/specs/001/spec.md | — | Direct write, dialectic waived by user |

## Revision history

| Date | Commit | Partner | Change |
|------|--------|---------|--------|
| 2026-04-07 | — | n/a (waived) | Initial draft from INT-00042 |
