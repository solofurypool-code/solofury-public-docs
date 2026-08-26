# SoloFury — Multi-Coin SHA-256 Solo Mining Pool

> **Multi-coin SHA-256 solo mining pool · BTC/BCH/BC2/BCH2/XEC · 9 global regions · Stratum V2 on BTC · 1% fee · 99% direct-to-wallet · No KYC**

Official public documentation for [**SoloFury**](https://solofury.com) — a non-custodial multi-coin solo mining pool with truly global stratum infrastructure across 9 regions on 5 continents.

---

## What is SoloFury?

SoloFury is a multi-coin SHA-256 solo mining pool that supports five cryptocurrencies on a single platform:

- **Bitcoin (BTC)**
- **Bitcoin Cash (BCH)**
- **Bitcoin II (BC2)**
- **Bitcoin Cash II (BCH2)**
- **eCash (XEC)**

Solo mining means **one miner wins the entire block reward** when a block is found — no shared rewards, no pool payout schemes. Block rewards flow directly from the blockchain to the miner's wallet via the coinbase transaction.

- ✅ **1% pool fee** (verifiable on-chain in every block's coinbase)
- ✅ **99% direct-to-wallet payout** via coinbase transaction
- ✅ **No registration, no custody, no KYC** — your wallet address is your account
- ✅ **9 global stratum regions** — sub-50ms latency from most populated regions worldwide
- ✅ **Stratum V2 in production on BTC** — encrypted end-to-end, coinbase verifiable from your own miner
- ✅ **In development since 2024, publicly launched January 2026** — production-tested, transparent operator

### Why multi-coin matters

Most solo mining pools support a single coin (typically BTC). SoloFury is among the few production-grade solo pools that supports **5 SHA-256 cryptocurrencies natively** with dedicated stratum endpoints for each. This lets miners switch between coins by simply changing the stratum URL — same hardware, same wallet (per coin), same worker configuration. When BTC odds feel out of reach with a Bitaxe, you can switch to BC2 or XEC and find blocks in days instead of decades, without buying any new hardware.

---

## Global Server Infrastructure

SoloFury operates **9 stratum server regions** across 5 continents:

| Region | Location | Country | Hostname Prefix |
|--------|----------|---------|-----------------|
| 🇺🇸 USA East | Atlanta, GA | United States | (default, no prefix) |
| 🇺🇸 USA West / Pacific Northwest | Seattle, WA | United States | `pnw-` |
| 🇩🇪 Europe Continental | Frankfurt | Germany | `eu-` |
| 🇬🇧 United Kingdom | London | United Kingdom | `uk-` |
| 🇮🇱 Middle East | Tel Aviv | Israel | `me-` |
| 🇿🇦 Africa | Johannesburg | South Africa | `afr-` |
| 🇧🇷 LATAM | São Paulo | Brazil | `lat-` |
| 🇸🇬 Asia Southeast | Singapore | Singapore | `asia-` |
| 🇯🇵 Asia East | Tokyo | Japan | `jp-` |

Each region provides low-latency stratum endpoints serving miners in its surrounding geography.

**Total: 45 V1 stratum endpoints** (9 regions × 5 coins), plus TLS on every port and **18 Stratum V2 endpoints** on BTC (9 regions × 2 ports).

### Geographic coverage

SoloFury's deployment spans **5 continents** — North America, South America, Europe, Asia and Africa — making it one of the most geographically diverse solo mining infrastructures publicly available. Most competing solo pools operate from 1-3 regions concentrated in North America or Europe.

This matters because stratum mining performance is bound by **physical network latency** — every millisecond of round-trip time contributes to stale share probability. The wider the regional footprint, the more miners can connect to a server within their continent rather than crossing oceanic backbones.

Miners in Oceania are served from Singapore or Tokyo at roughly 100-200ms; there is no local region there yet.

See [reference/stratum-endpoints.md](reference/stratum-endpoints.md) for the complete list.

---

## Quick Start

### 1. Choose your coin

Pick any of the 5 supported SHA-256 cryptocurrencies. With Bitaxe-class hardware (~1 TH/s), lower-difficulty chains (BCH, BC2, BCH2, XEC) give realistic odds of finding a block in days-weeks. BTC requires industrial hashrate to be statistically meaningful.

### 2. Choose your nearest region

Use the [Solo Start configurator](https://solofury.com/start/) — it auto-detects your location via IP geolocation and recommends the nearest stratum server instantly (no permission popup).

Or manually pick from the [stratum endpoints reference](reference/stratum-endpoints.md).

### 3. Configure your miner

| Setting | Value |
|---------|-------|
| **URL** | `stratum+tcp://<region>-<coin>.solofury.com:<port>` |
| **Username** | Your wallet address |
| **Worker** | Any name (e.g. `bitaxe1`, `s21plus-rack3`) |
| **Password** | `x` (or anything — not used for auth) |

Example for BCH mining from Europe:
```
URL:      stratum+tcp://eu-bch.solofury.com:7070
Username: bitcoincash:qpyouraddressgoeshereexamplenotvalid12345.bitaxe1
Password: x
```

Mining BTC with V2-capable firmware? Use `stratum2+tcp://eu-btc.solofury.com:3333` instead — see [Stratum V2](#stratum-v2) below.

See hardware-specific setup guides:

- [Bitaxe / NerdMiner](docs/setup-bitaxe.md)
- [NerdQAxe](docs/setup-nerdqaxe.md)
- [Antminer S21+ / S21 Pro / S21 Hyd](docs/setup-antminer-s21.md)
- [Antminer S19 / S19j Pro / S19 XP](docs/setup-antminer-s19.md)
- [Whatsminer M-series](docs/setup-whatsminer.md)
- [cgminer / bfgminer software setup](docs/setup-cgminer.md)

### 4. Find a block

When your miner finds a valid block, the SHA-256 puzzle solution is submitted upstream. The block reward is paid directly to your wallet via the coinbase transaction — **no payout request, no minimum threshold, no intermediary balance**.

The 1% pool fee is split off as a second output in the same coinbase transaction (verifiable on-chain).

---

## Why solo mining?

| | Solo Mining | Traditional Pool |
|--|-------------|------------------|
| **Block reward** | 99% to you (1% pool fee) | Split among hundreds of miners |
| **Variance** | High — long dry stretches followed by full blocks | Low — small frequent payouts |
| **Custody** | Non-custodial (direct coinbase) | Pool holds your earnings |
| **KYC** | None (wallet is your account) | Often required |
| **Best for** | Hobbyists, lottery seekers, decentralization advocates | Pure expected-value optimizers |

Solo mining isn't gambling — it's a statistically valid strategy with the **same expected value** as pool mining, just with higher variance. See [SoloFury Blog: Mining Variance & Poisson Math](https://solofury.com/blog/mining-variance-poisson-math/) for the math.

---

## Pool Features

### Free real-time alerts

SoloFury operates a free Telegram bot ([@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot)) that provides instant notifications for:

- **Block found** — get notified the moment one of your workers wins a block, with full block height + reward details
- **Worker offline** — alert when any of your registered workers stops submitting shares for more than 5 minutes
- **Worker reconnected** — confirmation when a previously offline worker comes back online

No subscription, no premium tier, no ads. Most solo pools either don't offer this feature at all or charge for it.

### Stratum V2

SoloFury has served **Stratum V2** in production since 24 August 2026, across all nine regions — one of the very few solo pools to offer it at all.

- **Ports 3333** (standard) and **3343** (high-difficulty, S21/S23 class), on the same hosts as V1
- **Noise-encrypted end-to-end** — the pool's authority public key lets your miner verify cryptographically that it is really talking to SoloFury, the same trust model as an SSH host key
- **Coinbase verification from your own hardware** — with an extended channel and coinbase decoding enabled, the miner displays the block outputs *before* hashing them, so you can confirm the 99% is addressed to your wallet rather than take our word for it

V2 and V1 share the same hosts, so a mixed fleet points at one address with nothing to reconfigure.

**V2 is BTC only.** The stack talks to the node through Bitcoin Core's IPC mining interface, and no other SHA-256 chain implementation currently exposes an equivalent. BCH, BC2, BCH2 and XEC remain on Stratum V1 with full version-rolling support.

Requires firmware with native V2 support — **Braiins OS+ 26.07+**, **AxeOS 2.14+**, or **NerdQAxe firmware 1.0.37+**. Stock Bitmain, stock WhatsMiner, VNish and LuxOS are V1-only, including the S21 and S23.

We do **not** offer job declaration: the pool still builds the block templates. If miner-side transaction selection is what you need, Braiins Pool and DEMAND provide it.

See [reference/stratum-endpoints.md](reference/stratum-endpoints.md#stratum-v2-btc-only) for the full configuration reference.

### TLS stratum

All five coins and all nine regions accept **TLS-encrypted stratum** connections. TLS ports are the plain port with a `1` prefix — BCH 7070 → 17070, BTC 6060 → 16060, and so on. Plain TCP remains available on the original ports; TLS is opt-in.

### Mining achievements & gamification

SoloFury's dashboard tracks miner milestones across multiple dimensions:

- **First share submitted** — celebrate the start of your mining journey
- **Best share difficulty** — track your luckiest share ever (your closest call to a block)
- **Longest mining streak** — uptime tracking across days, weeks, months
- **Blocks found** — historical record of every block won

These per-wallet achievements add a meaningful long-term progression layer to solo mining, beyond the basic real-time statistics offered by most pools.

### Rental hashpower friendly

SoloFury accepts connections from major hashrate rental marketplaces including [NiceHash](https://nicehash.com) and [Mining Rig Rentals (MRR)](https://miningrigrentals.com). This makes it possible to spike effective hashrate temporarily during favorable network conditions (e.g., difficulty drops on smaller chains) without permanent hardware investment.

See [SoloFury Blog: MRR Hashrate Rental for Solo Mining](https://solofury.com/blog/mrr-hashrate-rental/) for strategy and ROI math.

## Documentation Index

### Setup Guides ([docs/](docs/))

- [Bitaxe Solo Mining Setup](docs/setup-bitaxe.md) — Bitaxe Gamma 1.2 TH, Ultra 500 GH
- [NerdQAxe Setup](docs/setup-nerdqaxe.md) — NerdQAxe 2.4 TH, NerdOCTAxe
- [Antminer S21+ Setup](docs/setup-antminer-s21.md) — S21+, S21 Pro, S21 Hyd
- [Antminer S19 Setup](docs/setup-antminer-s19.md) — S19, S19j Pro, S19 XP
- [Whatsminer Setup](docs/setup-whatsminer.md) — M30S++, M50/M53, M60/M63
- [cgminer / bfgminer Software Setup](docs/setup-cgminer.md) — CPU/GPU/ASIC software

### Reference ([reference/](reference/))

- [Complete Stratum Endpoints List](reference/stratum-endpoints.md) — V1, TLS and Stratum V2 endpoints for all 9 regions
- [API Reference](reference/api-reference.md) — `/api/pool`, `/api-<coin>/client/:addr`, network endpoints
- [Technical FAQ](reference/faq.md) — Common questions, troubleshooting, edge cases

### Scripts ([scripts/](scripts/))

- [test-stratum-connection.sh](scripts/test-stratum-connection.sh) — Test stratum connectivity to any region/coin

---

## Verifiable on-chain transparency

Unlike custodial mining pools where payouts depend on trust in the operator, SoloFury's payout mechanism is **directly verifiable on the blockchain**.

Every block mined by SoloFury produces a coinbase transaction with exactly **2 outputs**:

- **Output 0** — solver wallet (99% of block reward)
- **Output 1** — pool fee wallet (1% of block reward)

You can audit any SoloFury-mined block on any block explorer to confirm the fee split. There is:

- **No off-chain accounting** — no internal ledger that could be manipulated
- **No minimum payout threshold** — your reward arrives the moment the block confirms
- **No pool wallet holding miner funds** — coins flow directly from coinbase → your wallet
- **No payout request needed** — payment is automatic via blockchain protocol

This is the same trust model as solo mining without a pool — except SoloFury provides the stratum infrastructure, block construction, and network connectivity so you don't have to run your own full node.

With **Stratum V2** you can go one step further and verify the split *before* you spend any hashrate on the block: an extended channel with coinbase decoding shows the outputs on the miner itself.

## Open Source Components

SoloFury's stratum infrastructure builds on the excellent CKPool codebase:

- **BCH pool** uses [skaisser/ckpool](https://github.com/skaisser/ckpool) (CkPool fork focused on Bitcoin Cash — multi-coin support and CashAddr parser fixes by [Shirleyson Kaisser](https://github.com/skaisser))
- **BTC/BC2/BCH2 pools** use the same [skaisser/ckpool](https://github.com/skaisser/ckpool) fork with shared binary
- **XEC pool** uses [Bitcoin-ABC/ecash-ckpool-solo](https://github.com/Bitcoin-ABC/ecash-ckpool-solo) with patched fee routing
- **Stratum V2 (BTC)** uses [blitzpool](https://blitzpool.yourdevice.ch/) by warioishere, built on the Stratum V2 Reference Implementation (SRI) codecs — the same developer wrote the V2 clients in ESP-Miner (Bitaxe) and the NerdQAxe firmware, which is why those clients work smoothly against it

We do not publish operator-specific config files (RPC credentials, wallet keys), but document deployment patterns and operational lessons learned in production at scale.

### Production hardening

SoloFury's deployment includes several technical refinements developed in production:

- **CashAddr parser fix** for Bitcoin Cash — handles edge cases that cause silent reward misdirection in stock CKPool when miners use bare CashAddr without the `bitcoincash:` prefix
- **Multi-coin coinbase generation** — single binary supports BTC, BCH, BC2, and BCH2 with consistent signature handling and proper segwit witness commitment per chain
- **eCash fee routing patch** — custom donation address routing for XEC, compliant with Bitcoin ABC's 58/42 split (solver/minerfund + staking)
- **Variable difficulty (vardiff)** — automatic share difficulty adjustment based on connected miner hashrate, eliminating the need for manual config per worker
- **AsicBoost / BIP320 version-rolling** — stratum extension support for ~13% effective hashrate gain on modern ASICs
- **Multiprocess Bitcoin Core for Stratum V2** — the V2 stack requires the `bitcoin-node` multiprocess binary to expose the IPC mining interface; the monolithic `bitcoind` silently ignores `ipcbind` and logs only an unknown-config warning

These modifications are derived from publicly available upstream forks; operator-specific configuration (wallet addresses, RPC endpoints, regional deployment topology) is kept private for security.

---

## Performance Notes

### TCP optimization (applied across all 9 regions)

- **BBR congestion control** + **fq qdisc** (Linux 4.9+ kernel)
- **Aggressive TCP keepalive**: 60s (default 7200s) — reduces stratum reconnect latency
- **Large TCP buffer sizes** for long-RTT cross-region connections
- **NIC offload disabled** (`gro off`, `lro off`) — reduces stratum jitter on virtualized NICs

These optimizations bring stratum RTT jitter (`mdev`) down to ~0.05ms — meaningfully reducing stale share probability.

### Latency from typical regions

| Miner location | Nearest SoloFury region | Approximate RTT |
|----------------|-------------------------|-----------------|
| New York, USA | Atlanta | < 30ms |
| London, UK | London | < 30ms |
| Berlin, Germany | Frankfurt | < 30ms |
| Singapore, SG | Singapore | < 30ms |
| Tokyo, JP | Tokyo | < 30ms |
| Seoul, KR | Tokyo | ~ 30ms |
| Hong Kong, HK | Tokyo | ~ 60ms |
| Tel Aviv, IL | Tel Aviv | < 30ms |
| São Paulo, BR | São Paulo | < 30ms |
| Sydney, AU | Singapore | ~ 100ms |

### Stratum V2 and MTU

V2 handshake messages are larger than V1's and can fragment on network paths with PPPoE, double NAT or a VPN where path MTU discovery is broken. If a V2 session drops repeatedly or never completes its handshake, **lower the miner's network MTU to 1400** — this is by far the most common cause.

---

## Trust Signals

- ✅ **1% fee verifiable on-chain** — every SoloFury block has a 2-output coinbase: 99% solver, 1% pool. Block [948592](https://blockchair.com/bitcoin-cash/block/948592) is one such example.
- ✅ **No custody** — block rewards go directly to your wallet via coinbase, never touching pool wallets
- ✅ **Transparent operator** — based in Rome, Italy. Direct contact via [solofury.com/contact](https://solofury.com/contact/)
- ✅ **MiningPoolStats listing** with full block history
- ✅ **Wikidata entity** [Q140569039](https://www.wikidata.org/wiki/Q140569039) — verifiable knowledge-graph identity
- ✅ **Open source upstream** — all stratum code derived from publicly available [skaisser/ckpool](https://github.com/skaisser/ckpool) fork and [blitzpool](https://blitzpool.yourdevice.ch/) for Stratum V2
- ✅ **Free Telegram notifications** for block-found and worker-offline alerts

---

## Resources

- 🌐 **Website**: [solofury.com](https://solofury.com)
- 📊 **Pool Dashboard**: [solofury.com/pool/](https://solofury.com/pool/)
- ⚙️ **Solo Start Configurator**: [solofury.com/start/](https://solofury.com/start/)
- ⚡ **Stratum V2 setup guide**: [solofury.com/guides/stratum-v2-connect/](https://solofury.com/guides/stratum-v2-connect/)
- 📚 **Blog & Guides**: [solofury.com/blog/](https://solofury.com/blog/) · [solofury.com/guides/](https://solofury.com/guides/)
- 🐦 **Twitter**: [@SoloFuryPool](https://x.com/SoloFuryPool)
- 💬 **Contact**: [solofury.com/contact/](https://solofury.com/contact/)
- 🤖 **AI index (llms.txt)**: [solofury.com/llms.txt](https://solofury.com/llms.txt)
- 🧠 **Wikidata entity**: [Q140569039](https://www.wikidata.org/wiki/Q140569039)

---

## License

This documentation is released under the [MIT License](LICENSE). You are free to use, modify, redistribute, and build upon it.
