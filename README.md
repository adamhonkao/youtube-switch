# YouTube Switch

A one-button Mac app that blocks or allows YouTube for every account on the Mac.
The parent runs it from their admin account; a Standard child account can't undo it.

It adds or removes a marked section in `/etc/hosts`, flushes the DNS cache, and on
block quits Chrome in every other account.

- `src/app.applescript` — the app (status dialog, loops so you can switch back and forth)
- `src/toggle.sh` — the root helper that edits `/etc/hosts`
- `src/icon.py` — draws the icon
- `site/` — the download page, live at https://youtube-switch-mac.netlify.app

## Build and deploy

```
./build.sh
netlify deploy --prod --dir site --site 313d96f1-434c-4eac-9251-276e72bac483
```

The app is ad-hoc signed, not notarized, so the first open needs
System Settings → Privacy & Security → Open Anyway.
