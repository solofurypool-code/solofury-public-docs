# SoloFury API Reference

> Public REST API for pool stats, miner stats, and network info.

Base URL: `https://solofury.com`

All endpoints return JSON and require no authentication.

## Coin selection

**The coin is chosen by the path prefix, not by a query parameter.**

| Coin | Prefix |
|------|--------|
| BCH | `/api/` (default, no prefix) |
| BTC | `/api-btc/` |
| BC2 | `/api-bc2/` |
| BCH2 | `/api-bch2/` |
| XEC | `/api-xec/` |

```bash
curl -s https://solofury.com/api/pool          # BCH
curl -s https://solofury.com/api-btc/pool      # BTC
curl -s https://solofury.com/api-xec/pool      # XEC
```

Querying `/api/client/<btc-address>` returns an empty worker list rather than an error — the request succeeds, it just looks for that address on the BCH pool. Use `/api-btc/client/<address>` instead.

## Units and types

- **Hashrate** is a number in **H/s** (not a formatted string). `1612625843141.85` is ≈ 1.61 TH/s.
- **Difficulty** is a number.
- **Timestamps** are ISO 8601 strings in UTC, e.g. `2026-08-25T21:17:21.213Z`.
- **Efficiency** is a percentage as a number.

## Pool stats

### `GET /api/pool`

Aggregated pool statistics. Add a coin prefix for other chains.

```bash
curl -s https://solofury.com/api/pool
curl -s https://solofury.com/api-btc/pool
```

**Response fields:**

| Field | Type | Notes |
|-------|------|-------|
| `totalHashRate` | number | H/s, current |
| `totalHashRate1m` `1hr` `1d` `7d` | number | H/s, rolling windows |
| `totalMiners` | number | distinct addresses |
| `totalWorkers` | number | distinct workers |
| `activeMiners7d` `activeWorkers7d` | number | seen in the last 7 days |
| `idleWorkers` | number | connected but not submitting |
| `disconnected` | number | recently dropped |
| `blockHeight` | number | chain tip as seen by the pool |
| `networkDifficulty` | number | |
| `networkHashRate` | number | H/s |
| `blocksFound` | number | confirmed blocks found by the pool |
| `bestDifficulty` | number | best share the pool has seen |
| `luck` | number | percentage; see note below |
| `roundShares` | number | shares in the current round |
| `sharesPerSecond` | number | |
| `accepted` `rejected` `stale` `invalid` `duplicate` | number | share counters |
| `efficiency` | number | percentage |
| `uptime` | number | seconds |
| `fee` | number | pool fee percentage (1) |
| `sources` | array | per-region aggregation status |

The `sources` array reflects that the pool aggregates from multiple regions. If one region is briefly unreachable the aggregate is still served from the last known good value for that source, so numbers stay stable rather than dropping to zero.

## Miner / worker stats

### `GET /api/client/<wallet-address>`

Stats for one wallet across all its workers. **Remember the coin prefix.**

```bash
curl -s https://solofury.com/api-btc/client/bc1qexampleaddress...
```

**Top-level fields:**

| Field | Type | Notes |
|-------|------|-------|
| `hashRate` | number | H/s, current |
| `hashRate1m` `5m` `1hr` `1d` `7d` | number | H/s, rolling windows |
| `workersCount` | number | |
| `bestDifficulty` | number | best share this round |
| `bestShare` | number | |
| `bestEver` | number | all-time best for this address |
| `lastShare` | string | ISO 8601 |
| `shares` | number | |
| `accepted` `rejected` `stale` `invalid` `duplicate` | number | |
| `efficiency` | number | percentage |
| `luck` | number | percentage; see note below |
| `roundShares` | number | |
| `networkDifficulty` | number | |
| `workers` | array | see below |

**Worker fields:**

| Field | Type | Notes |
|-------|------|-------|
| `name` | string | worker name after the `.` in the stratum username |
| `hashRate` | number | H/s |
| `hashRate1m` `5m` `1hr` `1d` `7d` | number | H/s |
| `bestDifficulty` `bestEver` | number | |
| `currentDiff` | number | difficulty currently assigned by vardiff |
| `shares` | number | |
| `lastSeen` | string | ISO 8601 |
| `startTime` | string | ISO 8601, session start |
| `sessionId` | string | |
| `protocol` | string | `"SV1"` or `"SV2"` |
| `availableIn` | string | `"ckpool"` or `"sv2"` — which stack served this worker |
| `channelCount` | number | SV2 only, open channels |
| `region` | string | `us`, `eu`, `jp`, … |
| `regionLabel` `regionShort` `regionFlag` | string | display helpers |
| `regionSourceName` | string | e.g. `Frankfurt SV2` |
| `regionStratum` | string | hostname the worker is connected to |

**Stratum V2 workers** carry `protocol: "SV2"`, `availableIn: "sv2"` and `channelCount`. V2 is BTC only — see [stratum-endpoints.md](stratum-endpoints.md#stratum-v2-btc-only).

Example — list workers and their protocol:

```bash
curl -s "https://solofury.com/api-btc/client/$WALLET" \
  | jq '.workers[] | {name, protocol, hashRate, region}'
```

### `GET /api/client/<wallet-address>/chart?hours=24`

Time series for charting. `hours` defaults to 24.

## Network info

### `GET /api/network`

Blockchain network state as seen by the pool's node.

| Field | Notes |
|-------|-------|
| `blocks` | chain height |
| `difficulty` | |
| `networkhashps` | network hashrate, H/s |
| `currentblockweight` `currentblocktx` | current template |
| `pooledtx` | mempool transaction count |
| `chain` | `main` |
| `lastBlockTime` | ISO 8601 |
| `warnings` | node warnings, usually empty |

### `GET /api/network/history`

Historical network difficulty and hashrate.

## Pool info

### `GET /api/info`

Pool metadata and recent block data.

| Field | Notes |
|-------|-------|
| `blockData` | recent blocks found by the pool |
| `userAgents` | connected miner software breakdown |
| `highScores` | best difficulties, with `bestDifficultyUserAgent` |
| `poolIdentifier` | coinbase tag |
| `fee` | pool fee percentage |
| `stratumPort` | primary stratum port for this coin |
| `uptime` | seconds |
| `accepted` `rejected` `stale` `invalid` | share counters |
| `efficiency` | percentage |

**Blocks are served from `blockData` inside `/api/info`** — there is no separate `/api/blocks` endpoint.

Only **confirmed** blocks appear. A freshly found block is held as a candidate until RPC verification completes, and orphans are excluded, so a block can appear a few minutes after it was actually found.

### `GET /api/info/chart?hours=24`

Pool hashrate time series.

### `GET /api/shares`

Share statistics.

## Notes on semantics

**Luck is personal, not pool-round.** It resets on blocks found by that address, not on pool-wide rounds. Values above 100% are ordinary solo-mining variance, not an error condition — do not treat them as a fault in a monitoring script.

**Caching.** Responses are served through a stale-while-revalidate layer with per-region last-good fallback. During a brief source hiccup you may see values that lag by a few seconds. This is deliberate: it keeps numbers stable rather than flickering to zero.

**Worker liveness.** Use `lastSeen` rather than `hashRate1hr` to decide whether a worker is online. The rolling hashrate averages decay slowly after a disconnect, so a machine that went offline ten minutes ago still shows a non-zero `hashRate1hr`.

## LLM-friendly content discovery

Per [llmstxt.org](https://llmstxt.org/):

```
https://solofury.com/llms.txt          # Short form
https://solofury.com/llms-full.txt     # Full content
```

## Rate limits

- **Public API**: ~60 requests/minute per IP (Cloudflare-enforced)
- **Burst**: tolerates short bursts up to 120 req in a 10s window
- **Sustained heavy use**: contact us at [solofury.com/contact/](https://solofury.com/contact/) for higher limits

## Example: monitoring script

```bash
#!/bin/bash
WALLET="bc1qyourbitcoinaddress..."

response=$(curl -s "https://solofury.com/api-btc/client/$WALLET")

# hashRate is a number in H/s — convert for display
hashrate=$(echo "$response" | jq -r '.hashRate1m')
th=$(echo "scale=2; $hashrate / 1000000000000" | bc)
last_share=$(echo "$response" | jq -r '.lastShare')
workers=$(echo "$response" | jq -r '.workersCount')

echo "Hashrate (1m): ${th} TH/s"
echo "Workers:       $workers"
echo "Last share:    $last_share"
```

## Example: Python monitoring

```python
import requests
from datetime import datetime, timezone

WALLET = "bc1qyourbitcoinaddress..."
COIN = "api-btc"          # api = BCH · api-btc · api-bc2 · api-bch2 · api-xec

r = requests.get(f"https://solofury.com/{COIN}/client/{WALLET}", timeout=10)
r.raise_for_status()
d = r.json()

print(f"Hashrate (1m): {d['hashRate1m'] / 1e12:.2f} TH/s")
print(f"Workers:       {d['workersCount']}")
print(f"Efficiency:    {d['efficiency']:.2f}%")

# Worker liveness: use lastSeen, not hashrate averages
now = datetime.now(timezone.utc)
for w in d.get("workers", []):
    seen = datetime.fromisoformat(w["lastSeen"].replace("Z", "+00:00"))
    age = (now - seen).total_seconds()
    state = "online" if age <= 600 else f"stale ({int(age)}s)"
    print(f"  {w['name']:<20} {w['hashRate'] / 1e12:>6.2f} TH/s  "
          f"{w.get('protocol', 'SV1'):<4} {w.get('region', '?'):<4} {state}")
```

---

← [Back to README](../README.md)
