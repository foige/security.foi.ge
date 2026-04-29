import logging
import re
from pathlib import Path

log = logging.getLogger("mkdocs.plugins.translation_check")

GEORGIAN_SCRIPT = re.compile(r"[Ⴀ-ჿⴀ-⴯]")
LANGUAGE_SWITCHER = re.compile(
    r'<a\b[^>]*\bhreflang="ka"[^>]*>.*?</a>', re.DOTALL | re.IGNORECASE
)
HTML_TAG = re.compile(r"<[^>]+>")
WHITESPACE = re.compile(r"\s+")

_checked_sources = False


def on_config(config):
    global _checked_sources
    if _checked_sources:
        return config
    _checked_sources = True

    docs_dir = Path(config.docs_dir)
    project_root = docs_dir.parent

    missing = []

    for md in sorted(docs_dir.rglob("*.md")):
        if md.name.endswith(".en.md"):
            continue
        if not md.with_suffix(".en.md").exists():
            missing.append(("page", md.relative_to(project_root)))

    includes_dir = project_root / "includes"
    if includes_dir.is_dir():
        for md in sorted(includes_dir.rglob("*.md")):
            if md.name.endswith(".en.md"):
                continue
            if not md.with_suffix(".en.md").exists():
                missing.append(("include", md.relative_to(project_root)))

    if missing:
        log.warning(f"{len(missing)} source(s) missing English translation:")
        for kind, path in missing:
            log.warning(f"  [{kind}] {path}")
    else:
        log.info("All sources have English translations")

    return config


def on_post_build(config):
    site_dir = Path(config.site_dir)
    en_dir = site_dir / "en"
    if not en_dir.is_dir():
        return

    leaks = []

    for html_file in sorted(en_dir.rglob("*.html")):
        try:
            text = html_file.read_text(encoding="utf-8")
        except (OSError, UnicodeDecodeError):
            continue

        body_start = text.find("<body")
        if body_start == -1:
            continue
        body = text[body_start:]

        body = LANGUAGE_SWITCHER.sub(" ", body)
        body = HTML_TAG.sub(" ", body)
        body = WHITESPACE.sub(" ", body)

        for match in GEORGIAN_SCRIPT.finditer(body):
            start = max(0, match.start() - 30)
            end = min(len(body), match.end() + 60)
            snippet = body[start:end].strip()
            leaks.append((html_file.relative_to(site_dir), snippet))
            break

    if leaks:
        log.warning(f"Georgian text leaking into {len(leaks)} English page(s):")
        for path, snippet in leaks:
            log.warning(f"  {path}: …{snippet}…")
    else:
        log.info("No Georgian text leaking into English pages")
