# Online Retail Database Management & SQL Analysis

## Project Overview
This project explores an online retail database using MySQL. It includes database creation, relational table design, sample data insertion, and SQL queries to answer business questions about products, stores, buyers, sellers, orders, payments, shopping carts, reviews, sales, and inventory.

## Database
- **Database name:** `OnlineRetail`
- **SQL dialect:** MySQL

The database includes tables such as `Users`, `Buyer`, `Seller`, `Store`, `Brand`, `Product`, `Orders`, `OrderItem`, `Contain`, `Payment`, `CreditCard`, `Address`, `Comments`, `Save_to_Shopping_Cart`, and `Manage`.

Primary keys and foreign keys define relationships between entities.

## Project Files
| File | Description |
|---|---|
| `Create_Retail_Database.sql` | Creates the `OnlineRetail` database and tables, defines relationships, and inserts sample data. |
| `Retail_SQL_Analysis.sql` | Contains SQL practice and analysis queries covering basic to advanced concepts. |
| `README.md` | Project documentation and setup instructions. |

## SQL Concepts Covered
- Database and table creation (`CREATE DATABASE`, `CREATE TABLE`)
- Data manipulation (`INSERT`, `UPDATE`, `DELETE`)
- Filtering, sorting, and limiting (`WHERE`, `ORDER BY`, `LIMIT`)
- Aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
- Grouping and filtering groups (`GROUP BY`, `HAVING`)
- Joins (`INNER JOIN`, `LEFT JOIN`)
- Subqueries and correlated subqueries
- Common Table Expressions (CTEs)
- Window functions (`RANK`, `DENSE_RANK`, `SUM() OVER`)
- Views and triggers
- Date functions and string aggregation

## Business Questions Explored
- Which products are ordered most frequently?
- Which brands have the highest average product prices?
- Which products have never received customer reviews?
- What is the total revenue by product or category?
- Which stores have the highest inventory value?
- Which orders contain products from multiple brands?
- What is the cumulative revenue over time?
- Which products generate the highest revenue within each category?

## How to Run
1. Install and open **MySQL Server** and **MySQL Workbench**.
2. Open `Create_Retail_Database.sql` in MySQL Workbench.
3. Execute the script to create the database, tables, relationships, and sample records.
4. Open `Retail_SQL_Analysis.sql` in a new SQL editor tab.
5. Execute analysis queries individually or section by section.
6. Review the result grid for each query.

> Run the database setup script before running the analysis queries because the analysis depends on the `OnlineRetail` database and its tables.

## Notes
- This is an educational SQL portfolio project for practicing relational database management and business analysis queries.
- Some queries may need adjustment if table or column names differ from the final database schema.
- Review and test every query against the created database before using the results in a report or interview.

## Author
**Brijesh Vishwakarma**
