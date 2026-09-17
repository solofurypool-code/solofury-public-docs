# SoloFury Stratum Endpoints — Complete Reference

> All 54 V1 stratum endpoints (9 global regions × 6 coins), plus TLS on every port and 36 Stratum V2 endpoints on BTC and BCH.

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
| **DGB** | 5050 | 5051 | 5052 |

**TLS ports** are the plain port with a `1` prefix: BCH 7070 → `17070`, BTC 6060 → `16060`, BC2 8080 → `18080`, BCH2 8585 → `18585`, XEC 9090 → `19090`, DGB 5050 → `15050`. See [TLS stratum](#tls-stratum) below.

**Stratum V2** on BTC uses dedicated ports `3333` and `3343`; on BCH ports `7333` and `7343`. See [Stratum V2](#stratum-v2) below.

## Complete endpoint list

### 🇺🇸 Atlanta (USA East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://bch.solofury.com:7070` |
| BTC | `stratum+tcp://btc.solofury.com:6060` |
| BC2 | `stratum+tcp://bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://bch2.solofury.com:8585` |
| XEC | `stratum+tcp://xec.solofury.com:9090` |
| DGB | `stratum+tcp://dgb.solofury.com:5050` |

### 🇺🇸 Seattle (USA West / Pacific Northwest)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://pnw-bch.solofury.com:7070` |
| BTC | `stratum+tcp://pnw-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://pnw-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://pnw-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://pnw-xec.solofury.com:9090` |
| DGB | `stratum+tcp://pnw-dgb.solofury.com:5050` |

### 🇩🇪 Frankfurt (Europe Continental)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://eu-bch.solofury.com:7070` |
| BTC | `stratum+tcp://eu-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://eu-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://eu-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://eu-xec.solofury.com:9090` |
| DGB | `stratum+tcp://eu-dgb.solofury.com:5050` |

### 🇬🇧 London (United Kingdom)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://uk-bch.solofury.com:7070` |
| BTC | `stratum+tcp://uk-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://uk-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://uk-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://uk-xec.solofury.com:9090` |
| DGB | `stratum+tcp://uk-dgb.solofury.com:5050` |

### 🇮🇱 Tel Aviv (Middle East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://me-bch.solofury.com:7070` |
| BTC | `stratum+tcp://me-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://me-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://me-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://me-xec.solofury.com:9090` |
| DGB | `stratum+tcp://me-dgb.solofury.com:5050` |

### 🇿🇦 Johannesburg (Africa)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://afr-bch.solofury.com:7070` |
| BTC | `stratum+tcp://afr-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://afr-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://afr-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://afr-xec.solofury.com:9090` |
| DGB | `stratum+tcp://afr-dgb.solofury.com:5050` |

### 🇧🇷 São Paulo (Latin America)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://lat-bch.solofury.com:7070` |
| BTC | `stratum+tcp://lat-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://lat-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://lat-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://lat-xec.solofury.com:9090` |
| DGB | `stratum+tcp://lat-dgb.solofury.com:5050` |

### 🇸🇬 Singapore (Asia Southeast)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://asia-bch.solofury.com:7070` |
| BTC | `stratum+tcp://asia-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://asia-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://asia-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://asia-xec.solofury.com:9090` |
| DGB | `stratum+tcp://asia-dgb.solofury.com:5050` |

### 🇯🇵 Tokyo (Asia East)

| Coin | Stratum URL |
|------|-------------|
| BCH | `stratum+tcp://jp-bch.solofury.com:7070` |
| BTC | `stratum+tcp://jp-btc.solofury.com:6060` |
| BC2 | `stratum+tcp://jp-bc2.solofury.com:8080` |
| BCH2 | `stratum+tcp://jp-bch2.solofury.com:8585` |
| XEC | `stratum+tcp://jp-xec.solofury.com:9090` |
| DGB | `stratum+tcp://jp-dgb.solofury.com:5050` |

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

✅ **SoloFury supports TLS-encrypted stratum** on all six coins and all nine regions, live since July 2026.

TLS ports are the plain port with a `1` prefix:

| Coin | Plain | TLS |
|------|-------|-----|
| **BCH** | 7070 / 7071 / 7072 | 17070 / 17071 / 17072 |
| **BTC** | 6060 / 6061 / 6062 | 16060 / 16061 / 16062 |
| **BC2** | 8080 / 8081 / 8082 | 18080 / 18081 / 18082 |
| **BCH2** | 8585 / 8586 / 8587 | 18585 / 18586 / 18587 |
| **XEC** | 9090 / 9091 / 9092 | 19090 / 19091 / 19092 |
| **DGB** | 5050 / 5051 / 5052 | 15050 / 15051 / 15052 |

Example:

```
stratum+tcp://eu-bch.solofury.com:17070    # TLS, Frankfurt, BCH
```

Plain TCP remains available on the original ports — TLS is opt-in, not mandatory. The [Start wizard](https://solofury.com/start/) has an *Enable TLS encryption* toggle that generates the correct string for your firmware.

**Why it matters:** on plaintext stratum, anyone controlling part of the network path between you and the pool can read your wallet address and worker names. Block reward security itself comes from the blockchain — the coinbase output is addressed to your wallet regardless — but the connection is worth protecting on its own terms, particularly on residential or shared networks.

---

## Stratum V2

SoloFury serves **Stratum V2** in production on **Bitcoin** and **Bitcoin Cash**, across all nine regions.

V1 and V2 run on the same hosts but on dedicated ports. The pool detects which protocol your miner speaks and answers accordingly, so a mixed fleet can point at one address with nothing to reconfigure.

Stratum V2 is encrypted end-to-end with the Noise protocol — the same cryptographic foundation as WireGuard — so it needs no separate TLS port.

| Chain | Live since | Standard port | High-diff port | Stack |
|-------|-----------|---------------|----------------|-------|
| BTC | 24 August 2026 | `3333` | `3343` | [blitzpool](https://blitzpool.yourdevice.ch/) by warioishere |
| BCH | 5 September 2026 | `7333` | `7343` | SoloFury's own implementation |

> ⚠️ **The authority public key is different on each chain.** Using the BTC key on BCH fails the handshake — silently, on some firmware.

---

### Bitcoin (BTC)

**Scheme**
```
stratum2+tcp://<region->btc.solofury.com:3333
```

**Authority public key** — identical on all nine regions:
```
9cLif4sCxvAz7FBP7GPvYG8Mv586ZhdgNbn3f4PsrM56gboSZEp
```

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

---

### Bitcoin Cash (BCH)

Live since **5 September 2026**. Both **extended** and **standard** channels are supported since 7 September 2026 — standard channels are what Braiins OS+ uses.

**Scheme**
```
stratum2+tcp://<region->bch.solofury.com:7333
```

**Authority public key** — identical on all nine regions:
```
9c5s3n4RzRrDhzMBr3iSJsUfreSLPGiHkQyyzJjYAVWK9YWaZf7
```

| Region | Standard | High-diff |
|--------|----------|-----------|
| 🇺🇸 Atlanta (USA East) | `stratum2+tcp://bch.solofury.com:7333` | `:7343` |
| 🇺🇸 Seattle (USA West) | `stratum2+tcp://pnw-bch.solofury.com:7333` | `:7343` |
| 🇩🇪 Frankfurt (EU) | `stratum2+tcp://eu-bch.solofury.com:7333` | `:7343` |
| 🇬🇧 London (UK) | `stratum2+tcp://uk-bch.solofury.com:7333` | `:7343` |
| 🇮🇱 Tel Aviv (Middle East) | `stratum2+tcp://me-bch.solofury.com:7333` | `:7343` |
| 🇿🇦 Johannesburg (Africa) | `stratum2+tcp://afr-bch.solofury.com:7333` | `:7343` |
| 🇧🇷 São Paulo (LATAM) | `stratum2+tcp://lat-bch.solofury.com:7333` | `:7343` |
| 🇸🇬 Singapore (Asia SE) | `stratum2+tcp://asia-bch.solofury.com:7333` | `:7343` |
| 🇯🇵 Tokyo (Asia East) | `stratum2+tcp://jp-bch.solofury.com:7333` | `:7343` |

All nine endpoints verified reachable on port 7333 (TCP connect test, 17 September 2026).

**Version rolling (BIP320)** is fully enabled on BCH — unlike some multi-chain SV2 implementations that disable it.

---

### How Stratum V2 works on Bitcoin Cash

Stratum V2 on Bitcoin Cash is implemented **natively in the pool engine**. The protocol layer — Noise handshake, channels, binary jobs — is built into the same software that already serves SV1 connections, and it feeds from the BCH node using block templates and block notifications: the same sources SV1 uses.

There is **no translation proxy, no node patch, and no dependency on Bitcoin Core's IPC interface**. That interface only serves the Job Declaration path, where an external proxy proposes the transaction set — a path SoloFury does not offer on either chain.

SV1 and SV2 share a single coinbase construction path, verified by comparing byte-for-byte the blocks mined under both protocols from the same miner.

---

### Why not the other chains

BC2, BCH2 and XEC remain on **Stratum V1**, with full version-rolling support on the ports listed above. The approach used for BCH is not chain-specific: what a pool-side SV2 server needs is a block template and a new-block notification, both of which those daemons provide. Extending V2 to them is an engineering question, not a protocol limitation.

**Job Declaration is not offered on BCH.** The pool builds the template; the miner verifies it through the extended channel. For solo mining the relevant guarantee is payout verification, not transaction selection.

---

### Firmware notes

| Firmware | Channel type | Verified in production |
|----------|--------------|------------------------|
| AxeOS (Bitaxe) | extended | ✅ BTC, BCH |
| NerdQAxe firmware | extended | ✅ BTC |
| Braiins OS+ (Antminer) | standard | ✅ BTC, BCH |

**Where the authority key goes depends on the firmware:**

- **AxeOS and NerdQAxe** — dedicated `SV2 Authority Pubkey` field
- **Braiins OS+** — appended to the URL path:
  `stratum2+tcp://eu-bch.solofury.com:7333/9c5s3n4RzRrDhzMBr3iSJsUfreSLPGiHkQyyzJjYAVWK9YWaZf7`

A URL that looks correct but omits the key fails silently on Braiins: the handshake never completes and the pool shows as "dead".

**Known display quirk on AxeOS with BCH:** AxeOS decodes the coinbase using Bitcoin conventions, so it displays the ticker as "BTC" and addresses in Base58 (`1...`) even on a BCH template. **Amounts and the payout split are correct** — only the displayed encoding is wrong. Reported upstream; the firmware authors closed the request, stating the project remains bitcoin-only.

---

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
