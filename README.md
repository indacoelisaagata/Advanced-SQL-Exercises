# 📊 Advanced SQL Exercises: Data Insights & Business Intelligence

Welcome to my SQL repository! This project features a collection of advanced scripts designed to solve complex data problems and simulate real-world business scenarios. My focus is on query efficiency, clean code, and advanced data manipulation.

---

## 📌 Project Objective & Academic Background
As a 2nd-year **Computer Engineering** student, I developed these exercises to bridge the gap between academic theory and practical application.

The skills showcased in this repository were acquired during the first module of my **Database course**. I am proud to highlight that I achieved a perfect score of **30/30 in the mid-term examination**, which focused on:
* **Relational Algebra & Calculus**
* **Database Design (ER and Logical models)**
* **Advanced SQL Querying**

This project serves as a portfolio to demonstrate my ability to apply these theoretical principles to complex, real-world data challenges.

---

## 🚀 Technical Skills Demonstrated
* **Window Functions:** Advanced analytical patterns including `DENSE_RANK()` for competitive ranking and cumulative sums for Time Series analysis.
* **Programmable Logic:** Development of **Stored Procedures** with IN/OUT parameters and **Triggers** for real-time data validation and security.
* **Performance Tuning:** Optimization of query execution using `EXPLAIN` plans and **B-Tree Indexing** to reduce computational complexity ($O(N)$ vs $O(logN)$ ).
* **Query Refactoring:** Transforming suboptimal nested subqueries into efficient, readable **CTEs (Common Table Expressions)**.
* **Data Integrity:** Implementation of complex `CHECK` constraints and `ACID` principles in real-world booking and financial systems.

---

## 📁 Repository Structure
Each directory contains the core logic (`.sql`) and its corresponding setup script (`setup.sql`) for full reproducibility in **XAMPP/MariaDB**:

```text
├── 01-Window-Functions/
│   ├── 01-Window-Functions-Example/
│   │   ├── 01_window_functions_example.sql  # Ranking & Partitioning logic
│   │   └── 01_setup.sql                     # Dataset: Movie Rentals
│   └── 02-Running-Total-Payments/
│       ├── 02_running_total_payments.sql    # Time-series cumulative analysis
│       └── 02_setup.sql                     # Dataset: Daily Transactions
│
├── 02-Stored-Procedures-and-Triggers/
│   ├── 03-Customer-Loyalty/
│   │   ├── 03_customer_loyalty_procedure.sql # IF-THEN-ELSE loyalty logic
│   │   └── 03_setup.sql                      # Dataset: Customer Payments
│
├── 03-Performance-Optimization/
│   └── 04-Indexing-and-Execution/
│       ├── 04_indexing_and_execution_plan.sql      # EXPLAIN & B-Tree testing
│       └── 04_setup.sql                            # Dataset: High-volume System Logs
│
├── 04-Real-World-Projects/
│   └── 05-Coworking-Booking-System/
│       ├── 05_coworker_booking_system.sql   # Conflict prevention & Views
│       └── 05_setup.sql                     # Dataset: Room Reservations
│   └── 06-Fintrack-Engine/
│       ├── 06_fintrack_sql_engine.sql       # P&L Analysis & Security Trigger
│       └── 06_setup.sql                     # Dataset: Asset Transactions
│
├── 05-Query-Refactoring/
│   └── 07-Query-Optimization/
│       ├── 07_query_refactoring.sql         # Subquery vs CTE Performance
│       └── 07_setup.sql                     # Dataset: Global Sales Metrics
```

---

## 🛠️ Tech Stack & Tools
* **Database Engine:** MySQL 8.0+ / MariaDB (via **XAMPP** environment)
* **Environment:** Localhost development with Apache & MariaDB
* **Core Concepts:** Relational Database Design, Data Normalization (3NF), Performance Tuning
* **Management Tools:** phpMyAdmin, DBeaver, or any standard SQL editor

---

## ✍️ Author
**Elisa Agata Indaco** *Computer Engineering Student (2nd Year)*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/elisa-agata-indaco) 
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/indacoelisaagata)

---
*Developed to bridge academic theory with Software Engineering practice.*
