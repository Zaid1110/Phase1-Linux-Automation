# Phase 1 — Linux Automation: System Health Monitor

**Author:** Zaid Aftab
**Repo:** Phase1-Linux-Automation  
**Purpose:** Demonstrate Linux automation basics — a Bash health-check script, simple self-healing behavior, logging, and evidence of working automation on an AWS EC2 instance.

---------

## What this project does
- Collects CPU load averages, disk usage, and memory usage.
- Checks `nginx` service status and attempts an automated restart.
- Logs structured output to `/home/ubuntu/health.log`.
- Designed to be demonstrative of basic monitoring & automation practices used in real operations teams.

## Files
- `system_health.sh` — executable Bash script (primary artifact)
- `.github/workflows/lint.yml` — GitHub Action to lint shell scripts (CI)
- `screenshots/` — sample logs and output captured on the lab instance

## How to run (on Ubuntu 22.04 EC2)
1. Make executable:
```bash
chmod +x system_health.sh
