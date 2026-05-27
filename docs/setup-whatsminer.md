# Whatsminer Solo Mining Setup — SoloFury

> Configure Whatsminer M-series (M30S++, M50, M53, M60, M63) for solo mining on SoloFury.

## Supported Whatsminer models

| Model | Hashrate | Power | J/TH | Year |
|-------|----------|-------|------|------|
| **M30S++** | 112 TH/s | 3,472 W | 31.0 | 2020 |
| **M50** | 118 TH/s | 3,304 W | 28.0 | 2022 |
| **M53** | 226 TH/s | 6,780 W | 30.0 | 2022 (hydro) |
| **M60** | 172 TH/s | 3,440 W | 20.0 | 2023 |
| **M63** | 366 TH/s | 7,250 W | 19.8 | 2024 (hydro flagship) |
| **M66** | 298 TH/s | 5,513 W | 18.5 | 2024 |

Whatsminer (by MicroBT) is the second-largest SHA-256 ASIC manufacturer after Bitmain. Particularly popular in China and Russia. Generally cheaper than Bitmain equivalents on Chinese reseller market.

## Configuration — Whatsminer Web UI

### Step 1: Find miner IP

Whatsminer broadcasts MDNS hostnames like `whatsminer-XXXXX.local`. Most modern routers/devices can resolve these. Otherwise check DHCP table.

### Step 2: Login

Default credentials:
```
User: admin
Password: admin
```

Change immediately after first login. (Old M30S units shipped with `root/root`.)

### Step 3: Pool settings

Navigate to **Configuration → Pool Settings** (or **Mining → Pool**):

| Slot | URL | Worker | Password |
|------|-----|--------|----------|
| **Pool 1** | `stratum+tcp://eu-bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |
| **Pool 2** | `stratum+tcp://eu-bch.solofury.com:7071` | `<wallet>.<worker>` | `x` |
| **Pool 3** | `stratum+tcp://bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |

Click **Apply** (or **Save & Restart Miner**). Whatsminer reboots in ~20 seconds.

### Step 4: Verify in Status

**Status → Pool Status** should show within 60 seconds:

- ✅ Pool 1: Connected (green)
- ✅ Diff: vardiff set to your hashrate band
- ✅ Accepted/Rejected ratio: > 99%
- ✅ HW Errors: 0 or very low

## API mode (optional, advanced)

Whatsminer firmware supports a JSON API for monitoring. To check stratum status programmatically:

```bash
# Get miner summary
echo '{"command":"summary"}' | nc <miner-ip> 4028

# Get pool status
echo '{"command":"pools"}' | nc <miner-ip> 4028
```

Useful for farm-wide monitoring scripts.

## Wallet format per coin

Same rules as other ASICs:

| Coin | Recommended format |
|------|-------------------|
| **BTC** | Bech32 `bc1q...` |
| **BCH** | **Legacy `1...`** (avoid CashAddr ambiguity on older firmware) |
| **BC2** | Bech32 `bc1q...` |
| **BCH2** | `bitcoincashii:qq...` |
| **XEC** | `ecash:qq...` |

⚠️ **Older Whatsminer firmware (pre-2023)** may have stricter address validation than newer Antminer units. **Always use Legacy `1...` format for BCH** to avoid edge cases.

## Stratum URL examples

```
# Coin priority based on hashrate (M50 = 118 TH/s)
# BC2 best ROI on solo (~5 days avg block)
stratum+tcp://bc2.solofury.com:8080
stratum+tcp://eu-bc2.solofury.com:8080
stratum+tcp://asia-bc2.solofury.com:8080

# BCH (~10 months avg)
stratum+tcp://bch.solofury.com:7070

# BTC (lottery scale)
stratum+tcp://btc.solofury.com:6060
```

Full list: [reference/stratum-endpoints.md](../reference/stratum-endpoints.md)

## Whatsminer-specific tweaks

### TCP socket reuse (Whatsminer setting)

Some older Whatsminer firmware aggressively recycles TCP sockets, which can cause sporadic stratum disconnects. If you see frequent reconnects in logs:

1. Update firmware to latest version
2. Try connecting to a closer SoloFury region (lower RTT reduces timeout sensitivity)
3. As workaround, use Pool 1 + Pool 2 + Pool 3 in same region for instant failover

### Power Mode

Whatsminer has 3 power modes:

| Mode | Effect |
|------|--------|
| **Low Power** | -15% hashrate, -25% power → best J/TH efficiency |
| **Normal** | Default (advertised hashrate) |
| **High Performance** | +10% hashrate, +20% power → highest revenue per unit |

For solo mining, choose **Low Power** unless you have very cheap electricity. Block-finding is probabilistic — extra hashrate marginally improves odds, but extra power consumption is guaranteed cost.

## AsicBoost

Whatsminer M-series supports AsicBoost (`version-rolling` extension). SoloFury stratum advertises it automatically — ~13% effective boost, no config needed.

## Multi-unit setups

Standard worker naming pattern:

```
1YourWalletAddressGoesHereExample0.m50-shed-A-01
1YourWalletAddressGoesHereExample0.m50-shed-A-02
1YourWalletAddressGoesHereExample0.m60-shed-B-01
```

Each unit visible separately in [solofury.com/pool/](https://solofury.com/pool/).

## Telegram alerts

Register your wallet for instant block + worker offline notifications:

1. Open [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot)
2. `/start`
3. `/register <your-wallet-address>`

## Heat & power planning

| Model | Heat output | Cooling needed |
|-------|------------|----------------|
| M30S++/M50 (3.3-3.5 kW air) | ~11,500 BTU/hr | Dedicated room with exhaust |
| M53/M63 (hydro) | Liquid heat exchanger | Plumbing infrastructure |
| M60 (3.4 kW air) | ~11,500 BTU/hr | Dedicated room with exhaust |

Hydro models (M53, M63) are quieter and run cooler but require a CDU (Coolant Distribution Unit) and proper plumbing — typically datacenter deployment only.

## Where to ask for help

- **Whatsminer Service** (MicroBT official): [whatsminer.com/support](https://whatsminer.com/support)
- **r/BitcoinMining**: Whatsminer-specific threads
- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)

---

[← Back to README](../README.md)
