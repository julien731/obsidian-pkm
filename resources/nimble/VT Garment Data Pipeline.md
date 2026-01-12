---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-10-09
---

# VT Garment Data Pipeline

# Plan

## **🧩 Phase 1:**

## **Wrangle What You Know**

You don’t need to catalog every table in the DB. You need to **create a usable subset** — a tidy version of the useful data.

---

### **✅ Step 1:**

### **Build a Mini Data Model**

You already know the “good” tables (production, staff, issues, etc.). Use those and ignore the rest like the unindexed, forgotten dreams they are.

Create a clean diagram or list with:

- Table name (actual DB name)
- Business meaning (human speak)
- Join relationships (e.g., jobtran.emp_num → employee.emp_num)
- Rough row count (use COUNT(*))
- Date coverage (MIN(date), MAX(date))

**Deliverable:** A focused, documented mini-model of the **core production dataset**.

---

### **✅ Step 2:**

### **Flatten the Data for LLM Consumption**

LLMs don’t want raw SQL tables. They want:

- Fewer joins
- Fewer nulls
- More context per row
- Less entropy

So you:

- **Create wide tables** that consolidate data. Examples:
    - DailyEmployeeProductionPerformance
    - MachineDowntimeEvents
    - ProductionLineDailySummary
- Include all your useful features:
    - emp_num, style, hours_worked, qty_complete, downtime_minutes, otp, efficiency, rework_rate, etc.

Use **views or temp tables** to prep this stuff. You are building **narrative tables**, not just relational ones.

**This is the LLM food.**

---

### **✅ Step 3:**

### **Give Columns Human-Readable Aliases**

LLMs don’t like Uf_QtyPerson, cjr.oper_num, m0.description.

Create **aliases**:

- QtyPerPerson
- OperationNumber
- CustomerDescription

And save a **column glossary** alongside the table, e.g., as JSON or CSV.

> The more human it looks, the less the LLM screams internally.
> 

---

## **🧠 Phase 2:**

## **Build a Data-to-Text Pipeline**

Your eventual goal is to ask something like:

> “Show me the most common root causes of downtime for Line 7 over the past 3 months”
> 

Which means the LLM will need:

1. A structured format to **understand** the data
2. A way to **retrieve** subsets (or get summaries)
3. Enough **context** to not hallucinate like a drunk oracle

Here’s the plan:

---

### **🔄 Step 4:**

### **Format Data for Context Windows**

Depending on your LLM input limits:

- Use **CSV/JSON** for flat data chunks
- Use **Markdown tables** if you’re summarizing
- Use **database connectors or retrieval-augmented generation (RAG)** if you’re using embeddings

**Chunking strategies:**

- Split by time: “Last 30 days”, “Month-by-month”
- Split by worker/line/machine
- Summarize by metric: avg, sum, anomalies

If you’re prepping this for an **offline prompt or static ingestion**, you’ll want to:

- Summarize per row (or group)
- Annotate the summaries
- Include units, explanations

Example LLM-ingestible row:

```json
{
  "date": "2025-10-01",
  "line": "7SEW01",
  "employee": "ASEW024",
  "hoursWorked": 7.5,
  "qtyProduced": 120,
  "efficiencyPercent": 84.2,
  "mainDowntimeReason": "Material shortage",
  "reworkRatePercent": 3.2
}
```

### **🧠 Step 5:**

### **Consider Using Vector Embeddings for Long-Term Queries**

If you’re actually building an LLM-powered dashboard or assistant:

- Vectorize your **table-level summaries**, column glossaries, and metadata
- Use a RAG setup to allow the LLM to search your indexed data model and answer questions
- Store embeddings of:
    - Descriptions of downtime types
    - Field definitions
    - Common SQL queries

**🔥 Bonus: Tools You Should Consider Using**

| **Tool** | **Purpose** |
| --- | --- |
| **SQLAlchemy or dbt** | For transforming and managing clean data models |
| **Pandas** | For feature engineering and flattening |
| **DuckDB** | If you want to process big data on your laptop like a wizard |
| **LangChain / LlamaIndex** | For feeding data into an LLM via RAG |
| **Airbyte/Fivetran** | If you want to automate pulling from the source database |
| **Retool/Streamlit** | For building interfaces on top of this once it’s ready |

## **🚨 Pitfall Warnings**

- **Do not** shove 10 years of raw jobtran data into a prompt. It will cry. You will cry.
- **Do not** expect the LLM to guess column meanings. Be explicit.
- **Do not** rely on the Excel doc as your data dictionary. Bake definitions into the data.

# Research

## **🤨 “Wait, why not just use SQL Server views?”**

Because **views alone are like duct-tape and hope** — they technically work, but they don’t scale, document, or explain themselves. They’re the *raw* version of what **dbt gives you with some structure, repeatability, and sanity control**.

| **Feature** | **SQL Server Views** | **dbt Models** |
| --- | --- | --- |
| ✅ Can create views | ✔️ | ✔️ (or materialized tables) |
| 🔄 Version control | ❌ (unless you wrap your .sql files in Git and pray) | ✔️ Built-in with Git + file structure |
| 🧾 Inline documentation | ❌ (only via SQL comments, nobody reads them) | ✔️ YAML-based docs shown in UI |
| 🧪 Testing & validation | ❌ | ✔️ dbt test supports unique, not null, relationships, custom tests |
| 🔍 Data lineage / DAG | ❌ | ✔️ Visual lineage of how models build on each other |
| 📦 Layered architecture (staging, intermediate, marts) | ❌ (you *can* do it, but there’s no structure) | ✔️ Convention over chaos |
| 📊 Works with BI tools | ✔️ | ✔️ (output is just tables/views in your DB) |
| 🧠 Standardized patterns for transformations | ❌ | ✔️ (e.g., macros, reusable logic) |
| 🛠️ Easily refactorable | ❌ | ✔️ Modular, readable code by layer |
| 🚨 CI/CD friendly | ❌ | ✔️ Integrates with GitHub Actions, etc. |
| 🤝 Team collaboration | ❌ (unless your team loves naming things view_v6_newNEW.sql) | ✔️ Git + docs + shared models = teamwork dreamwork |

## **The Minimal Viable Data-to-LLM Pipeline**

Here’s the diagram first, then I’ll break it down:

```
[SQL Server] 
   ⬇ (raw data)
[dbt models]  ← versioned, tested, documented transformations
   ⬇
[Transformed Tables / Views] (e.g., fct_downtime_summary, dim_employee)
   ⬇
[Pandas / ETL Script] ← load, flatten, clean
   ⬇
[LLM Interface] (OpenAI API / LangChain / Chatbot / Dashboard Assistant)
```

Now let’s walk through the pieces like a normal person trying not to scream.

---

### **🧩 Step 1:**

### **SQL Server (Raw Data)**

- This is where all the horror lives: jobtran, item, downtime_code, etc.
- Do **not** connect your LLM directly to this. Unless you want it to develop sentience and cry.

---

### **🧩 Step 2:**

### **dbt (Transformation & Lineage)**

Use dbt to:

- Clean cryptic fields (Uf_StopHour → OvertimeStopMinutes)
- Rename and reformat
- Create layered models:
    - stg_jobtran.sql (raw cleanup)
    - int_employee_downtime.sql (calculations)
    - fct_downtime_summary.sql (final wide table)

You now have **LLM-ready tables**. Use materialized: table or view as needed.

---

### **🧩 Step 3:**

### **Transformed Tables in SQL Server**

Example: fct_downtime_summary

| **date** | **emp_id** | **line** | **total_downtime** | **top_reason** | **rework_rate** |
| --- | --- | --- | --- | --- | --- |
| 2025-09-01 | VSEW13 | 7SEW01 | 22 | MM003 | 3.2 |
| … | … | … | … | … | … |

This is your **analysis layer**, shared between:

- Power BI
- LLM (via Pandas or LangChain)

---

### **🧩 Step 4:**

### **Pandas / Python Script (ETL for LLM)**

Use Python to:

- Load transformed tables:

```python
import pandas as pd
import pyodbc

conn = pyodbc.connect("DRIVER={ODBC Driver 17 for SQL Server};SERVER=...;DATABASE=...;UID=...;PWD=...")
df = pd.read_sql("SELECT * FROM fct_downtime_summary", conn)
```

- Optional: Chunk/summarize by date, line, employee
- Output as:
    - **JSON** (for prompt-based LLMs)
    - **Markdown table** (for small summaries)
    - **CSV or Parquet** (if feeding into a vector DB or RAG pipeline)

---

### **🧩 Step 5:**

### **LLM Interface**

You now have a few routes:

### **a. Prompt-based LLM (OpenAI API)**

Use the cleaned data in a prompt like:

> “Here is a table of employee production and downtime records. Based on this, summarize the top issues and suggest improvements.”
> 

Paste in a few rows from df.head(10).to_markdown(), or summarize first.

### **b. RAG (Retrieval-Augmented Generation)**

Embed the cleaned dataset using tools like:

- **LangChain**
- **LlamaIndex**
- **Pinecone / FAISS / Chroma** for embeddings

Then allow queries like:

> “What patterns of downtime occur on Line 7 over time?”
> 

> …and the system will:
> 
- Search relevant rows or summaries
- Feed into the LLM for final natural language response

### **c. Chatbot or Dashboard Assistant**

Hook the LLM up to a Streamlit app or Power BI plugin, allowing natural-language Q&A over the clean dataset.

## Terms & Definitions

| **Layer** | **Tool** | **Purpose** |
| --- | --- | --- |
| Data Storage | SQL Server | Store raw & transformed tables |
| Transformation | dbt + SQL | Clean, document, version |
| Interface Layer | Pandas + Python | Load data, flatten, clean |
| AI Layer | OpenAI / LangChain | Analyze, summarize, suggest |
| Output | Chat, CLI, Dashboard | Interact, visualize, question |

# Project Plan

| Activity | Description | Duration |
| --- | --- | --- |
| Deep dive into the DB | - Identify all relevant tables
- Document each table & **each field** |  |
| Create dbt models & schemas | First stage of preparation for LLM ingestion.

- Create clean data models
- Standardize data types
- Document the whole schemas
- Document data relationships |  |
| Define relevant KPIs & views | - Add logic to generate actionable data for analysis |  |
|  |  |  |