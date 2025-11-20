#!/usr/bin/env bash
# system_health.sh - Robust system health checks for Phase1-Linux-Automation

LOGFILE="/home/ubuntu/health.log"
timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

echo "----------------------------------------" >> "$LOGFILE"
echo "$(timestamp) - Health check start" >> "$LOGFILE"

# CPU load (1 min, 5 min, 15 min from /proc/loadavg)
read load1 load5 load15 rest < /proc/loadavg
echo "$(timestamp) - Load averages: 1min=${load1}, 5min=${load5}, 15min=${load15}" >> "$LOGFILE"

# Disk usage root (human readable)
disk_info=$(df -h / | awk 'NR==2 {print $5 " used, " $4 " available"}')
echo "$(timestamp) - Disk / : ${disk_info}" >> "$LOGFILE"

# Memory (MB)
mem_info=$(free -m | awk 'NR==2 {printf "Used:%sMB Free:%sMB", $3, $4}')
echo "$(timestamp) - Memory: ${mem_info}" >> "$LOGFILE"

# Check nginx service and attempt restart if not running
if systemctl is-active --quiet nginx; then
  echo "$(timestamp) - nginx running" >> "$LOGFILE"
else
  echo "$(timestamp) - nginx stopped. Attempting restart" >> "$LOGFILE"
  sudo systemctl restart nginx >> "$LOGFILE" 2>&1 || true
  if systemctl is-active --quiet nginx; then
    echo "$(timestamp) - nginx restarted successfully" >> "$LOGFILE"
  else
    echo "$(timestamp) - nginx failed to restart" >> "$LOGFILE"
  fi
fi

# Disk threshold alert (log only)
diskpct=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ -n "$diskpct" ] && [ "$diskpct" -ge 80 ]; then
  echo "$(timestamp) - ALERT: / usage at ${diskpct}% (>=80%)" >> "$LOGFILE"
fi

echo "$(timestamp) - Health check end" >> "$LOGFILE"
