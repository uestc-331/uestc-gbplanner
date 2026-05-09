#!/usr/bin/env bash
set -u

LOG_FILE="${1:-${ROSOUT_LOG:-}}"
if [[ -z "$LOG_FILE" ]]; then
  if [[ -f "$HOME/.ros/log/latest/rosout.log" ]]; then
    LOG_FILE="$HOME/.ros/log/latest/rosout.log"
  else
    echo "usage: $0 /path/to/rosout.log" >&2
    exit 2
  fi
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "log file not found: $LOG_FILE" >&2
  exit 2
fi

echo "GB3 planner log check"
echo "log: $LOG_FILE"

nonfinite_count="$(grep -Eci 'gain=-nan|gain=nan|fw_ratio=inf|direction score.*non-finite|Non-finite direction score|Non-finite gain' "$LOG_FILE" || true)"
lowgain_count="$(grep -Eci 'No valid local exploration path|No positive gain was found|Path REJECTED' "$LOG_FILE" || true)"
accept_count="$(grep -Eci 'Path ACCEPTED|Local completion check|Global frontier check' "$LOG_FILE" || true)"
complete_count="$(grep -Eci '\[RRG\]\[COMPLETE\]' "$LOG_FILE" || true)"
idle_count="$(grep -Eci '\[PCI\]\[RUN\] idle ready|PCI: Ready to trigger the planner' "$LOG_FILE" || true)"
done_count="$(grep -Eci '\[PCI\]\[EXEC\] path complete|published traj points=' "$LOG_FILE" || true)"

echo "nonfinite_hits: ${nonfinite_count:-0}"
echo "lowgain_hits:   ${lowgain_count:-0}"
echo "accept_hits:    ${accept_count:-0}"
echo "complete_hits:  ${complete_count:-0}"
echo "idle_hits:      ${idle_count:-0}"
echo "done_hits:      ${done_count:-0}"

if [[ "${nonfinite_count:-0}" -gt 0 ]]; then
  echo "warn: non-finite planner scores detected" >&2
  exit 1
fi

if [[ "${lowgain_count:-0}" -gt 0 && "${accept_count:-0}" -eq 0 ]]; then
  echo "warn: only low-gain evidence found, no accepted exploration paths" >&2
  exit 1
fi

exit 0
