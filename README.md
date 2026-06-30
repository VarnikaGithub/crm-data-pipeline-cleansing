# CRM Data Cleansing and Validation Pipeline 🚀

An end-to-end SQL-based data cleansing and validation pipeline designed to ingest raw, messy Customer Relationship Management (CRM) data and output high-quality, actionable customer profiles. 

This project simulates a production-grade data engineering task: taking raw user attributes (with real-world formatting anomalies, typos, and dummy placeholders) and standardizing them into verified `Valid` or `Invalid` records using MySQL regex and contextual lookup tables.

---

## 📌 Project Overview
Bad data costs businesses money and skews analytics. This project implements a rigorous sanitation layer for user contact info (`mobile` and `email`), utilizing a metadata-driven approach with a country routing table to identify genuine leads and filter out duplicates, fake profiles, and formatting noise.

---

## 🛠️ Tech Stack & Concepts
* **Database Engine:** MySQL
* **Key Techniques:** Regular Expressions (`REGEXP`, `REGEXP_REPLACE`), Window Functions / Aggregations, Conditional Logic (`CASE WHEN`), Join-based validation logic.
* **Architecture:** Ingestion Layer ➡️ Formatting Layer ➡️ Domain Correction Layer ➡️ Validation Routing.

---

## 🏗️ Database Schema & Architecture

The pipeline processes data using two primary tables:
1. `customers_c4c`: The main customer directory containing raw source values, cleaned staging targets, and descriptive statuses.
2. `country_codes`: A static configuration metadata table storing country calling rules to validate localized phone string lengths dynamically per country.

### System Flow
1. **Extraction / Standardization**: Strip symbols, unify casing, and isolate core data from user noise (e.g., telephone text extensions like `ext 104`).
2. **Domain Healing**: Autocorrect common email typos (e.g., `gmel.com` ➡️ `gmail.com`).
3. **Regex Routing**: Evaluate syntax formats against strict regulatory rules.
4. **Final Evaluation (`record_status`)**: Business logic safely determines if the record is usable for multi-channel targeting.

---

## 🧼 Cleansing Strategies Implemented

### 1. Mobile Number Optimization
* **Extension Extraction:** Separates legitimate local numbers from extension notes (e.g., `+1 770-675-3661 ext 104` ➡️ `+17706753661`). Flags excessively long extensions (`> 5 digits`) as outright invalid telemetry.
* **Character Strip & Country Appending**: Scrubs spaces, dots, dashes, and scientific notation errors (`6.27E+09`). Fallback rules automatically prepend `+91` to clean, unformatted 10-digit Indian mobile segments.
* **Dynamic Length Rule Validation**: Joins cleaned elements with `country_codes` dynamically checking if `(Total Length - Country Code Digits) == Expected Mobile Length`.

### 2. Email Sanitization & Healing
* **Leading Symbol Trimming**: Strips unintended prefix symbols like `#`, `_`, `-`, or `.`.
* **Heuristic Typo Correction**: Matches and updates over 12 common enterprise/consumer domain typos (e.g., `gmial`, `gmaill`, `yaho`, `outllok`, `rediff`).
* **Disposable & Placeholder Blocking**: Automatically flags throwaway temporary domains (`@mailinator.com`, `@tmpnator.live`) and fake internal system configurations (`@na.com`, `@dummy.com`).
* **Phonetic/Numeric Guardrails**: Drops spam entries where numeric strings form the local part identifier directly before the domain host separator (e.g., `12345678@...`).

### 3. Business Rules for Target Quality (`record_status`)
A record is marked usable (`Valid`) if it possesses at least a functional mobile identity framework, accepting edge cases where a phone number is perfectly active but an email could not be safely salvaged:

$$
\text{Record Status} = 
\begin{cases} 
\text{Valid}, & \text{if } \text{Mobile} = \text{'Valid'} \text{ AND } \text{Email} \in \{\text{'Valid'}, \text{'Invalid'}\} \\ 
\text{Invalid}, & \text{otherwise} 
\end{cases}
$$

---

## 📈 Analysis & Metrics Summary
Running the evaluation matrix groupings provides a quick summary profile of our CRM database quality:

```sql
SELECT
  mobile_status,
  email_status,
  record_status,
  COUNT(*) AS total
FROM customers_c4c
GROUP BY mobile_status, email_status, record_status
ORDER BY record_status;
