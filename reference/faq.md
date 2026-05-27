# SoloFury Technical FAQ

> Common questions, troubleshooting, and edge cases.

## General

### What is SoloFury?

SoloFury is a multi-coin SHA-256 solo mining pool. Unlike traditional pools that share block rewards among many miners, solo mining means **the miner who finds the block keeps the entire reward**. SoloFury supports 5 coins (BTC, BCH, BC2, BCH2, XEC) across 9 global regions with a 1% pool fee.

### How is SoloFury different from CKPool, Solo CK, or 2Miners Solo?

| Feature | SoloFury | CKPool (solo.ckpool.org) | Solo CK | 2Miners Solo |
|---------|----------|--------------------------|---------|--------------|
| Coins supported | **5 (BTC/BCH/BC2/BCH2/XEC)** | 1 (BTC) | 1-2 | ~5 (various algos) |
| Pool fee | **1%** | 2% | 2% | 1-2% |
| Regions | **9 global** | 1 (UK) | 2-3 | 4-6 |
| Custody | Non-custodial (direct coinbase) | Non-custodial | Non-custodial | Non-custodial |
| KYC | None | None | None | None |
| Free Telegram alerts | ✅ | ❌ | ❌ | ✅ |
| Frontend dashboard | ✅ (with charts, blog, calculator) | Basic | Basic | ✅ |

### How does solo mining payout work?

When a SoloFury miner finds a block, the block reward is paid via the **coinbase transaction** with two outputs:

1. **99% to the miner's wallet** (the address you used as stratum username)
2. **1% to the pool fee address**

The blockchain itself delivers the reward — SoloFury never holds your coins. You can verify this on any block explorer by looking at the coinbase output of blocks mined by SoloFury (e.g. BCH block [948592](https://blockchair.com/bitcoin-cash/block/948592)).

### Is solo mining profitable?

**Expected value** of solo mining = expected value of pool mining (minus the small pool fee difference). Both pay out the same in the long run.

The **difference is variance**:
- **Pool mining**: small frequent payouts, low variance
- **Solo mining**: zero payouts for long stretches, then a full block reward

For Bitaxe-class miners (~1 TH/s) on BTC, average time to a block is statistically thousands of years — solo mining BTC at that scale is effectively a lottery. On lower-difficulty coins (BC2, BCH2, XEC), realistic monthly block-finding becomes possible.

See [SoloFury Blog: Solo Mining vs Pool Mining](https://solofury.com/blog/solo-mining-vs-pool-mining/) for full math.

## Setup & connectivity

### My miner shows "Pool: disconnected"

Check in order:

1. **Stratum URL typo** — must be `stratum+tcp://<region>-<coin>.solofury.com:<port>`
2. **Firewall** — miner needs outbound TCP on the port (6060/7070/8080/8585/9090)
3. **Try fallback port** — each coin has 3 ports for failover (e.g. 7070, 7071, 7072 for BCH)
4. **Try different region** — sometimes regional routing has temporary issues
5. **Check SoloFury status** — visit [solofury.com/pool/](https://solofury.com/pool/) — if the dashboard loads, the pool is up

### My miner connects but shares are rejected

Most common cause: **wrong wallet format**.

| Coin | Use format | Wrong example | Right example |
|------|-----------|---------------|---------------|
| BTC | `bc1q...` (Bech32) | `bc1qXXX...` (typo) | `bc1qyourwalletaddressgoeshereexample0123456` |
| BCH | **`1...` (Legacy)** | `qpexampleaddr...` (CashAddr no prefix) | `1YourWalletAddressGoesHereExample0` |
| BC2 | `bc1q...` | – | `bc1qbc2addressgoeshereexamplenotvalid01234` |
| BCH2 | `bitcoincashii:qq...` | – | `bitcoincashii:qq...` |
| XEC | `ecash:qq...` | `qpexampleaddr...` (no prefix) | `ecash:qpyouraddressgoeshereexamplenotvalid12345` |

⚠️ **For BCH specifically**: Antminer and Whatsminer firmware sometimes truncate the `bitcoincash:` prefix. **Always use Legacy `1...` format** for BCH on industrial ASICs.

### Why is my hashrate on the dashboard different from my miner's local hashrate?

Two reasons:

1. **Time averaging** — your miner shows instantaneous hashrate; the pool dashboard averages over 5-10 minutes. Wait 15 minutes after connecting before judging displayed hashrate.

2. **Stale shares** — shares submitted after a block has already been found by someone else don't count toward hashrate. A small stale rate (< 1%) is normal; > 5% suggests latency issues (try closer region).

### What's vardiff and why does my difficulty change?

**Vardiff** (variable difficulty) is SoloFury's automatic adjustment of share difficulty based on your hashrate. Goal: submit roughly 1 share every 10-30 seconds.

- Bitaxe (1 TH/s) → vardiff settles around `d=8192`
- NerdQAxe (2.4 TH/s) → `d=16384`
- Antminer S19 (100 TH/s) → `d=131072`
- Antminer S21+ (216 TH/s) → `d=262144`

You can override with `;d=<value>` appended to username, but vardiff is recommended for production.

## Block-finding & coinbase

### How will I know if I find a block?

Three ways:

1. **Pool dashboard** — [solofury.com/pool/](https://solofury.com/pool/) shows "Last Block Found" prominently
2. **Telegram bot** — register at [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot) for instant push notifications
3. **Your wallet** — the coinbase transaction appears in your wallet's incoming transactions (~10 confirmations = 100 minutes to be fully spendable)

### Can I verify the 1% fee on-chain?

Yes. Every SoloFury block has a **2-output coinbase transaction**:
- Output 0: solver address (your wallet) — 99% of reward
- Output 1: pool fee address — 1% of reward

Look up any SoloFury-mined block on a blockchain explorer and inspect the coinbase. Example: BCH block [948592](https://blockchair.com/bitcoin-cash/block/948592).

### What happens if SoloFury finds a block that gets orphaned?

If a block is orphaned (rare, < 0.5% probability under normal conditions), the coinbase doesn't confirm. **The miner does not receive the reward**. This is a blockchain-level event, not a SoloFury issue.

Tip: wait for 6-10 confirmations before considering a block reward "final."

## Network & latency

### Why does my Bitaxe show 100ms ping but Bitaxe app shows 25ms?

Different measurement methods:

- **Bitaxe firmware ping** — measures stratum `notify→submit` round-trip time. With aggressive TCP keepalive optimization (60s), typically shows ~25ms.
- **cgminer-style ping** — measures TCP `SYN→SYN-ACK` time. Shows actual physical RTT, which depends on your distance to the chosen region.

Both measurements are correct — they measure different things. Bitaxe firmware ping is the relevant one for stale share probability.

### Is there a way to lower my latency further?

Beyond choosing the geographically nearest region:

1. **Wired ethernet** instead of WiFi (saves 5-20ms jitter)
2. **Quality ISP** — fiber > cable > DSL for low jitter
3. **MTU 1500** (not jumbo frames) — Bitaxe is happiest at standard MTU
4. **Avoid VPN** unless required — VPN adds 20-100ms latency

### What's the maximum latency before mining becomes inefficient?

Empirically:
- **< 50ms**: ideal, < 0.1% stale rate
- **50-150ms**: still fine, < 0.5% stale rate
- **150-300ms**: workable but noticeable stale rate (1-2%)
- **> 300ms**: significant stale share losses (5%+), choose closer region

## Edge cases & known issues

### CashAddr parser fallthrough bug (BCH)

**Symptom**: BCH block reward goes to a different address than your wallet.

**Cause**: Some upstream ckpool versions have a parser bug where bare CashAddr (`qpexampleaddr...` without `bitcoincash:` prefix) falls through to Base58 decoding and "accepts" the address as valid Legacy, then generates a spurious hash160 in the coinbase.

**Fix**: 
- Use **Legacy `1...` format** for BCH wallet on miner config (guaranteed safe)
- Or use full **CashAddr with `bitcoincash:` prefix** (also safe)
- ❌ Never use bare CashAddr without prefix (`q...` alone)

SoloFury's stratum fork has this patched, but defensive wallet format is recommended.

### Telegram bot stops responding

If [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot) goes silent for > 24h:

1. Check bot is alive: send `/ping` — should respond instantly
2. Re-register: `/register <your-wallet>` (idempotent, won't duplicate)
3. If still no response: contact [solofury.com/contact/](https://solofury.com/contact/) — bot logs are checked on report

### Pool dashboard shows 0 miners during my mining

Usually means dashboard cache stale. Hard refresh (Ctrl+F5 / Cmd+Shift+R). If persistent, check your stratum connection on the miner itself — connection may have dropped silently.

## Coin-specific notes

### BC2 (Bitcoin II)

**Most variable difficulty** of all 5 coins. BC2 network hashrate fluctuates 5×-100× depending on hashrate arrival/departure. When difficulty drops, **solo mining odds dramatically improve** for hours-to-days.

See [SoloFury Blog: BC2 Difficulty Drop Window](https://solofury.com/blog/bc2-difficulty-drop-window/) for tactics.

### BCH2 (Bitcoin Cash II)

Newer fork (2024-25 era). Smaller network, lower difficulty than BCH. Solo mining odds significantly better than BCH for the same hashrate.

### XEC (eCash)

**Special fee model**: due to eCash protocol design, only 58% of the block reward goes to the solver (the rest goes to minerfund + staking rewards). SoloFury does **not** add additional pool fee on XEC — the 58% solver portion goes 100% to the miner.

## Privacy & security

### Does SoloFury log my IP address?

Standard nginx access logs are kept for 30 days (operational debugging), then auto-rotated and deleted. No analytics tracking on stratum connections.

### Can I mine over Tor?

Technically yes (stratum is TCP), but expect high latency (>500ms) and degraded share efficiency. Not recommended for production mining.

### What data does SoloFury have about me?

Only:
- Wallet address you connect with
- Worker names you choose
- Hashrate and share statistics (public on dashboard)
- IP address in nginx logs (30 days, then deleted)

**No email, no name, no payment info** — there's nothing to provide because there's no account system.

## Where to get help

- **Documentation issues**: open issue on this repo
- **Mining setup questions**: [solofury.com/contact/](https://solofury.com/contact/)
- **General mining community**: r/BitcoinMining, OSMU Discord [discord.gg/osmu](https://discord.gg/osmu)
- **Telegram bot issues**: contact via solofury.com/contact

---

[← Back to README](../README.md)
