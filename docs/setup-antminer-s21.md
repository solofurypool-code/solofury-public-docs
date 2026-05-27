# Antminer S21+ Solo Mining Setup — SoloFury

> Configure Antminer S21+ (216 TH/s), S21 Pro (234 TH/s), and S21 Hyd (335 TH/s) for solo mining on SoloFury.

## Supported S21 family

| Model | Hashrate | Power | J/TH | Notes |
|-------|----------|-------|------|-------|
| **S21** | 200 TH/s | 3,500 W | 17.5 | Original air-cooled |
| **S21+** | 216 TH/s | 3,564 W | 16.5 | Enhanced air-cooled |
| **S21 Pro** | 234 TH/s | 3,510 W | 15.0 | Best air-cooled efficiency |
| **S21 Hyd** | 335 TH/s | 5,360 W | 16.0 | Hydro-cooled industrial |
| **S21 XP** | 270 TH/s | 3,645 W | 13.5 | 2025 upgrade |

Industrial-class hardware. **Loud (>75 dBA), high power draw (3.5-5.4 kW)** — typically deployed in datacenters or dedicated farms, not homes.

## Solo mining considerations at this scale

With 216 TH/s (S21+), block-finding odds become **statistically realistic** even on BTC:

| Coin | Network Hashrate | Daily Block Odds | Avg Time to Find |
|------|-----------------|-----------------|------------------|
| **BTC** | ~800 EH/s | 1 in 25,500 | ~70 years |
| **BCH** | ~3.5 EH/s | 1 in 130 | **~4-5 months** |
| **BC2** | ~50 PH/s (variable) | 1 in 2 | **~2 days** |
| **BCH2** | ~200 PH/s | 1 in 8 | **~1 week** |
| **XEC** | ~140 PH/s | 1 in 6 | **~5 days** |

S21+ on BC2 finds blocks frequently enough to make solo mining a real income strategy, not just lottery.

## Antminer firmware options

| Firmware | Source | Notes |
|----------|--------|-------|
| **Bitmain stock** | bitmain.com | Default, supports SoloFury out of box |
| **Braiins OS+** | braiins.com | Better autotuning, ~5% more hashrate, easier monitoring |
| **Vnish** | vnish.com | Aggressive overclocking, longer lifespan tuning |
| **LuxOS** | luxor.tech | Open-source, transparent |

All firmwares support standard stratum protocol — SoloFury works with all of them.

## Configuration — Bitmain Stock Firmware

### Step 1: Access miner web UI

Find your miner's IP via your network scan or router DHCP table. Default credentials:

```
User: root
Password: root
```

(Change this immediately after first login if not already done.)

### Step 2: Pool settings

Navigate to **Configuration → General Settings → Pool Settings**:

| Pool | URL | Worker | Password |
|------|-----|--------|----------|
| **Pool 1 (primary)** | `stratum+tcp://bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |
| **Pool 2 (fallback)** | `stratum+tcp://bch.solofury.com:7071` | `<wallet>.<worker>` | `x` |
| **Pool 3 (fallback)** | `stratum+tcp://eu-bch.solofury.com:7070` | `<wallet>.<worker>` | `x` |

⚠️ Set up **3 pools** for proper failover. Antminer firmware switches to Pool 2 if Pool 1 is down for >60 seconds, then tries Pool 3.

**Example worker name** for an S21+ in a farm:
```
1YourWalletAddressGoesHereExample0.s21plus-rack3-unit12
```

### Step 3: Click "Save & Apply"

The miner reboots in ~15 seconds. Stratum negotiation begins immediately.

### Step 4: Verify in Status tab

Within 60 seconds you should see:

- ✅ Pool 1 status: **Alive** (green)
- ✅ Accepted shares: incrementing
- ✅ Rejected shares: 0 or <1% of accepted
- ✅ Average hashrate (5min): ~216 TH/s for S21+

## Configuration — Braiins OS+

Braiins OS+ has a different UI but the same stratum settings apply.

```yaml
# /etc/braiins/config.toml
[pool.0]
url = "stratum+tcp://bch.solofury.com:7070"
user = "1YourWalletAddressGoesHereExample0.s21plus-1"
password = "x"

[pool.1]
url = "stratum+tcp://bch.solofury.com:7071"
user = "1YourWalletAddressGoesHereExample0.s21plus-1"
password = "x"
```

Restart `bosminer.service`:
```bash
systemctl restart bosminer
```

## Wallet address format per coin

| Coin | Address format | Example |
|------|---------------|---------|
| **BTC** | Bech32 (`bc1q...`) preferred | `bc1qyourwalletaddressgoeshereexample0123456` |
| **BCH** | **Legacy (`1...`)** or CashAddr with prefix | `1YourWalletAddressGoesHereExample0` |
| **BC2** | Bech32 (`bc1q...`) | `bc1qbc2addressgoeshereexamplenotvalid01234` |
| **BCH2** | CashAddrII format | `bitcoincashii:qq...` |
| **XEC** | eCash (`ecash:qq...`) or Legacy | `ecash:qq...` |

⚠️ **For BCH**: Antminer firmware sometimes truncates the `bitcoincash:` prefix from CashAddr addresses. **Use Legacy format `1...`** for guaranteed compatibility. SoloFury accepts both, but Legacy avoids any parser ambiguity.

## Performance tuning

### Stale share rate

Antminer S21+ on SoloFury typically shows < 0.5% stale share rate when connected to the geographically nearest region. If stale rate exceeds 2%:

1. Check your network — should have < 30ms ping to chosen SoloFury region
2. Try a closer region (e.g. if you're in EU but using US server, switch to `eu-` prefix)
3. Verify your network MTU is 1500 (jumbo frames sometimes cause stratum issues with industrial ASICs)

### Hashrate stability

S21+ should show ±1% hashrate variance over 24h. Larger swings indicate:
- Inadequate cooling (chip throttling)
- Power supply undervolt (especially if running multiple units on shared PDU)
- Network instability (rare with SoloFury, but possible with consumer ISP)

## Multi-unit deployments

For farms with multiple S21+ units, recommended worker naming pattern:

```
<wallet>.<location>-<rack>-<slot>
<wallet>.atlanta-r3-u12
<wallet>.frankfurt-r1-u01
```

Each unit gets its own worker name, visible separately in [solofury.com/pool/](https://solofury.com/pool/).

## Heat & noise considerations

S21+ at full power:
- **Heat output**: ~12,000 BTU/hr (one unit heats a 200 sqft room significantly)
- **Noise**: ~75-82 dBA (lawn mower territory)

Industrial deployment recommended. For home miners with 1-2 units, consider:
- **Hydro cooling** (S21 Hyd model) — silent, but $$$
- **Immersion in dielectric fluid** — silent, longest ASIC life
- **Dedicated room with ventilation** — most common

## Where to ask for help

- **Bitmain Support**: [bitmain.com/support](https://bitmain.com/support)
- **Braiins Discord**: braiins.com community
- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)

---

[← Back to README](../README.md)
