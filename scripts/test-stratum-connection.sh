#!/usr/bin/env bash
# test-stratum-connection.sh
#
# Test SoloFury stratum endpoint connectivity, latency, and response.
# Tries all 9 regions × 5 coins = 45 endpoints (or filter by region/coin).
#
# Usage:
#   ./test-stratum-connection.sh                    # test all 45 endpoints
#   ./test-stratum-connection.sh --coin bch         # only BCH (9 regions)
#   ./test-stratum-connection.sh --region eu        # only Frankfurt (5 coins)
#   ./test-stratum-connection.sh --coin bch --region eu  # single endpoint
#
# Output: timing + connection status for each endpoint.
# Exit code: 0 if all tested endpoints work, 1 if any failed.
#
# Requires: bash 4+, netcat (nc), curl, jq (optional for JSON output)
#
# SoloFury — https://solofury.com
# License: MIT

set -uo pipefail

# Configuration
TIMEOUT_SECONDS=5

declare -A COIN_PORTS=(
  [bch]=7070
  [btc]=6060
  [bc2]=8080
  [bch2]=8585
  [xec]=9090
)

declare -A REGION_PREFIXES=(
  [us]=""            # Atlanta (default, no prefix)
  [pnw]="pnw-"       # Seattle
  [eu]="eu-"         # Frankfurt
  [uk]="uk-"         # London
  [me]="me-"         # Tel Aviv
  [afr]="afr-"       # Johannesburg
  [lat]="lat-"       # São Paulo
  [asia]="asia-"     # Singapore
  [jp]="jp-"         # Tokyo
)

declare -A REGION_NAMES=(
  [us]="Atlanta (USA East)"
  [pnw]="Seattle (USA West)"
  [eu]="Frankfurt (Europe)"
  [uk]="London (UK)"
  [me]="Tel Aviv (Middle East)"
  [afr]="Johannesburg (Africa)"
  [lat]="São Paulo (LATAM)"
  [asia]="Singapore (Asia SE)"
  [jp]="Tokyo (Asia East)"
)

# Parse arguments
FILTER_COIN=""
FILTER_REGION=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --coin)
      FILTER_COIN="${2,,}"
      shift 2
      ;;
    --region)
      FILTER_REGION="${2,,}"
      shift 2
      ;;
    -h|--help)
      grep '^#' "$0" | head -25
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Use --help for usage."
      exit 1
      ;;
  esac
done

# Validate filters
if [[ -n "$FILTER_COIN" && -z "${COIN_PORTS[$FILTER_COIN]:-}" ]]; then
  echo "Unknown coin: $FILTER_COIN"
  echo "Valid coins: ${!COIN_PORTS[@]}"
  exit 1
fi

if [[ -n "$FILTER_REGION" && -z "${REGION_PREFIXES[$FILTER_REGION]+x}" ]]; then
  echo "Unknown region: $FILTER_REGION"
  echo "Valid regions: ${!REGION_PREFIXES[@]}"
  exit 1
fi

# Test function
test_endpoint() {
  local region_key="$1"
  local coin="$2"
  local prefix="${REGION_PREFIXES[$region_key]}"
  local port="${COIN_PORTS[$coin]}"
  local hostname="${prefix}${coin}.solofury.com"
  local region_name="${REGION_NAMES[$region_key]}"

  # Test TCP connect with timing
  local start_time end_time elapsed_ms
  start_time=$(date +%s%N)
  if timeout "$TIMEOUT_SECONDS" bash -c "echo > /dev/tcp/$hostname/$port" 2>/dev/null; then
    end_time=$(date +%s%N)
    elapsed_ms=$(( (end_time - start_time) / 1000000 ))
    printf "  ✅ %-40s %s:%-5s  %4dms\n" "$region_name" "$hostname" "$port" "$elapsed_ms"
    return 0
  else
    printf "  ❌ %-40s %s:%-5s  TIMEOUT\n" "$region_name" "$hostname" "$port"
    return 1
  fi
}

# Main
echo "SoloFury Stratum Connection Test"
echo "================================="
echo ""

total=0
failed=0

# Determine what to test
coins_to_test=("${!COIN_PORTS[@]}")
[[ -n "$FILTER_COIN" ]] && coins_to_test=("$FILTER_COIN")

regions_to_test=("us" "pnw" "eu" "uk" "me" "afr" "lat" "asia" "jp")
[[ -n "$FILTER_REGION" ]] && regions_to_test=("$FILTER_REGION")

# Run tests grouped by coin
for coin in "${coins_to_test[@]}"; do
  port="${COIN_PORTS[$coin]}"
  echo "Coin: ${coin^^}  (port $port)"
  echo "─────────────────────────────────────────────────────────────────"

  for region in "${regions_to_test[@]}"; do
    total=$((total + 1))
    test_endpoint "$region" "$coin" || failed=$((failed + 1))
  done
  echo ""
done

# Summary
echo "================================="
echo "Tested: $total endpoints"
echo "Failed: $failed endpoints"

if [[ $failed -eq 0 ]]; then
  echo "✅ All endpoints reachable!"
  exit 0
else
  echo "⚠️  Some endpoints failed. Check firewall and network."
  exit 1
fi
