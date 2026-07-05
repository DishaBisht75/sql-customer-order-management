# SQL Customer Order Management

SQL project analyzing a customer-agent-order management schema — includes schema design, joins, aggregations, subqueries, and views to answer business questions around sales, outstanding payments, and agent performance.

## Business Context

A company sells through a network of sales agents, each managing a set of customers who place orders. This project builds the underlying relational schema and writes SQL queries to answer the kind of questions a sales or business analyst would actually be asked: Which agents are top performers? Which customers carry the most outstanding balance? Which cities generate the most revenue?

## Schema

**Database:** `cdms` (Customer Database Management System)
**RDBMS:** MySQL

| Table | Key Columns | Description |
|---|---|---|
| `Agents` | AGENT_CODE (PK), AGENT_NAME, WORKING_AREA, COMMISSION, PHONE_NO, COUNTRY | Sales agents and their commission rates |
| `Customer` | CUST_CODE (PK), CUST_NAME, CUST_CITY, GRADE, OPENING_AMT, RECEIVE_AMT, PAYMENT_AMT, OUTSTANDING_AMT, AGENT_CODE (FK) | Customers and their account balances |
| `Orders` | ORD_NUM (PK), ORD_AMOUNT, ADVANCE_AMOUNT, ORD_DATE, CUST_CODE (FK), AGENT_CODE, ORD_DESCRIPTION | Orders placed by customers |

**Relationships:**
- `Customer.AGENT_CODE` → `Agents.AGENT_CODE` (each customer is managed by one agent)
- `Orders.CUST_CODE` → `Customer.CUST_CODE` (each order belongs to one customer)

## Queries Included

The `.sql` file walks through schema setup (primary/foreign keys, column type fixes) followed by 15+ business questions, including:

- Customer details joined with their assigned agent
- Agents whose total order value exceeds a threshold (`GROUP BY` + `HAVING`)
- A reusable `VIEW` joining orders, agents, and customers
- City-level filtering (e.g. customers/orders in New York)
- Order counts per agent
- Customers who paid a large advance relative to order size
- City-wise customer count and total outstanding balance
- `LEFT JOIN` to include customers with zero orders
- Highest-value order lookup (via `ORDER BY LIMIT` and via subquery)
- Customers with more than 2 orders (via `HAVING` and via subquery `IN`)
- Date-filtered orders (specific month/year, date range logic)
- Combined `AND`/`OR` filtering across tables
- Agents serving more than 3 distinct customers (`COUNT(DISTINCT ...)`)
- Customers with high outstanding balance despite having made payments
- A correlated subquery identifying customers whose order exceeded their own average order value
- Pagination example using `LIMIT`/`OFFSET`

## Tech Stack

- MySQL
- Standard SQL (joins, subqueries, views, aggregate functions, date functions)


## How to Run

1. Create the database and tables in MySQL, then import the CSVs (`Agents.csv`, `Customer.csv`, `orders.csv`) into their respective tables — via MySQL Workbench's Table Data Import Wizard, or `LOAD DATA INFILE`.
2. Run `sql/code.sql` to set up constraints and execute the analysis queries.

```bash
mysql -u root -p < sql/code.sql
```

## Key Insights

- A small number of agents account for a disproportionate share of total order value, identifiable directly via the agent revenue query.
- Several customers carry high outstanding balances even after making payments — a useful flag for collections follow-up.
- New York and a handful of other cities stand out in both customer count and total outstanding amount, suggesting geographic concentration of risk and revenue alike.

## Author

Disha Bisht - www.linkedin.com/in/disha-bisht-00255935a
