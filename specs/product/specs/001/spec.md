---
description: Product identity spec for FOI Security — the foundational document every downstream spec traces to.
status: draft
governs: docs/**
domain: product
depends_on: []
superseded_by: null
superseded_reason: null
archived_reason: null
stale_reason: null
---

# FOI Security — Product Spec

## Purpose

FOI Security exists because digital privacy is under real-world attack and existing security advice fails ordinary people. The advice is scattered, jargon-heavy, and hides behind "it depends." FOI Security makes the hard decisions for the user — opinionated, documented, and open source — so that protecting your digital life doesn't require becoming a cryptographer first.

## Audience

```requirements
- id: REQ-00022
  status: active
  source: USR-00008
  text: >
    The primary audience is Georgian-speaking individuals who use digital devices
    daily but have no cybersecurity expertise. They are intelligent adults who lack
    domain knowledge, not people who need to be talked down to.
  verify:
    L5: Human evaluator confirms all content is accessible to a non-technical Georgian speaker.

- id: REQ-00023
  status: active
  source: USR-00007, USR-00014
  text: >
    The product addresses users who face real, active threats: device seizure by
    authorities, state surveillance, SIM swapping, and vendor key escrow. The threat
    model is not theoretical — it is grounded in the Georgian political context where
    police use Cellebrite on seized devices and the "Russian law" enables mass surveillance.
  verify:
    L5: Human evaluator confirms threat scenarios referenced in content match real-world threats the audience faces.

- id: REQ-00024
  status: active
  source: USR-00016
  text: >
    Security trainers are a secondary audience. The product serves as workshop
    material with explicit pedagogical guidance: focus on "why" over "how", respect
    user comfort, never shame.
  verify:
    L5: Human evaluator confirms the trainers section provides actionable pedagogical guidance.
```

## Experience Goals

```requirements
- id: REQ-00025
  status: active
  source: USR-00002
  text: >
    The user never faces a decision they aren't equipped to make. The product
    decides for them. Choices are presented only when the choice genuinely belongs
    to the user (e.g., which DNS provider, not which encryption algorithm).
  verify:
    L5: >
      Human reviews every decision point in every solution page and confirms:
      (a) technical decisions are made by the product, (b) user-facing choices
      are genuine preferences with clear guidance.

- id: REQ-00026
  status: active
  source: USR-00006
  text: >
    After following the guide, the user's daily device experience is not
    meaningfully degraded. Security is sustainable — biometrics stay on,
    convenience features are preserved where safe, and the product explicitly
    rejects paranoid-security that makes devices hateful to use.
  verify:
    L5: >
      Human evaluator who follows the full guide reports that their daily
      workflow is not disrupted and they do not feel compelled to revert changes.

- id: REQ-00027
  status: active
  source: USR-00003
  text: >
    The user understands WHY each recommendation matters — not just what to click.
    Every solution page establishes the problem and risk before presenting the
    solution. The user finishes each page knowing what they're defending against.
  verify:
    L5: >
      Human evaluator can articulate the threat addressed by each solution page
      after reading it, without prior cybersecurity knowledge.

- id: REQ-00028
  status: active
  source: USR-00002, USR-00011
  text: >
    Recommendations are singular and named. The product recommends one tool per
    category (e.g., Bitwarden for passwords, Signal for messaging), not
    comparison lists. Where two options exist (e.g., Bitwarden vs KeePassXC),
    one is the default recommendation with the other as an explicit alternative
    for users who meet stated criteria.
  verify:
    L5: >
      Human reviews every tool recommendation and confirms each category has
      exactly one primary recommendation with clear selection criteria for any alternative.
```

## Aesthetic and Tonal Constraints

```constraints
- id: CON-00029
  status: active
  source: USR-00012
  text: >
    Tone is direct, practical, and honest. No jargon without explanation.
    No condescension. No fear-mongering. But no sugar-coating either — when
    a vendor acts against user interests, say so plainly (e.g., "Microsoft's
    behavior on your device is indistinguishable from a virus").
  verify:
    L5: >
      Human evaluator confirms tone across all pages is direct without being
      hostile, honest without being alarmist, and accessible without being
      patronizing.

- id: CON-00030
  status: active
  source: USR-00006
  text: >
    The product must never make the user feel stupid, ashamed, or overwhelmed.
    The trainers guide principle applies to all content: if something is hard,
    the product acknowledges it. If a user's prior choices were insecure,
    the product fixes them without judgment.
  verify:
    L5: >
      Human evaluator with no cybersecurity background reads the full guide
      and reports they never felt judged or overwhelmed.
```

## Content Principles

```decisions
- id: ADR-00031
  status: active
  text: >
    Opinionated over comprehensive. The product makes one recommendation per
    category rather than presenting options with trade-off analysis.
  rationale: >
    The audience doesn't have the expertise to evaluate trade-offs between
    PBKDF2 and Argon2, or DNS-over-HTTPS vs DNS-over-TLS. Presenting choices
    creates paralysis and increases the chance of doing nothing. The product's
    value is that someone with expertise already made the choice.
  rejected:
    - >
      Comprehensive comparison approach (e.g., "top 5 password managers") —
      rejected because it shifts the decision burden back to the user,
      defeating the core value proposition.
    - >
      Threat-model-dependent recommendations ("if you're an activist, use X;
      if you're casual, use Y") — rejected because the audience can't
      accurately self-assess their threat level, and weaker recommendations
      for "casual" users leave them vulnerable when threats escalate.

- id: ADR-00032
  status: active
  text: >
    Problem → Risk → Solution structure for every topic. Establish the "why"
    before the "what."
  rationale: >
    Users who understand the threat are more likely to complete the steps and
    maintain the practice long-term. Workshop observation showed that users
    who skipped the "why" were more likely to revert changes when they
    encountered friction.
  rejected:
    - >
      Solution-first structure ("just do this") — rejected because it
      produces compliance without understanding, leading to abandonment
      when the solution causes inconvenience.

- id: ADR-00033
  status: active
  text: >
    Georgian language only for the current product. No partial translations
    or bilingual content.
  rationale: >
    The primary audience is Georgian-speaking. Partial translation would
    fragment the content and create maintenance burden. Translation is a
    future project that requires its own spec.
  rejected:
    - >
      Bilingual content with language switcher — rejected for current scope.
      Translation requires consistent terminology decisions that haven't
      been made yet.
```

## Platform and Accessibility

```requirements
- id: REQ-00034
  status: active
  source: USR-00009
  text: >
    The product is a static website built with MkDocs Material, hosted on
    Cloudflare. It must work in any modern browser without JavaScript for
    content reading. The password generator requires JavaScript but verifies
    its own integrity via SHA-256 checksums before executing.
  verify:
    L5: Human confirms all guide content is readable with JavaScript disabled.

- id: REQ-00035
  status: active
  source: USR-00009
  text: >
    The product covers four platforms: Windows, macOS, iOS, Android. Each
    platform has a solutions page and (where supported) an installable
    security policy. Platform-specific content is clearly labeled and
    separated.
  verify:
    L3: >
      Site build validates that every platform referenced in the nav has
      both a solutions page and a policy page (or documented reason for absence).
```

## Privacy Constraints

```constraints
- id: CON-00036
  status: active
  source: USR-00004
  text: >
    The product collects no personally identifiable information. Analytics
    (Plausible) is anonymous and cookie-free. No tracking pixels, no
    affiliate links, no ads. The password generator executes entirely
    client-side — no passwords or wordlists are transmitted to any server.
  verify:
    L3: >
      Automated check confirms no external tracking scripts, no cookies set,
      no outbound requests from the password generator beyond wordlist fetches
      from the same origin.

- id: CON-00037
  status: active
  source: USR-00005
  text: >
    All source code, guides, policies, tools, and wordlists are publicly
    available on GitHub. The project is licensed CC BY-NC-SA 4.0.
    No component may depend on proprietary or closed-source infrastructure
    that would prevent the community from forking and continuing independently.
  verify:
    L3: >
      CI check confirms all assets referenced in the site are present in
      the repository (no external proprietary dependencies).
```

## Scope Boundaries

```nongoals
- id: NONGOAL-00038
  status: active
  text: >
    GUI application for automated system hardening. This is a future product,
    not part of the current guide+tools site.

- id: NONGOAL-00039
  status: active
  text: >
    Cybersecurity RPG game. This is a future product, not part of the
    current guide+tools site.

- id: NONGOAL-00040
  status: active
  text: >
    English translation or multilingual support. Translation requires its
    own spec with terminology decisions. The current product is Georgian only.
```

## Content Structure

The repeating unit is the **solution page**. Each solution page:

1. **Prerequisites** — checklist of what must be completed first (links to other solution pages)
2. **Problem** — what threat or gap this addresses
3. **Risk** — what happens if the user does nothing
4. **Solution** — step-by-step instructions with:
   - Video examples (hosted on security-media.foi.ge)
   - Platform-specific tabs where applicable
   - Bitwarden integration points (where to store generated credentials)
5. **Next steps** — links to the next solution pages in the recommended flow

Solution pages form a directed graph via prerequisites. The recommended entry point is passwords → MFA → OS hardening → mobile → messaging/DNS/VPN.

Supporting content types:
- **Policy pages** — document every parameter in an installable security profile, with rationale
- **Tool pages** — host interactive tools (password generator) with integrity verification
- **Reference pages** — misconceptions, behavior guides, hardware key analysis — no step-by-step instructions, purely informational

## Terminology

| Term | Meaning | Usage |
|------|---------|-------|
| FOI Security Policy | Installable security profile (.mobileconfig or GPO) that configures OS parameters | Always capitalized. Never "security settings" or "configuration." |
| FOI პაროლების გენერატორი | Client-side passphrase generator | Always with "FOI" prefix. |
| FOI Tools | CLI scripts (PowerShell/bash) that automate tasks the policy can't cover | Always with "FOI" prefix. |
| BFU / AFU | Before First Unlock / After First Unlock — device encryption states | Always explain on first use per page. |
| ენტროპია (Entropy) | Password strength measured in bits | Always explain as "სირთულე" (difficulty) for the audience. |
| Recovery Key / აღდგენის გასაღები | Backup decryption key stored in Bitwarden | Always warn about loss consequences on every mention. |

## Success Criteria

```requirements
- id: REQ-00041
  status: active
  source: USR-00002, USR-00006, USR-00007
  text: >
    A non-technical Georgian speaker can follow the guide from passwords
    through OS hardening to completion, on their actual devices, without
    external help, and end up with: (a) a password manager with a strong
    master password, (b) MFA on critical accounts, (c) full-disk encryption
    with keys they control, (d) encrypted DNS, (e) biometric authentication
    still enabled, (f) no vendor key escrow.
  verify:
    L5: >
      Human tester with no cybersecurity background completes the full
      guide on real devices and achieves all six outcomes without assistance.
```

## Sign-off

<!-- Dialectic waived per user direction. -->

| Agent | Role | File | Hash | Confirmation |
|-------|------|------|------|--------------|
| 002-claude-orchestrator (opus) | Author | specs/product/spec.md | — | Direct write, dialectic waived by user |

## Revision history

| Date | Commit | Partner | Change |
|------|--------|---------|--------|
| 2026-04-07 | — | n/a (waived) | Initial draft from INT-00001 |
