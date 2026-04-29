from mkdocs.plugins import event_priority


@event_priority(-200)
def on_config(config):
    """Remove mkdocs-static-i18n's bundled custom sitemap dir so our
    theme/sitemap.xml override wins. The plugin's existence check is
    broken (looks at ./sitemap.xml instead of theme/sitemap.xml)."""
    config.theme.dirs[:] = [d for d in config.theme.dirs if "custom_i18n_sitemap" not in str(d)]
    return config


def on_page_context(context, page, config, nav):
    iso = page.meta.get("git_revision_date_localized_raw_iso_date")
    if iso:
        page.update_date = iso
    return context
