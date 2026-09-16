# SoloFury Technical FAQ

> Common questions, troubleshooting, and edge cases.

## General

### What is SoloFury?

SoloFury is a multi-coin SHA-256 solo mining pool. Unlike traditional pools that share block rewards among many miners, solo mining means the miner who finds the block keeps the entire reward. SoloFury supports 6 coins (BTC, BCH, BC2, BCH2, XEC, DGB) across 9 global regions with a 1% pool fee.

### How is SoloFury different from CKPool, Solo CK, or 2Miners Solo?

| Feature | SoloFury | CKPool (solo.ckpool.org) | Solo CK | 2Miners Solo |
|---------|----------|--------------------------|---------|--------------|
| Coins supported | 5 (BTC/BCH/BC2/BCH2/XEC) | 1 (BTC) | 1-2 | ~5 (various algos) |
| Pool fee | 1% | 2% | 2% | 1-2% |
| Regions | 9 global | 1 (UK) | 2-3 | 4-6 |
| **Stratum V2** | **✅ BTC, all 9 regions** | ❌ | ❌ | ❌ |
| **TLS stratum** | **✅ all coins, all regions** | ❌ | ❌ | varies |
| Custody | Non-custodial (direct coinbase) | Non-custodial | Non-custodial | Non-custodial |
| KYC | None | None | None | None |
| Free Telegram alerts | ✅ | ❌ | ❌ | ✅ |
| Frontend dashboard | ✅ (with charts, blog, calculator) | Basic | Basic | ✅ |

Most solo pools run on ckpool, which has no Stratum V2 implementation — that is why the list of solo pools offering V2 is very short.

### How does solo mining payout work?

When a SoloFury miner finds a block, the block reward is paid via the coinbase transaction with two outputs:

- 99% to the miner's wallet (the address you used as stratum username)
- 1% to the pool fee address

The blockchain itself delivers the reward — SoloFury never holds your coins. You can verify this on any block explorer by looking at the coinbase output of blocks mined by SoloFury (e.g. BCH block 948592).

With **Stratum V2** you can verify the split *before* spending any hashrate on the block — see [Can I see the coinbase before mining it?](#can-i-see-the-coinbase-before-mining-it) below.

### Is solo mining profitable?

Expected value of solo mining = expected value of pool mining (minus the small pool fee difference). Both pay out the same in the long run.

The difference is **variance**:

- **Pool mining**: small frequent payouts, low variance
- **Solo mining**: zero payouts for long stretches, then a full block reward

For Bitaxe-class miners (~1 TH/s) on BTC, average time to a block is statistically thousands of years — solo mining BTC at that scale is effectively a lottery. On lower-difficulty coins (BC2, BCH2, XEC), realistic monthly block-finding becomes possible.

See [SoloFury Blog: Solo Mining vs Pool Mining](https://solofury.com/blog/solo-mining-vs-pool-mining/) for full math.

## Setup & connectivity

### My miner shows "Pool: disconnected"

Check in order:

1. **Stratum URL typo** — must be `stratum+tcp://<region>-<coin>.solofury.com:<port>`
2. **Firewall** — miner needs outbound TCP on the port: 6060/7070/8080/8585/9090 for V1, **3333/3343 for Stratum V2**, or the TLS variants (plain port with a `1` prefix)
3. **Try fallback port** — each coin has 3 ports for failover (e.g. 7070, 7071, 7072 for BCH)
4. **Try different region** — sometimes regional routing has temporary issues
5. **Check SoloFury status** — visit [solofury.com/pool/](https://solofury.com/pool/) — if the dashboard loads, the pool is up

### My miner connects but shares are rejected

Most common cause: **wrong wallet format**.

| Coin | Use format | Wrong example | Right example |
|------|------------|---------------|---------------|
| BTC | `bc1q...` (Bech32) | `bc1qXXX...` (typo) | `bc1qyourwalletaddressgoeshereexample0123456` |
| BCH | `1...` (Legacy) | `qpexampleaddr...` (CashAddr no prefix) | `1YourWalletAddressGoesHereExample0` |
| BC2 | `bc1q...` | – | `bc1qbc2addressgoeshereexamplenotvalid01234` |
| BCH2 | `bitcoincashii:qq...` | – | `bitcoincashii:qq...` |
| XEC | `ecash:qq...` | `qpexampleaddr...` (no prefix) | `ecash:qpyouraddressgoeshereexamplenotvalid12345` |

⚠️ **For BCH specifically**: Antminer and Whatsminer firmware sometimes truncate the `bitcoincash:` prefix. Always use Legacy `1...` format for BCH on industrial ASICs.

### Why is my hashrate on the dashboard different from my miner's local hashrate?

Two reasons:

1. **Time averaging** — your miner shows instantaneous hashrate; the pool dashboard averages over 5-10 minutes. Wait 15 minutes after connecting before judging displayed hashrate.

2. **Stale shares** — shares submitted after a block has already been found by someone else don't count toward hashrate. A small stale rate (< 1%) is normal; > 5% suggests latency issues (try closer region).

### What's vardiff and why does my difficulty change?

Vardiff (variable difficulty) is SoloFury's automatic adjustment of share difficulty based on your hashrate. Goal: submit roughly 1 share every 10-30 seconds.

- Bitaxe (1 TH/s) → vardiff settles around `d=8192`
- NerdQAxe (2.4 TH/s) → `d=16384`
- Antminer S19 (100 TH/s) → `d=131072`
- Antminer S21+ (216 TH/s) → `d=262144`

You can override with `;d=<value>` appended to username, but vardiff is recommended for production.

## Stratum V2

### How do I connect with Stratum V2?

Use `stratum2+tcp://<region>-btc.solofury.com:3333`, or port `3343` for S21/S23-class machines, and set the authority public key:

```
9cLif4sCxvAz7FBP7GPvYG8Mv586ZhdgNbn3f4PsrM56gboSZEp
```

**Where the key goes depends on your firmware:**

- **AxeOS (Bitaxe) and NerdQAxe** — dedicated `SV2 Authority Pubkey` field
- **Braiins OS+** — appended to the URL path: `stratum2+tcp://eu-btc.solofury.com:3333/9cLif4sCxvAz...`

A URL that looks correct but omits the key fails **silently** on Braiins.

V1 and V2 run on the same hosts, so a mixed fleet can point at one address with nothing to reconfigure.

Full reference: [stratum-endpoints.md](stratum-endpoints.md#stratum-v2) · Step-by-step guide: [solofury.com/guides/stratum-v2-connect/](https://solofury.com/guides/stratum-v2-connect/)

### Which firmware supports Stratum V2?

Three families, as of August 2026:

| Firmware | Hardware | Minimum version |
|----------|----------|-----------------|
| Braiins OS+ | Antminer S9 → S21 XP | 26.07 recommended |
| AxeOS | Bitaxe (all models) | 2.14.0 |
| NerdQAxe firmware | NerdAxe, NerdQAxe+/++, NerdOCTAxe | 1.0.37 |

**Stock Bitmain, stock WhatsMiner, VNish, LuxOS and Canaan firmware are V1-only** — including the S21 and S23. Some builds expose a V2-looking setting that never negotiates a real session, which is worse than offering nothing: the miner looks configured while quietly running V1.

You do not need new hardware. V2 is a firmware capability — the ASIC never changes.

### Why is Stratum V2 BTC only?

The V2 stack talks to the node through Bitcoin Core's IPC mining interface. No other SHA-256 chain implementation currently exposes an equivalent — not Bitcoin Cash Node, not Bitcoin ABC, not the BC2 or BCH2 daemons. BCH, BC2, BCH2 and XEC remain on Stratum V1 with full version-rolling and AsicBoost support.

### I configured V2 but my miner still says V1

A V2 config that falls back to V1 produces **no error** — the miner connects, shares are accepted, the dashboard looks healthy. Check in order:

1. Scheme is `stratum2+tcp://`, not `stratum+tcp://`
2. Authority public key is present (URL path on Braiins, dedicated field elsewhere)
3. Port is 3333 or 3343
4. Firmware meets the minimum version

One wrong character in the key fails the handshake, and several interfaces fall back silently rather than reporting it.

To confirm from the pool side:

```bash
curl -s "https://solofury.com/api-btc/client/YOUR_ADDRESS" | jq '.workers[] | {name, protocol}'
```

Your miner page also shows a PROTOCOL badge per worker — grey for SV1, orange for SV2.

### My Stratum V2 session keeps dropping

**Lower the miner's network MTU to 1400.** V2 handshake messages are larger than V1's and can fragment on paths with PPPoE, double NAT or a VPN where path MTU discovery is broken. This is by far the most common cause of an intermittent V2 session.

### The Extended channel won't open

The V2 spec changed the `OpenExtendedMiningChannel.Success` message in early 2026, and firmware built against the older form may fail to parse the response. Switch to **Standard channels** — you lose coinbase visibility but keep encryption and everything else — and update the firmware when a newer build is available.

### Can I see the coinbase before mining it?

Yes, and this is the strongest guarantee available in solo mining.

With an **Extended channel** and coinbase decoding enabled, your miner receives the actual coinbase transaction template and displays its outputs:

```
Block Header
  Height       963788
  Scriptsig    SoloFury
  Value        3.14278556 BTC

Outputs
  bc1q68eg...vyd2ey      0.03142785 BTC     (1%)
  bc1qavkk...n0tlw9      3.11135771 BTC     (99%)
```

Your own hardware — not the pool dashboard, not a block explorer — is showing you that if this block is found, 99% of the reward is addressed to your wallet. Before a single hash is spent on it.

### Does SoloFury support job declaration?

No. The pool still builds the block templates. If miner-side transaction selection is what you need, Braiins Pool and DEMAND provide it.

For solo mining the practical V2 gains are encryption, lower latency and the coinbase verification above — on a non-custodial solo pool the coinbase already pays you directly, so there is no custody to compromise and no balance to freeze.

## Encryption

### Are stratum connections encrypted?

Yes, in two independent ways.

**TLS** is available on all six coins and all nine regions. TLS ports are the plain port with a `1` prefix:

| Coin | Plain | TLS |
|------|-------|-----|
| BCH | 7070 / 7071 / 7072 | 17070 / 17071 / 17072 |
| BTC | 6060 / 6061 / 6062 | 16060 / 16061 / 16062 |
| BC2 | 8080 / 8081 / 8082 | 18080 / 18081 / 18082 |
| BCH2 | 8585 / 8586 / 8587 | 18585 / 18586 / 18587 |
| XEC | 9090 / 9091 / 9092 | 19090 / 19091 / 19092 |

Plain TCP remains available on the original ports — TLS is opt-in. The [Start wizard](https://solofury.com/start/) has an *Enable TLS encryption* toggle.

**Stratum V2** (BTC) is encrypted end-to-end with the Noise protocol — the same cryptographic foundation as WireGuard — and needs no separate TLS port.

### Why does encryption matter for mining?

On plaintext stratum, anyone controlling part of the network path between you and the pool can read your wallet address and worker names. Block reward security itself comes from the blockchain — the coinbase output is addressed to your wallet regardless — but the connection is worth protecting on its own terms, particularly on residential or shared networks.

## Block-finding & coinbase

### How will I know if I find a block?

Three ways:

1. **Pool dashboard** — [solofury.com/pool/](https://solofury.com/pool/) shows "Last Block Found" prominently
2. **Telegram bot** — register at [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot) for instant push notifications
3. **Your wallet** — the coinbase transaction appears in your wallet's incoming transactions (~10 confirmations = 100 minutes to be fully spendable)

### Can I verify the 1% fee on-chain?

Yes. Every SoloFury block has a 2-output coinbase transaction:

- **Output 0**: solver address (your wallet) — 99% of reward
- **Output 1**: pool fee address — 1% of reward

Look up any SoloFury-mined block on a blockchain explorer and inspect the coinbase. Example: BCH block 948592.

### What happens if SoloFury finds a block that gets orphaned?

If a block is orphaned (rare, < 0.5% probability under normal conditions), the coinbase doesn't confirm. The miner does not receive the reward. This is a blockchain-level event, not a SoloFury issue.

Orphans are excluded from the pool's block list and from luck calculations, so a block that appeared briefly and then vanished was orphaned rather than deleted.

**Tip**: wait for 6-10 confirmations before considering a block reward "final."

## Network & latency

### Why does my Bitaxe show 100ms ping but Bitaxe app shows 25ms?

Different measurement methods:

- **Bitaxe firmware ping** — measures stratum notify→submit round-trip time. With aggressive TCP keepalive optimization (60s), typically shows ~25ms.
- **cgminer-style ping** — measures TCP SYN→SYN-ACK time. Shows actual physical RTT, which depends on your distance to the chosen region.

Both measurements are correct — they measure different things. Bitaxe firmware ping is the relevant one for stale share probability.

### Is there a way to lower my latency further?

Beyond choosing the geographically nearest region:

- **Wired ethernet** instead of WiFi (saves 5-20ms jitter)
- **Quality ISP** — fiber > cable > DSL for low jitter
- **MTU 1500** (not jumbo frames) — standard MTU is where Bitaxe is happiest. The one exception is Stratum V2 on a PPPoE / double-NAT / VPN path, where the larger handshake messages may need MTU 1400 to avoid fragmentation.
- **Avoid VPN** unless required — VPN adds 20-100ms latency

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

- Use Legacy `1...` format for BCH wallet on miner config (guaranteed safe)
- Or use full CashAddr with `bitcoincash:` prefix (also safe)
- ❌ Never use bare CashAddr without prefix (`q...` alone)

SoloFury's stratum fork has this patched, but defensive wallet format is recommended.

### Telegram bot stops responding

If [@SoloFuryAlertsBot](https://t.me/SoloFuryAlertsBot) goes silent for > 24h:

1. Check bot is alive: send `/ping` — should respond instantly
2. Re-register: `/register <your-wallet>` (idempotent, won't duplicate)
3. If still no response: contact [solofury.com/contact/](https://solofury.com/contact/) — bot logs are checked on report

### Pool dashboard shows 0 miners during my mining

Usually means dashboard cache stale. Hard refresh (Ctrl+F5 / Cmd+Shift+R). If persistent, check your stratum connection on the miner itself — connection may have dropped silently.

### A worker shows hashrate but hasn't submitted a share in ages

Rolling hashrate averages decay slowly after a disconnect, so a machine that dropped ten minutes ago can still show a non-zero 1-hour average. Use `lastSeen` (or the *Last share* column) rather than hashrate to judge whether a worker is actually alive.

### My luck is above 100% — is something broken?

No. Luck on SoloFury is **personal, not pool-round**: it resets on blocks found by your address, not on pool-wide rounds. Values above 100% are ordinary solo-mining variance, not a fault. If you are scripting alerts against the API, don't treat > 100% as an error condition.

## Coin-specific notes

### BC2 (Bitcoin II)

Most variable difficulty of all 6 coins. BC2 network hashrate fluctuates 5×-100× depending on hashrate arrival/departure. When difficulty drops, solo mining odds dramatically improve for hours-to-days.

See [SoloFury Blog: BC2 Difficulty Drop Window](https://solofury.com/blog/) for tactics.

### BCH2 (Bitcoin Cash II)

Newer fork (2024-25 era). Smaller network, lower difficulty than BCH. Solo mining odds significantly better than BCH for the same hashrate.

⚠️ Always use the explicit `bitcoincashii:` prefix on your wallet address.

### XEC (eCash)

Special reward split: due to eCash protocol design, only **58% of the block reward** is available to miners at all — the remaining 42% goes to the eCash minerfund (32%) and staking rewards (10%). This is a protocol rule, not a pool policy.

The **1% SoloFury fee applies to the solver's 58%**, same as every other coin. An XEC coinbase therefore has four outputs:

| Output | Share of block | Goes to |
|--------|----------------|---------|
| Solver | ~57.4% | your wallet (99% of the 58%) |
| Pool fee | ~0.58% | SoloFury (1% of the 58%) |
| Minerfund | 32% | eCash protocol |
| Staking | 10% | eCash protocol |

Verifiable on-chain like every other SoloFury block — for example block 963137.

## Privacy & security

### Does SoloFury log my IP address?

Standard nginx access logs are kept for 30 days (operational debugging), then auto-rotated and deleted. No analytics tracking on stratum connections.

### Can I mine over Tor?

Technically yes (stratum is TCP), but expect high latency (>500ms) and degraded share efficiency. Not recommended for production mining.

Note that Stratum V2 and TLS both encrypt the connection end-to-end, which addresses most of what miners typically want Tor for — without the latency cost.

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
- **Telegram bot issues**: contact via [solofury.com/contact/](https://solofury.com/contact/)

---

← [Back to README](../README.md)
