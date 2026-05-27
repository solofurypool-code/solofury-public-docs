# Antminer S19 Solo Mining Setup — SoloFury

> Configure Antminer S19 series (S19, S19j Pro, S19 XP) for solo mining on SoloFury.

## Supported S19 family

| Model | Hashrate | Power | J/TH | Year |
|-------|----------|-------|------|------|
| **S19** | 95 TH/s | 3,250 W | 34.5 | 2020 |
| **S19 Pro** | 110 TH/s | 3,250 W | 29.5 | 2020 |
| **S19j Pro** | 100-104 TH/s | 3,068 W | 29.5 | 2022 (most popular) |
| **S19j Pro+** | 122 TH/s | 3,355 W | 27.5 | 2023 |
| **S19 XP** | 140 TH/s | 3,010 W | 21.5 | 2023 |
| **S19 XP Hyd** | 257 TH/s | 5,304 W | 20.5 | 2023 |
| **S19k Pro** | 120 TH/s | 2,760 W | 23.0 | 2024 |

S19 series is still widely deployed despite being 4-6 years old. Less efficient than S21 series but cheaper on second-hand market (often < $500 USD for S19j Pro in 2026).

## Solo mining odds at S19 scale

With 100 TH/s (S19j Pro), realistic for individual home/small farm:

| Coin | Network Hashrate | Daily Block Odds | Avg Time to Find |
|------|-----------------|-----------------|------------------|
| **BTC** | ~800 EH/s | 1 in 55,000 | ~150 years |
| **BCH** | ~3.5 EH/s | 1 in 290 | **~10 months** |
| **BC2** | ~50 PH/s (variable) | 1 in 5 | **~5 days** |
| **BCH2** | ~200 PH/s | 1 in 18 | **~3 weeks** |
| **XEC** | ~140 PH/s | 1 in 13 | **~2 weeks** |

S19j Pro on BC2 is one of the most cost-effective solo mining setups in 2026 (used unit ~$400 + ~$300/mo electricity).

## Firmware options

| Firmware | Notes |
|----------|-------|
| **Bitmain stock** | Default, works with SoloFury out of box |
| **Braiins OS+** | +5-10% effective hashrate via autotuning, paid feature |
| **Vnish** | Advanced overclocking, popular with miners pushing hashrate limits |
| **LuxOS** | Open-source alternative |

All firmwares speak standard stratum — SoloFury compatible regardless of choice.

## Configuration — Stock Bitmain Firmware

### Step 1: Find miner IP

Use Bitmain's `IPReporter` tool (download from bitmain.com), or check your router DHCP table for devices named like `antminer-xxxx`.

### Step 2: Login

Default credentials (change immediately if not already changed):
```
User: root
Password: root
```

### Step 3: Pool settings

**Configuration → General Settings**:

| Pool | URL | Worker | Password |
|------|-----|--------|----------|
| **Pool 1** | `stratum+tcp://eu-bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |
| **Pool 2** | `stratum+tcp://eu-bch.solofury.com:7071` | `<wallet>.<worker>` | `x` |
| **Pool 3** | `stratum+tcp://bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |

Click **Save & Apply**. Miner reboots in ~15 seconds.

### Step 4: Verify

**Status tab** should show within 60 seconds:

- ✅ Pool 1 Alive (green)
- ✅ Accepted shares incrementing
- ✅ Rejected share rate < 1%
- ✅ 5-min avg hashrate within 5% of expected (e.g. ~100 TH/s for S19j Pro)

## Stratum URL examples by coin

```
# BCH
stratum+tcp://bch.solofury.com:7070           # US East
stratum+tcp://eu-bch.solofury.com:7070        # EU
stratum+tcp://asia-bch.solofury.com:7070      # Asia SE
stratum+tcp://jp-bch.solofury.com:7070        # Asia East

# BTC
stratum+tcp://btc.solofury.com:6060
stratum+tcp://eu-btc.solofury.com:6060

# BC2 (best EV/hashrate for S19)
stratum+tcp://bc2.solofury.com:8080
stratum+tcp://eu-bc2.solofury.com:8080

# BCH2
stratum+tcp://bch2.solofury.com:8585
stratum+tcp://eu-bch2.solofury.com:8585

# XEC
stratum+tcp://xec.solofury.com:9090
stratum+tcp://eu-xec.solofury.com:9090
```

Full list: [reference/stratum-endpoints.md](../reference/stratum-endpoints.md)

## Wallet address notes

| Coin | Format | Critical note |
|------|--------|---------------|
| **BTC** | Bech32 `bc1q...` | Antminer supports both Legacy `1...` and Bech32 |
| **BCH** | **Use Legacy `1...`** | Antminer sometimes truncates CashAddr prefix `bitcoincash:` |
| **BC2** | Bech32 `bc1q...` | Same as BTC |
| **BCH2** | `bitcoincashii:qq...` | Newer CashAddrII format |
| **XEC** | `ecash:qq...` or Legacy | XEC supports both |

⚠️ **For BCH specifically**: if you use CashAddr `q...` format without `bitcoincash:` prefix, older Antminer firmware may truncate or corrupt the address. **Always use Legacy `1...`** to guarantee correct block reward delivery on Antminer.

## Vardiff difficulty

By default, S19 series sees vardiff difficulty around `d=65536` to `d=131072` depending on exact hashrate. SoloFury auto-adjusts.

If you want to force a specific difficulty for testing, append to username:

```
1YourWalletAddressGoesHereExample0.s19jpro-1;d=131072
```

## AsicBoost

S19 series supports BIP320 version-rolling AsicBoost natively. SoloFury stratum servers advertise the extension — automatic ~13% effective hashrate gain. No config needed.

## Heat & power planning

S19j Pro at full power:
- **Heat output**: ~10,500 BTU/hr (one room heater equivalent)
- **Power draw**: 3.07 kW continuous
- **Cost @ $0.10/kWh**: ~$220/month per unit

Plan ventilation, electrical capacity, and ROI carefully before purchase. Use the [SoloFury Solo Mining Calculator](https://solofury.com/calculator/) to estimate block-finding odds and revenue.

## Multi-unit farm setup

For 5-50 S19 units:

```
1YourWalletAddressGoesHereExample0.s19jpro-rack1-u01
1YourWalletAddressGoesHereExample0.s19jpro-rack1-u02
...
1YourWalletAddressGoesHereExample0.s19xp-rack2-u01
```

Each unit visible separately in [solofury.com/pool/](https://solofury.com/pool/) dashboard. Useful for tracking per-unit uptime, efficiency, and hashrate over time.

## Telegram block notifications

Highly recommended at S19+ hashrate level — blocks become statistically likely:

1. Open [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot)
2. `/start`
3. `/register <your-wallet-address>`

You'll get pushed notifications the moment a block is found by any of your registered workers, plus alerts when workers go offline.

## Where to ask for help

- **Bitmain Support**: [support.bitmain.com](https://support.bitmain.com)
- **r/BitcoinMining**: solid community for S19 troubleshooting
- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)

---

[← Back to README](../README.md)
