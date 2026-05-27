# cgminer / bfgminer Software Setup — SoloFury

> Configure cgminer or bfgminer (CPU/GPU/ASIC software miners) to solo mine on SoloFury. This guide is for developers, testers, and educational use — not for serious mining ROI.

## When to use software miners

| Use case | Recommended |
|----------|-------------|
| Test SoloFury stratum connectivity | ✅ cgminer (lightweight) |
| Learn how solo mining works | ✅ cgminer or cpuminer |
| Connect FPGA / custom hardware | ✅ cgminer (extensive driver support) |
| Mine on CPU/GPU for actual revenue | ❌ Not profitable on SHA-256 in 2026 |
| Rental hashpower (NiceHash, MRR) | ✅ Direct stratum URL (no miner software needed) |

For real solo mining, use dedicated ASIC hardware (Bitaxe, Antminer, Whatsminer).

## cgminer basic setup

### Install

```bash
# Ubuntu/Debian
sudo apt install cgminer

# Or compile from source for latest version + ASIC driver support
git clone https://github.com/ckolivas/cgminer.git
cd cgminer
./autogen.sh
./configure --enable-bitmain-soc  # or other driver flags
make
sudo make install
```

### Run with command-line args

Basic BCH solo mining:

```bash
cgminer \
  -o stratum+tcp://bch.solofury.com:7070 \
  -u 1YourWalletAddressGoesHereExample0.cgminer-test \
  -p x
```

With multiple pool failover:

```bash
cgminer \
  -o stratum+tcp://bch.solofury.com:7070 \
  -u 1YourWalletAddressGoesHereExample0.cgminer-test \
  -p x \
  -o stratum+tcp://bch.solofury.com:7071 \
  -u 1YourWalletAddressGoesHereExample0.cgminer-test \
  -p x \
  -o stratum+tcp://eu-bch.solofury.com:7070 \
  -u 1YourWalletAddressGoesHereExample0.cgminer-test \
  -p x
```

### Run with config file

Create `cgminer.conf`:

```json
{
  "pools": [
    {
      "url": "stratum+tcp://bch.solofury.com:7070",
      "user": "1YourWalletAddressGoesHereExample0.cgminer-test",
      "pass": "x"
    },
    {
      "url": "stratum+tcp://bch.solofury.com:7071",
      "user": "1YourWalletAddressGoesHereExample0.cgminer-test",
      "pass": "x"
    },
    {
      "url": "stratum+tcp://eu-bch.solofury.com:7070",
      "user": "1YourWalletAddressGoesHereExample0.cgminer-test",
      "pass": "x"
    }
  ],
  "api-listen": true,
  "api-port": "4028",
  "expiry": "120",
  "failover-only": true,
  "log": "5",
  "no-pool-disable": true
}
```

Run:
```bash
cgminer --config cgminer.conf
```

## Stratum URLs for all 5 coins

```bash
# BCH (Bitcoin Cash) — port 7070-7072
stratum+tcp://bch.solofury.com:7070

# BTC (Bitcoin) — port 6060-6062
stratum+tcp://btc.solofury.com:6060

# BC2 (Bitcoin II) — port 8080-8082
stratum+tcp://bc2.solofury.com:8080

# BCH2 (Bitcoin Cash II) — port 8585-8587
stratum+tcp://bch2.solofury.com:8585

# XEC (eCash) — port 9090-9092
stratum+tcp://xec.solofury.com:9090
```

Replace prefix with region: `eu-`, `asia-`, `jp-`, `pnw-`, `uk-`, `me-`, `afr-`, `lat-`. Full list: [reference/stratum-endpoints.md](../reference/stratum-endpoints.md)

## cpuminer (for testing — CPU only)

cpuminer is a pure CPU SHA-256 miner. Useful for testing connection without ASIC hardware.

```bash
# Install
sudo apt install cpuminer

# Or use the multi-algo fork (more current)
git clone https://github.com/JayDDee/cpuminer-opt.git
cd cpuminer-opt
./build.sh
```

Run against SoloFury:
```bash
minerd \
  -a sha256d \
  -o stratum+tcp://bch.solofury.com:7070 \
  -u 1YourWalletAddressGoesHereExample0.cpuminer-test \
  -p x \
  --threads 4
```

⚠️ CPU hashrate: ~10-100 MH/s depending on CPU. **You will not find a block in your lifetime.** This is for testing/learning only.

## bfgminer (forked from cgminer)

Similar to cgminer with additional FPGA support:

```bash
bfgminer \
  -o stratum+tcp://bch.solofury.com:7070 \
  -u 1YourWalletAddressGoesHereExample0.bfgminer-test \
  -p x \
  -S all
```

## NiceHash rental connection

If you're renting SHA-256 hashrate from NiceHash, point it directly to SoloFury:

```
Algorithm: SHA-256
Pool URL:  stratum+tcp://bch.solofury.com:7070
User:      <your-wallet>.nicehash-rental
Password:  x
```

NiceHash's mining client handles the stratum connection — no miner software install needed.

⚠️ **NiceHash difficulty**: NiceHash defaults to high difficulty. SoloFury auto-adjusts. After 5-10 minutes, vardiff settles.

## MRR (Mining Rig Rentals) connection

Same as NiceHash — MRR is a different rental marketplace using identical stratum protocol:

```
Pool Host: bch.solofury.com (or eu-bch.solofury.com, etc.)
Port:      7070
Worker:    <your-wallet>.mrr-rental
Password:  x
Algorithm: sha256
```

See SoloFury blog: [MRR Hashrate Rental for Solo Mining](https://solofury.com/blog/mrr-hashrate-rental/) for ROI math.

## Stratum protocol notes (for developers)

SoloFury speaks **Stratum V1** with extensions:
- ✅ `mining.subscribe` — standard
- ✅ `mining.authorize` — username = wallet address, password = ignored (any value works)
- ✅ `mining.notify` — standard job notification
- ✅ `mining.submit` — share submission
- ✅ `mining.set_difficulty` — vardiff support
- ✅ `mining.configure` with `version-rolling` — AsicBoost (BIP320)
- ❌ Stratum V2 — not yet supported (planned 2027)

## Where to ask for help

- **cgminer official**: [github.com/ckolivas/cgminer](https://github.com/ckolivas/cgminer)
- **r/bitcoinmining**: cgminer/bfgminer threads
- **SoloFury Contact**: [solofury.com/contact/](https://solofury.com/contact/)

---

[← Back to README](../README.md)
