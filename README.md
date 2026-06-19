# 📦 Log Archival & Storage Optimization Automation

## 📌 Project Overview
In production server environments, unmanaged log files can quickly consume root disk space, causing critical service disruptions. I developed this automated Bash utility to enforce storage policies dynamically. The script scans target directories for high-risk files (large logs or obsolete historical data), safely compresses them using Gzip to optimize storage, and migrates them to an isolated archive repository.

## ⚙️ Technical Requirements & Scope
* **Target Criteria 1:** Files exceeding **20MB** in size.
* **Target Criteria 2:** Files older than **10 days**.
* **Core Action:** Compress files natively using `.gz` and relocate to the `/archive` directory.
* **Automation Windows:** Daily background execution without human intervention.

## 🧠 Architectural Logic (The 3 Whys)

| Component | Technical Driver (The Why) | Strategic Goal |
| :--- | :--- | :--- |
| **Gzip Compression** | Server storage and IOPS are expensive and constrained resource assets. | **Storage Optimization:** Decreases targeted log payloads by up to 80% while retaining structural integrity. |
| **Empty Check Validation (`-z`)** | Raw, unhandled execution loops throw system errors or blank alerts. | **Error Handling & Hardening:** Enforces a clean script exit state if no files match the archival parameters. |
| **Cron Job Automation** | Manual structural cleanup is unreliable, high-maintenance, and slow. | **Operational Efficiency:** Guarantees standard system hygiene 24/7 across deployment environments. |

## 🚀 Implementation & Engineering Steps

1. **Sandboxed Testing:** Developed a localized directory environment populating simulated log files of varying size metrics and modification timestamps.
2. **Advanced Stream Filtering:** Utilized the core Linux `find` utility with logical OR operators (`-o`), utilizing dynamic `-mtime` and `-size` operational flags.
3. **Data Piping & Streams:** Configured a secure `while read -r` pipeline structure to dynamically pick and process file buffers line-by-line without overloading core OS shell memory.
4. **Script Hardening:** Integrated structural string checks (`if [ -z "$FILES_LIST" ]`) to prevent cascading runtime errors.

## 📅 Automation & Scheduling (Crontab)
To offload resource constraints during peak hours, the automation script is scheduled to execute daily exactly at midnight:

```bash
0 0 * * * /home/ubuntu/shell-scripting/archive_script.sh

Built with 💻 by Muhammad Ali
