# System Monitoring & Automation Suite

## Why I Built This

I built this project to understand how Linux monitoring works under the hood. While modern DevOps teams rely on tools like Prometheus, Grafana, and Datadog, I wanted to first learn the fundamentals using Bash scripting and native Linux utilities.

Building this project helped me understand key monitoring concepts, automate system health checks, generate reports, and identify the limitations of custom scripts. It also gave me a deeper appreciation for why dedicated monitoring and observability platforms exist and when they become necessary at scale.


## My Journey

Starting this project was the hardest part. I had no local Linux setup and wasn't sure how to connect AWS services to the idea. Along the way, I faced SSH connection failures because port 22 was blocked on my mobile hotspot, accidentally launched an EC2 instance in the Stockholm region instead of Mumbai, and had to learn AWS Systems Manager (SSM Session Manager) from scratch just to connect to my own server.

A few things genuinely surprised me during this build:

* **rsync only copies changed files**, not everything. This makes backups much faster and more storage-efficient.
* **SSM Session Manager can connect to EC2 without a PEM key or open ports**, using only an IAM role. It felt much cleaner and more secure than traditional SSH access.
* **CloudShell files are not permanent.** This encouraged me to integrate Amazon S3 properly instead of treating backups as optional.

More than the technical implementation, this project taught me how to troubleshoot real-world infrastructure issues, work through AWS configuration mistakes, and build reliable automation step by step.


## What This Project Does

* Monitors CPU, Memory, Disk, and Network usage every 5 minutes using Cron
* Displays color-coded alerts (Green, Yellow, Red) based on configurable thresholds
* Automates log rotation with Gzip compression
* Performs full backups every Sunday and incremental backups from Monday to Saturday
* Uploads backups automatically to Amazon S3
* Generates HTML, CSV, and Text reports
* Provides an interactive terminal dashboard with auto-refresh
* Runs on AWS EC2 and is managed through AWS Systems Manager (SSM Session Manager)


## Screenshots


### Dashboard
<img src="screenshots/dashboard.png" width="600">

### Monitoring
<img src="screenshots/monitor.png" width="600">

### Log Rotation
<img src="screenshots/logrotation.png" width="600">

### HTML Report
<img src="screenshots/report_html.png" width="600">

### S3 Backup
<img src="screenshots/s3bucket.png" width="600">

## Tech Stack

Bash Scripting • Linux • Cron Jobs • rsync • Git & GitHub • AWS EC2 • Amazon S3 • AWS Systems Manager (SSM Session Manager) • HTML Reporting

## Project Structure
```
scripts/
    monitor.sh
    cpu_monitor.sh
    memory_monitor.sh
    disk_monitor.sh
    network_monitor.sh
    dashboard.sh
    log_rotate.sh
    backup_full.sh
    backup_incremental.sh
    backup_s3.sh
    report_text.sh
    report_csv.sh
    report_html.sh
config/
    config.cfg
logs/
reports/
backups/
screenshots/
```

## Setup
```
git clone https://github.com/mdshadab41/system-monitor.git
cd system-monitor
chmod +x scripts/*.sh
nano config/config.cfg
bash scripts/monitor.sh
```
## Cron Schedule
```
*/5 * * * *  monitor.sh            Every 5 minutes
0 * * * *    report_html.sh        Every hour
0 0 * * *    log_rotate.sh         Daily midnight
0 2 * * 0    backup_full.sh        Sunday 2am
0 2 * * 1-6  backup_incremental.sh Mon-Sat 2am
0 3 * * *    backup_s3.sh          Daily 3am
```
## Connect With Me

* 🌐 GitHub: https://github.com/mdshadab41
* 💼 LinkedIn: https://www.linkedin.com/in/md-shadab-a52981130

