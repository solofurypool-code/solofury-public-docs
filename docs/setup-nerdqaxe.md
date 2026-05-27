# NerdQAxe Solo Mining Setup — SoloFury

> Configure NerdQAxe (2.4 TH/s) and NerdOCTAxe (4.8 TH/s) for solo mining on SoloFury across all 5 supported SHA-256 coins.

## Supported NerdQAxe models

| Model | Chips | Hashrate | Power | J/TH | Recommended for |
|-------|-------|----------|-------|------|-----------------|
| **NerdQAxe** | 4× BM1368 | 2.4 TH/s | ~52 W | ~22 | Quad-chip home miner |
| **NerdOCTAxe** | 8× BM1368 | 4.8 TH/s | ~104 W | ~22 | Octa-chip serious solo |
| **NerdQAxe v2** | 4× BM1370 | 4.8 TH/s | ~68 W | ~14 | Latest BM1370 silicon |

NerdQAxe is an open-source design by [shufps](https://github.com/shufps), running a modified Bitaxe AxeOS firmware adapted for multiple chips on one PCB.

## Better odds vs single Bitaxe

With 2.4 TH/s (NerdQAxe), odds improve roughly 2× vs single Bitaxe Gamma:

| Coin | Daily Block Odds | Avg Time to Find |
|------|-----------------|------------------|
| **BTC** | 1 in 2.3M | ~6,300 years (statistical) |
| **BCH** | 1 in 11,500 | ~31 years |
| **BC2** | 1 in 175 | **~6 months** |
| **BCH2** | 1 in 700 | ~2 years |
| **XEC** | 1 in 500 | ~1.5 years |

With 4.8 TH/s (NerdOCTAxe), divide by 2 again. NerdOCTAxe on BC2 has realistic ~3-month average to find a block — within reasonable solo mining range.

## Configuration

### Step 1: Access AxeOS web UI

NerdQAxe runs the same AxeOS firmware as Bitaxe. Find its IP via your router and open `http://192.168.x.x` in your browser.

### Step 2: Pool settings

Navigate to **Settings → Pool Settings**:

| Field | Value (BCH from EU example) |
|-------|----------------------------|
| **Stratum Host** | `eu-bch.solofury.com` |
| **Stratum Port** | `7070` |
| **Stratum Username** | `<your-wallet-address>.<worker-name>` |
| **Stratum Password** | `x` |
| **Stratum Host (fallback)** | `bch.solofury.com` |
| **Stratum Port (fallback)** | `7071` |

**Recommended worker naming** for multi-chip units:

```
qpyouraddressgoeshereexamplenotvalid12345.nerdqaxe-shelf1
qpyouraddressgoeshereexamplenotvalid12345.nerdoctaxe-rack-A
```

The pool sees all chips on one PCB as a single worker (4 or 8 chips share one stratum connection).

### Step 3: Difficulty (vardiff vs fixed)

NerdQAxe supports both:

- **Variable difficulty (vardiff)** — default, recommended. SoloFury auto-adjusts share difficulty based on your hashrate. NerdQAxe sees `d=8192` or higher.
- **Fixed difficulty** — append `;d=4096` to the username for testing:
  ```
  qpyouraddressgoeshereexamplenotvalid12345.nerdqaxe-shelf1;d=4096
  ```

For NerdOCTAxe (4.8 TH/s), vardiff settles around `d=32768`. Lower difficulty means more frequent shares (useful for debugging) but more network traffic.

### Step 4: Cooling

NerdQAxe/NerdOCTAxe with stock cooling (one 80mm fan) typically runs at:
- 4-chip: ~65-72°C ASIC temp
- 8-chip: ~75-82°C ASIC temp

For sustained 24/7 operation, consider:
- Upgrade to dual fans (parallel airflow)
- Or submerge in mineral oil (immersion cooling — see [SoloFury blog: cooling guide](https://solofury.com/blog/cooling-air-vs-hydro-vs-immersion/))

## AsicBoost on multi-chip

All 4 (NerdQAxe) or 8 (NerdOCTAxe) chips negotiate AsicBoost independently with the stratum server. SoloFury's stratum supports `version-rolling` extension — no config needed, ~13% effective hashrate boost automatic.

## Telegram alerts (recommended for NerdOCTAxe)

With NerdOCTAxe at 4.8 TH/s, blocks become statistically possible in months on smaller coins. Set up Telegram alerts to be notified the moment a block is found:

1. Open [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot)
2. `/start`
3. `/register <your-wallet-address>`

Block notifications include block height, reward, and confirmation status.

## Troubleshooting

### Some chips disconnected, others mining

Check AxeOS dashboard — each chip reports individual hashrate. If 1-2 chips show 0 GH/s:
- Power cycle the unit (chips sometimes fail to negotiate on cold boot)
- Verify PSU rated current (NerdOCTAxe needs ≥ 5V/20A)
- Inspect PCB visually for thermal damage near low-output chip

### Shares accepted on some chips, rejected on others

This is normal — vardiff applies per-chip. Each chip can have slightly different share counts. Total accepted shares per minute should match the unit's total hashrate.

### Pool shows wrong hashrate

Pool stats average over a 10-minute window. After config change, wait 15 minutes before judging displayed hashrate. NerdQAxe will report 2.4 TH/s as ~2,400,000 MH/s.

## Where to ask for help

- **NerdQAxe Discord**: [discord.gg/osmu](https://discord.gg/osmu) (Open Source Miners United)
- **shufps GitHub**: [github.com/shufps/qaxe](https://github.com/shufps/qaxe)
- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)

---

[← Back to README](../README.md)
