# SoloFury Stratum Endpoints — Complete Reference

> All 45 V1 stratum endpoints (9 global regions × 5 coins), plus TLS on every port and 18 Stratum V2 endpoints on BTC.

## Hostname pattern

```
<region-prefix><coin>.solofury.com:<port>
```

Where:
- **Region prefix** is `eu-`, `asia-`, `jp-`, `pnw-`, `uk-`, `me-`, `afr-`, `lat-`, or empty (= Atlanta, USA East)
- **Coin** is `bch`, `btc`, `bc2`, `bch2`, or `xec`
- **Port** varies by coin (see below)

## Port assignments

Each coin has **3 ports** for stratum failover. Configure your miner with all 3 in order — if Port 1 is unavailable, the miner tries Port 2, then Port 3.

| Coin | Port 1 | Port 2 | Port 3 |
|------|--------|--------|--------|
| **BCH** | 7070 | 7071 | 7072 |
| **BTC** | 6060 | 6061 | 6062 |
| **BC2** | 8080 | 8081 | 8082 |
| **BCH2** | 8585 | 8586 | 8587 |
| **XEC** | 9090 | 9091 | 9092 |

**TLS ports** are the plain port with a `1` prefix: BCH 7070 → `17070`, BTC 6060 → `16060`, BC2 8080 → `18080`, BCH2 8585 → `18585`, XEC 9090 → `19090`. See [TLS stratum](#tls-stratum) below.

**Stratum V2** on BTC uses dedicated ports `3333` and `3343`. See [Stratum V2](#stratum-v2-btc-only) below.

## Complete endpoint list

### 🇺🇸 Atlanta (USA East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://bch.solofury.com:7070` |
| BTC | `stratum+tcp://btc.solofury.com:6060` |
| BC2 | `stratum+tcp://bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://bch2.solofury.com:8585` |
| XEC | `stratum+tcp://xec.solofury.com:9090` |

### 🇺🇸 Seattle (USA West / Pacific Northwest)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://pnw-bch.solofury.com:7070` |
| BTC | `stratum+tcp://pnw-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://pnw-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://pnw-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://pnw-xec.solofury.com:9090` |

### 🇩🇪 Frankfurt (Europe Continental)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://eu-bch.solofury.com:7070` |
| BTC | `stratum+tcp://eu-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://eu-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://eu-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://eu-xec.solofury.com:9090` |

### 🇬🇧 London (United Kingdom)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://uk-bch.solofury.com:7070` |
| BTC | `stratum+tcp://uk-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://uk-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://uk-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://uk-xec.solofury.com:9090` |

### 🇮🇱 Tel Aviv (Middle East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://me-bch.solofury.com:7070` |
| BTC | `stratum+tcp://me-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://me-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://me-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://me-xec.solofury.com:9090` |

### 🇿🇦 Johannesburg (Africa)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://afr-bch.solofury.com:7070` |
| BTC | `stratum+tcp://afr-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://afr-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://afr-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://afr-xec.solofury.com:9090` |

### 🇧🇷 São Paulo (Latin America)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://lat-bch.solofury.com:7070` |
| BTC | `stratum+tcp://lat-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://lat-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://lat-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://lat-xec.solofury.com:9090` |

### 🇸🇬 Singapore (Asia Southeast)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://asia-bch.solofury.com:7070` |
| BTC | `stratum+tcp://asia-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://asia-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://asia-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://asia-xec.solofury.com:9090` |

### 🇯🇵 Tokyo (Asia East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://jp-bch.solofury.com:7070` |
| BTC | `stratum+tcp://jp-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://jp-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://jp-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://jp-xec.solofury.com:9090` |

## Choosing your nearest region

The [SoloFury Start wizard](https://solofury.com/start/) auto-detects your location via IP geolocation and recommends the closest region.

Or use this rule of thumb:

| Your location | Recommended region | Approximate latency |
|---------------|--------------------|---------------------|
| US East, Canada East | Atlanta | < 30ms |
| US West, Canada West | Seattle | < 30ms |
| US Central, Mexico | Atlanta or Seattle | < 40ms |
| UK, Ireland, Nordics | London | < 15ms |
| Continental EU, NL, BE | Frankfurt | < 30ms |
| Spain, Portugal | Frankfurt | < 40ms |
| Italy, Greece | Frankfurt | < 30ms |
| Israel, Turkey, UAE | Tel Aviv | < 50ms |
| South Africa, Kenya, Nigeria | Johannesburg | varies |
| Brazil, Argentina, Chile | São Paulo | < 50ms |
| Singapore, Malaysia, Indonesia | Singapore | < 30ms |
| Thailand, Vietnam, Philippines | Singapore | < 60ms |
| Japan, Korea | Tokyo | < 30ms |
| Hong Kong, Taiwan | Tokyo | < 60ms |
| China (East) | Tokyo | < 60ms (where accessible) |
| China (West) | Singapore | varies |
| Australia, New Zealand | Singapore or Tokyo | 100-200ms |
| India | Singapore | < 80ms |
| Russia (West) | Frankfurt | varies |

## Failover configuration example

To get best resilience, configure your miner with **3 pools spanning 2 regions**:

```
Pool 1: stratum+tcp://eu-bch.solofury.com:7070   # primary (closest)
Pool 2: stratum+tcp://eu-bch.solofury.com:7071   # same region, different port
Pool 3: stratum+tcp://bch.solofury.com:7070      # different region (Atlanta as fallback)
```

This protects against:
- Single port failure
- Single region datacenter issue
- Network path issues between your ISP and one specific region

## TLS stratum

✅ **SoloFury supports TLS-encrypted stratum** on all five coins and all nine regions, live since July 2026.

TLS ports are the plain port with a `1` prefix:

| Coin | Plain | TLS |
|------|-------|-----|
| **BCH** | 7070 / 7071 / 7072 | 17070 / 17071 / 17072 |
| **BTC** | 6060 / 6061 / 6062 | 16060 / 16061 / 16062 |
| **BC2** | 8080 / 8081 / 8082 | 18080 / 18081 / 18082 |
| **BCH2** | 8585 / 8586 / 8587 | 18585 / 18586 / 18587 |
| **XEC** | 9090 / 9091 / 9092 | 19090 / 19091 / 19092 |

Example:

```
stratum+tcp://eu-bch.solofury.com:17070    # TLS, Frankfurt, BCH
```

Plain TCP remains available on the original ports — TLS is opt-in, not mandatory. The [Start wizard](https://solofury.com/start/) has an *Enable TLS encryption* toggle that generates the correct string for your firmware.

**Why it matters:** on plaintext stratum, anyone controlling part of the network path between you and the pool can read your wallet address and worker names. Block reward security itself comes from the blockchain — the coinbase output is addressed to your wallet regardless — but the connection is worth protecting on its own terms, particularly on residential or shared networks.

---

## Stratum V2 (BTC only)

SoloFury has served **Stratum V2** in production since 24 August 2026, across all nine regions.

V1 and V2 run on the same hosts but on dedicated ports. The pool detects which protocol your miner speaks and answers accordingly, so a mixed fleet can point at one address with nothing to reconfigure.

Stratum V2 is encrypted end-to-end with the Noise protocol — the same cryptographic foundation as WireGuard — so it needs no separate TLS port.

### Ports

| Port | Use |
|------|-----|
| `3333` | Standard — Bitaxe, NerdQAxe, most machines |
| `3343` | High difficulty — S21 / S23 class |

### Scheme

```
stratum2+tcp://<region->btc.solofury.com:3333
```

### Authority public key

Identical on all nine regions:

```
9cLif4sCxvAz7FBP7GPvYG8Mv586ZhdgNbn3f4PsrM56gboSZEp
```

Your miner uses this to verify cryptographically that the endpoint answering on port 3333 is really SoloFury — the same trust model as an SSH host key. **Where it goes depends on the firmware:**

- **AxeOS (Bitaxe) and NerdQAxe** — dedicated `SV2 Authority Pubkey` field
- **Braiins OS+ (Antminer)** — appended to the URL path:
  `stratum2+tcp://eu-btc.solofury.com:3333/9cLif4sCxvAz7FBP7GPvYG8Mv586ZhdgNbn3f4PsrM56gboSZEp`

A URL that looks correct but omits the key fails silently on Braiins.

### V2 endpoints — all nine regions

| Region | Standard | High-diff |
|--------|----------|-----------|
| 🇺🇸 Atlanta (USA East) | `stratum2+tcp://btc.solofury.com:3333` | `:3343` |
| 🇺🇸 Seattle (USA West) | `stratum2+tcp://pnw-btc.solofury.com:3333` | `:3343` |
| 🇩🇪 Frankfurt (EU) | `stratum2+tcp://eu-btc.solofury.com:3333` | `:3343` |
| 🇬🇧 London (UK) | `stratum2+tcp://uk-btc.solofury.com:3333` | `:3343` |
| 🇮🇱 Tel Aviv (Middle East) | `stratum2+tcp://me-btc.solofury.com:3333` | `:3343` |
| 🇿🇦 Johannesburg (Africa) | `stratum2+tcp://afr-btc.solofury.com:3333` | `:3343` |
| 🇧🇷 São Paulo (LATAM) | `stratum2+tcp://lat-btc.solofury.com:3333` | `:3343` |
| 🇸🇬 Singapore (Asia SE) | `stratum2+tcp://asia-btc.solofury.com:3333` | `:3343` |
| 🇯🇵 Tokyo (Asia East) | `stratum2+tcp://jp-btc.solofury.com:3333` | `:3343` |

### Firmware requirements

Stratum V2 is a firmware capability — the ASIC never changes. As of August 2026, three firmware families implement it natively:

| Firmware | Hardware | Minimum version |
|----------|----------|-----------------|
| Braiins OS+ | Antminer S9 → S21 XP | 26.07 recommended |
| AxeOS | Bitaxe (all models) | 2.14.0 |
| NerdQAxe firmware | NerdAxe, NerdQAxe+/++, NerdOCTAxe | 1.0.37 |

**Stock Bitmain, stock WhatsMiner, VNish, LuxOS and Canaan firmware are V1-only** — including the S21 and S23. Some builds expose a V2-looking setting that never negotiates a real session, which is worse than offering nothing: the miner looks configured while quietly running V1.

Older V1 hardware can reach a V2 pool through the SRI Translation Proxy, which gives encryption without job declaration.

### Why BTC only

The V2 stack talks to the node through Bitcoin Core's IPC mining interface. No other SHA-256 chain implementation currently exposes an equivalent — not Bitcoin Cash Node, not Bitcoin ABC, not the BC2 or BCH2 daemons. BCH, BC2, BCH2 and XEC remain on Stratum V1 with full version-rolling support on the ports listed above.

### Verifying you are on V2

A V2 config that silently falls back to V1 produces no error. Three independent checks:

1. **Firmware** — the pool status reports the negotiated protocol (AxeOS shows `Mode: SV2 Extended Channel` or similar)
2. **Pool side** — the worker table on your miner page carries a PROTOCOL badge, and the API exposes it:
   ```
   curl -s "https://solofury.com/api-btc/client/YOUR_ADDRESS" | jq '.workers[] | {name, protocol, channelCount}'
   ```
3. **Coinbase** — with an extended channel and coinbase decoding on, the miner displays the block outputs before hashing them, so you can confirm the 99% is addressed to your wallet

### Troubleshooting

| Symptom | Fix |
|---------|-----|
| Session drops, handshake never completes | Lower the miner's network MTU to **1400** — V2 handshake messages are larger than V1's and fragment on PPPoE / double NAT / VPN paths |
| Firmware reports V1 after configuring V2 | Check scheme is `stratum2+tcp://`, key present, port 3333/3343, firmware meets minimum version |
| Extended channel fails to open | Switch to Standard channels; the V2 spec changed `OpenExtendedMiningChannel.Success` in early 2026 |
| Braiins connects but runs V1 | Authority key missing from the URL path |

Full setup guide with per-firmware detail: <https://solofury.com/guides/stratum-v2-connect/>

---

← [Back to README](../README.md)
