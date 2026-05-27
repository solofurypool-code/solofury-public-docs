# Bitaxe Solo Mining Setup — SoloFury

> Step-by-step guide to configure Bitaxe Gamma 1.2 TH/s and Bitaxe Ultra 500 GH/s for solo mining on SoloFury across all 5 supported SHA-256 coins.

## Supported Bitaxe models

| Model | Chip | Hashrate | Power | TWh/J | Recommended for |
|-------|------|----------|-------|-------|-----------------|
| **Bitaxe Gamma (BM1370)** | BM1370 (3nm) | 1.2 TH/s | ~17 W | ~14.2 | Best efficiency |
| **Bitaxe Ultra (BM1366)** | BM1366 (5nm) | 500 GH/s | ~11 W | ~22 | Most popular |
| **Bitaxe Supra (BM1368)** | BM1368 | 700 GH/s | ~14 W | ~20 | Mid-tier |
| **Bitaxe Max (BM1397)** | BM1397 (7nm) | 400 GH/s | ~15 W | ~37 | Legacy units |

## Realistic odds at home

With 1 TH/s of Bitaxe hashrate (1 unit), here are approximate daily block-finding odds:

| Coin | Network Hashrate | Daily Block Odds | Avg Time to Find |
|------|-----------------|-----------------|------------------|
| **BTC** | ~800 EH/s | 1 in 4.6M | ~12,600 years (statistical) |
| **BCH** | ~3.5 EH/s | 1 in 23,000 | ~63 years |
| **BC2** | ~50 PH/s (variable) | 1 in 350 | **~1 year** |
| **BCH2** | ~200 PH/s | 1 in 1,400 | ~4 years |
| **XEC** | ~140 PH/s | 1 in 1,000 | ~3 years |

⚠️ These are statistical averages. Real wins happen on day 1 or day 5000 — variance is the nature of solo mining.

## Configuration

### Step 1: Choose your nearest SoloFury region

Use the [Solo Start configurator](https://solofury.com/start/) to auto-detect your location, or pick manually from:

| Region | Hostname Prefix | Best for miners in |
|--------|----------------|---------------------|
| Atlanta (USA East) | (none, default) | US East, Canada East |
| Seattle (USA West) | `pnw-` | US West, Western Canada |
| Frankfurt (EU) | `eu-` | Continental Europe |
| London (UK) | `uk-` | UK, Ireland |
| Tel Aviv (Middle East) | `me-` | Israel, Turkey, UAE |
| Johannesburg (Africa) | `afr-` | South Africa, sub-Saharan |
| São Paulo (LATAM) | `lat-` | Brazil, Argentina, Chile |
| Singapore (SE Asia) | `asia-` | SE Asia, Australia |
| Tokyo (Asia East) | `jp-` | Japan, Korea, Hong Kong, China |

### Step 2: Pick the stratum URL

Format: `stratum+tcp://<region-prefix><coin>.solofury.com:<port>`

Examples for mining BCH:

```
US:    stratum+tcp://bch.solofury.com:7070
EU:    stratum+tcp://eu-bch.solofury.com:7070
JP:    stratum+tcp://jp-bch.solofury.com:7070
```

Examples for mining BTC:

```
US:    stratum+tcp://btc.solofury.com:6060
EU:    stratum+tcp://eu-btc.solofury.com:6060
```

Full stratum URL list: [reference/stratum-endpoints.md](../reference/stratum-endpoints.md)

### Step 3: Bitaxe AxeOS configuration

Open Bitaxe AxeOS web UI (default: `http://192.168.x.x` — check your router DHCP table).

Navigate to **Settings → Pool Settings**:

| Field | Value (BCH example) |
|-------|----------------------|
| **Stratum Host** | `eu-bch.solofury.com` |
| **Stratum Port** | `7070` |
| **Stratum Username** | `<your-wallet-address>.<worker-name>` |
| **Stratum Password** | `x` |
| **Stratum Host (fallback)** | `bch.solofury.com` |
| **Stratum Port (fallback)** | `7071` |

**Example Username for BCH** (use **CashAddr** format with `bitcoincash:` prefix):
```
bitcoincash:qpyouraddressgoeshereexamplenotvalid12345.bitaxe-gamma
```

**Example Username for BTC** (use Bech32 native segwit `bc1q...`):
```
bc1qyourwalletaddressgoeshereexample0123456.bitaxe-gamma
```

⚠️ **Critical for BCH**: always include the `bitcoincash:` prefix in your CashAddr wallet, otherwise some upstream ckpool versions may fall through to Base58 decoding and accept the address as "valid" but generate spurious hash160 in coinbase. SoloFury's fork has this patched, but the safe practice is to use full prefix.

### Step 4: Save and restart

Click **Save**, then go to **Settings → System → Restart**. AxeOS reboots in ~20 seconds.

### Step 5: Verify connection

After restart, return to the AxeOS home page. You should see:

- ✅ **Pool**: connected (green indicator)
- ✅ **Hashrate**: matches your model (1.2 TH/s for Gamma, 500 GH/s for Ultra)
- ✅ **Shares accepted**: incrementing every 10-30 seconds
- ✅ **Best Diff**: gradually increasing

## Worker naming for multiple Bitaxes

If you have multiple Bitaxes mining to the same wallet:

```
qpyouraddressgoeshereexamplenotvalid12345.bitaxe-gamma-1
qpyouraddressgoeshereexamplenotvalid12345.bitaxe-gamma-2
qpyouraddressgoeshereexamplenotvalid12345.bitaxe-ultra-shelf3
```

Each worker name appears separately in the SoloFury dashboard at [solofury.com/pool/](https://solofury.com/pool/) — useful for tracking individual unit performance.

## AsicBoost (version-rolling)

Bitaxe firmware supports BIP320 version-rolling (AsicBoost) out of the box. SoloFury's stratum servers advertise the `version-rolling` mining extension, so AsicBoost is automatically negotiated.

**Effect**: ~13% effective hashrate increase on supporting hardware. No configuration needed.

## Telegram block notifications (optional)

SoloFury offers free Telegram notifications when your worker finds a block or goes offline.

1. Open [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot) on Telegram
2. Send `/start`
3. Send `/register <your-wallet-address>`
4. Get notified instantly when your Bitaxe wins a block or stops sharing

## Troubleshooting

### "Pool: disconnected" or "Connection failed"

- Check your firewall — Bitaxe needs outbound TCP on the stratum port (6060/7070/8080/8585/9090)
- Try the fallback port (next number, e.g. 7071 if 7070 fails)
- Try a different region (closer = lower latency, but any region works)
- Confirm the stratum URL has no typos

### "Shares submitted but not accepted"

- **Most common cause**: wrong username format (missing `bitcoincash:` prefix for BCH, wrong address format for the coin)
- Check your wallet matches the coin you're mining (`bc1q...` for BTC, `bitcoincash:qq...` for BCH, etc.)
- Restart Bitaxe after correcting

### "Hashrate way below expected"

- Bitaxe temperature too high → chip throttling. Check Settings → Stats → ASIC Temp (should be < 75°C)
- Power supply undervolt → use the recommended 5V power brick (≥3A for Gamma)

### "No block in X months — am I doing it wrong?"

No. Variance is the nature of solo mining. With 1 TH/s on BTC, statistical average is ~12,000 years to find a block — but every hash has equal probability. Some Bitaxes have won blocks in days, others mine for years without one. See [SoloFury Blog: Mining Variance & Poisson Math](https://solofury.com/blog/mining-variance-poisson-math/).

## Where to ask for help

- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)
- **Bitaxe official Discord**: [discord.gg/osmu](https://discord.gg/osmu)
- **GitHub Issues** on this repo for documentation improvements

---

[← Back to README](../README.md)
