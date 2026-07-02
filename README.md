
# Retail Sales Analysis — SQL (PostgreSQL)

## Project Overview
Analysis of retail sales data across 6 South African store locations using PostgreSQL. 
This project simulates a real-world business scenario where management needs insights 
on store performance, product revenue and regional rankings.

## Database Structure
- **stores** — 6 store locations across Durban, Johannesburg and Cape Town
- **products** — 12 products across 4 categories (Groceries, Electronics, Clothing, Health & Beauty)
- **sales** — 30 transactions linking stores and products

## Business Questions Answered
1. Full sales overview across all stores and products
2. Total revenue per store (quantity × price)
3. Top revenue-generating product
4. City with highest total revenue
5. Number of transactions and revenue per store
6. Store performance bands (High, Mid, Low Performer)
7. Stores performing above average revenue
8. Top ranked store per region using CTEs and window functions

## SQL Concepts Used
- INNER JOIN across 3 tables
- Aggregate functions (SUM, AVG, COUNT)
- GROUP BY and HAVING
- CASE statements
- Subqueries and nested subqueries
- CTEs (Common Table Expressions)
- Window Functions (RANK, PARTITION BY)

## Tools
- PostgreSQL 18
- pgAdmin

## Author
Hlumelo Mdubeki — Data Analytics Student, Durban, South Africa
