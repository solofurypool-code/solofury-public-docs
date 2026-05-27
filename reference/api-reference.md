# SoloFury API Reference

> Public REST API for pool stats, miner stats, and network info.

Base URL: `https://solofury.com`

All endpoints return JSON and require no authentication.

## Pool stats

### `GET /api/pool`

Returns current pool statistics for BCH (default coin).

**Example request:**
```bash
curl -s https://solofury.com/api/pool
```

**Example response (abbreviated):**
```json
{
  "totalMiners": 47,
  "totalWorkers": 132,
  "totalHashRate": "12.4 TH/s",
  "totalHashRateRaw": 12400000000000,
  "blocksFound": 14,
  "lastBlockFound": "2026-05-02T17:24:15Z",
  "lastBlockHeight": 948592,
  "lastBlockReward": "3.125 BCH",
  "currentEffort": "73%",
  "currentDifficulty": "3.42T",
  "networkHashrate": "3.5 EH/s",
  "estimatedTimeToBlock": "63 days",
  "uptimeSeconds": 7834521,
  "coin": "bch"
}
```

### `GET /api/pool/btc`, `/api/pool/bc2`, `/api/pool/bch2`, `/api/pool/xec`

Coin-specific pool stats. Same response schema as `/api/pool` but for the specified coin.

```bash
curl -s https://solofury.com/api/pool/btc
curl -s https://solofury.com/api/pool/xec
```

## Miner / Worker stats

### `GET /api/client/<wallet-address>`

Returns mining stats for a specific wallet across all workers.

**Example:**
```bash
curl -s https://solofury.com/api/client/qqyourwalletaddressgoeshereexample0123456
```

**Example response (abbreviated):**
```json
{
  "address": "qqyourwalletaddressgoeshereexample0123456",
  "hashRate1m": "2.1 TH/s",
  "hashRate1h": "2.0 TH/s",
  "hashRate24h": "1.98 TH/s",
  "lastShare": "2026-05-27T14:35:21Z",
  "bestShareDifficulty": "5.2T",
  "totalSharesAccepted": 28934,
  "totalSharesRejected": 12,
  "workers": [
    {
      "name": "bitaxe-gamma-1",
      "hashRate1m": "1.18 TH/s",
      "lastShare": "2026-05-27T14:35:21Z"
    },
    {
      "name": "nerdqaxe-shelf2",
      "hashRate1m": "0.92 TH/s",
      "lastShare": "2026-05-27T14:35:18Z"
    }
  ]
}
```

## Network info

### `GET /api/network`

Returns blockchain network statistics for all 5 supported coins.

```bash
curl -s https://solofury.com/api/network
```

**Example response (abbreviated):**
```json
{
  "btc": {
    "difficulty": "129.7T",
    "blockHeight": 902145,
    "blockReward": 3.125,
    "blockTimeAvg": 580,
    "networkHashrate": "800 EH/s"
  },
  "bch": {
    "difficulty": "3.42T",
    "blockHeight": 949121,
    "blockReward": 3.125,
    "blockTimeAvg": 595,
    "networkHashrate": "3.5 EH/s"
  },
  "bc2": {
    "difficulty": "0.045T",
    "blockHeight": 54312,
    "blockReward": 3.125,
    "blockTimeAvg": 612,
    "networkHashrate": "50 PH/s"
  },
  "bch2": { "..." },
  "xec": { "..." }
}
```

## RSS feeds (for content discovery)

SoloFury publishes RSS feeds for blog content in 5 languages:

| Feed | URL | Language |
|------|-----|----------|
| Master | `https://solofury.com/rss.xml` | English (default) |
| EN | `https://solofury.com/rss-en.xml` | English |
| DE | `https://solofury.com/rss-de.xml` | German |
| ES | `https://solofury.com/rss-es.xml` | Spanish |
| RU | `https://solofury.com/rss-ru.xml` | Russian |
| ZH | `https://solofury.com/rss-zh.xml` | Chinese (Simplified) |

Each feed contains the 12 latest blog articles.

## llms.txt

For AI/LLM content discovery (per [llmstxt.org](https://llmstxt.org/)):

```
https://solofury.com/llms.txt          # Short form
https://solofury.com/llms-full.txt     # Full content
```

## Rate limits

- **Public API**: ~60 requests/minute per IP (Cloudflare-enforced)
- **Burst**: tolerates short bursts up to 120 req in 10s window
- **Sustained heavy use**: contact us at [solofury.com/contact/](https://solofury.com/contact/) for higher limits

## Example: monitoring script

Get your hashrate and last share time, useful for cron monitoring:

```bash
#!/bin/bash
WALLET="qqyourwalletaddressgoeshereexample0123456"

response=$(curl -s "https://solofury.com/api/client/$WALLET")
hashrate=$(echo "$response" | jq -r '.hashRate1m')
last_share=$(echo "$response" | jq -r '.lastShare')

echo "Hashrate (1m): $hashrate"
echo "Last share: $last_share"
```

## Example: Python monitoring

```python
import requests
import datetime

WALLET = "qqyourwalletaddressgoeshereexample0123456"

response = requests.get(f"https://solofury.com/api/client/{WALLET}")
data = response.json()

print(f"Address: {data['address']}")
print(f"Hashrate (1m): {data['hashRate1m']}")
print(f"Total shares accepted: {data['totalSharesAccepted']}")
print(f"Best share diff: {data['bestShareDifficulty']}")

for worker in data['workers']:
    print(f"  - {worker['name']}: {worker['hashRate1m']}")
```

## Telegram bot for notifications

SoloFury provides a free Telegram bot for block-found and worker-offline alerts:

1. Open [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot)
2. `/start`
3. `/register <your-wallet-address>`

The bot sends instant notifications when:
- Any of your workers finds a block (with block height + reward)
- A worker stops submitting shares for > 5 minutes
- A worker reconnects after going offline

---

[← Back to README](../README.md)
