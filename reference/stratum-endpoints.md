# SoloFury Stratum Endpoints — Complete Reference

> All 45 stratum endpoints: 9 global regions × 5 coins.

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

### 🇬🇧 London (UK / Ireland)

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

### 🇧🇷 São Paulo (LATAM)

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

Best practice: use the [Solo Start configurator](https://solofury.com/start/) which auto-detects your location via IP geolocation and recommends the closest region.

Or use this rule of thumb:

| Your location | Recommended region | Approximate latency |
|---------------|-------------------|---------------------|
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

## SSL stratum?

⚠️ **SoloFury does not currently support SSL stratum** (planned for 2027). All stratum connections are plain TCP.

This is consistent with industry practice — stratum data (job notifications, share submissions) doesn't contain sensitive information that benefits from TLS encryption. Block reward security comes from the blockchain (coinbase output addressed to your wallet), not from connection encryption.

---

[← Back to README](../README.md)
