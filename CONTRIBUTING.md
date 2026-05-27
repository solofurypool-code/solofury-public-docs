# Contributing to SoloFury Public Docs

Thanks for your interest in improving this documentation!

This is the **public documentation repository** for [SoloFury](https://solofury.com) — a multi-coin SHA-256 solo mining pool. The repo is docs-only (no production code is published here).

## Ways to contribute

### 🐛 Report a typo or outdated info

Open an [issue](https://github.com/solofurypool-code/solofury-public-docs/issues) describing what you found. Include:
- File path (e.g. `docs/setup-bitaxe.md`)
- What's wrong
- What it should say

### 📝 Suggest a new guide

If you've successfully solo-mined on SoloFury with hardware not yet documented (e.g. Avalon Nano 3S, Goldshell, etc.), open an issue or PR.

### 🌍 Translate documentation

We're particularly interested in translations to:
- 🇯🇵 Japanese
- 🇰🇷 Korean
- 🇨🇳 Chinese (Simplified)
- 🇩🇪 German
- 🇪🇸 Spanish
- 🇷🇺 Russian

Open an issue first to coordinate (avoid duplicate work).

### 🔧 Submit improvements

1. Fork the repo
2. Create a branch: `git checkout -b improve-bitaxe-guide`
3. Make your changes
4. Commit with a clear message: `docs: clarify Bitaxe AsicBoost note`
5. Push and open a Pull Request

## Style guide

- **English first** — primary docs are in English. Translations go in `docs/<lang>/` subdirectories.
- **Plain markdown** — no proprietary extensions. GitHub-flavored markdown only.
- **Code blocks always specify language** — use `bash`, `json`, `yaml`, `c`, etc.
- **Stratum URLs as code** — wrap in backticks: `bch.solofury.com:7070`
- **Wallet examples** — use the documented test address `qqyourwalletaddressgoeshereexample0123456` (operator's own address, safe to reference)

## What NOT to commit

- ❌ Private RPC credentials, API keys, wallet private keys
- ❌ Internal IPs of pool infrastructure (only public hostnames like `*.solofury.com`)
- ❌ AI-generated content without manual review (verify all technical claims)
- ❌ Affiliate links or promotional content for other pools

## Contact

For substantive contributions or partnership inquiries, reach out via [solofury.com/contact](https://solofury.com/contact/).

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
