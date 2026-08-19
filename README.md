# Scotiabank Special Offers — Master Sheet

A single-page reference to every live Scotiabank Canada personal banking promotion,
with the exact qualifying steps, date windows, payout timing, exclusions, and a
source link for each.

**Live site:** https://daveqwerty1007.github.io/scotiabank-offers/

## What's here

| File | Purpose |
|---|---|
| `index.html` | The sheet. Self-contained — no build step, no dependencies. |
| `data/snapshot.json` | Structured baseline of all tracked offers. This is what the bi-weekly check diffs against. |
| `CHANGELOG.md` | Append-only log of what changed at each re-check. Newest entry first. |
| `.nojekyll` | Tells GitHub Pages to serve files as-is. |
| `publish.sh` | One-time setup: creates the repo, pushes, enables Pages. |

## First-time publish

Requires the GitHub CLI, authenticated as you (`gh auth login`):

```sh
cd ~/Code/site
./publish.sh
```

Then the site is live at `https://daveqwerty1007.github.io/scotiabank-offers/`.

## Automated updates

A scheduled Claude task runs on the **1st and 15th of each month at 9:00 AM Toronto**.
Each run:

1. Reads `data/snapshot.json` from this folder as its baseline
2. Re-fetches every Scotiabank offer page listed in it, plus the two offer hub pages
3. Diffs for changed deadlines, dollar amounts, points, rates, spend thresholds,
   fees, exclusions, and payout timing — and for offers that appeared or vanished
4. If nothing changed, reports one line and stops
5. If something changed, rebuilds `index.html`, updates `data/snapshot.json`,
   prepends a `CHANGELOG.md` entry, and writes all three back into this folder

The task **cannot push** — Claude's session GitHub tokens are scoped to
pre-configured repos. After an update lands, publish it yourself:

```sh
cd ~/Code/site && git add -A && git commit -m "Offer update" && git push
```

The sync also requires the Claude desktop app to be running with this folder
connected when the task fires. If it isn't, the run still delivers the updated
files into the conversation — nothing is lost, it just needs a manual drop-in.

## Known gap

The check only looks at the offer URLs in `snapshot.json` plus the two hub pages.
A brand-new promotion published somewhere off those hubs won't be picked up
automatically.

## Caveat

Summaries are condensed from Scotiabank's public pages. The full legal terms on
those pages govern. Not financial advice.
