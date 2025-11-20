# Phase 1 — Linux Automation: System Health Monitor

**Author:** Zaid Aftab  
**Project goal:** Build a simple, production-style system health monitor script in Bash, automate it via cron on an AWS EC2 Ubuntu instance, and document the process.

## What this does
- Collects CPU load, disk usage, memory usage
- Checks `nginx` service status and attempts restart if stopped
- Logs checks to `/home/ubuntu/health.log`
- Detects high disk usage (>= 80%) and writes an alert to the log

## Files
- `system_health.sh` — main Bash script (executable)
- `README.md` — this file
- `screenshots/` — (screenshots of logs or systemd status)

## How to run (on Ubuntu 22.04 EC2)
1. Make script executable:
```bash
chmod +x system_health.sh

