# 📘 Data Catalog – Gold Layer

The **Gold Layer** is the business-ready data layer designed for reporting, analytics, and business intelligence.  
It is organized in a **Star Schema** with fact and dimension tables.

---

## 📂 Tables Overview

- **gold.dim_customers** → Customer dimension (master data for customers).  
- **gold.dim_products** → Product dimension (master data for products).  
- **gold.fact_sales** → Sales fact table (transactional data with links to customers and products).

---

## 🟨 gold.dim_customers

| Column Name     | Data Type   | Description                                                                 |
|-----------------|-------------|-----------------------------------------------------------------------------|
| `customer_key`  | PK, INT     | Surrogate key for each customer (primary key in this dimension).            |
| `customer_id`   | STRING      | Business identifier of the customer from source systems.                    |
| `customer_number` | STRING    | Customer number/code (external reference).                                  |
| `first_name`    | STRING      | Customer’s first name.                                                      |
| `last_name`     | STRING      | Customer’s last name.                                                       |
| `country`       | STRING      | Country of the customer.                                                    |
| `marital_status`| STRING      | Customer’s marital status. Standardized as: `Single`, `Married`.            |
| `gender`        | STRING      | Gender of the customer.                                                     |
| `birthdate`     | DATE        | Customer’s date of birth.                                                   |
| `create_date`   | DATE        | Date when the customer record was created.                                  |

**Business Notes:**
- `marital_status` is normalized into **Married / Single**.  
- Used for customer analytics and segmentation.  

---

## 🟦 gold.dim_products

| Column Name     | Data Type   | Description                                                                 |
|-----------------|-------------|-----------------------------------------------------------------------------|
| `product_key`   | PK, INT     | Surrogate key for each product (primary key in this dimension).             |
| `product_id`    | STRING      | Business identifier of the product from source systems.                     |
| `product_number`| STRING      | Product number/code.                                                        |
| `product_name`  | STRING      | Name of the product.                                                        |
| `category_id`   | STRING      | Category identifier.                                                        |
| `category`      | STRING      | Product category (e.g., Bikes, Components, Clothing).                       |
| `subcategory`   | STRING      | Product subcategory (e.g., Mountain Bikes, Road Bikes).                     |
| `maintenance`   | STRING      | Indicates whether product requires maintenance (`Yes` / `No`).              |
| `cost`          | DECIMAL     | Cost of the product.                                                        |
| `product_line`  | STRING      | Line of product (e.g., Mountain, Road, Touring, Sales).                     |
| `start_date`    | DATE        | Date when the product was introduced.                                       |

**Business Notes:**
- `maintenance` is standardized as **Yes / No**.  
- Product dimension supports product hierarchy and cost analysis.  

---

## 🟩 gold.fact_sales

| Column Name     | Data Type   | Description                                                                 |
|-----------------|-------------|-----------------------------------------------------------------------------|
| `order_number`  | PK, STRING  | Unique identifier of the sales order.                                       |
| `product_key`   | FK → dim_products | Reference to the sold product.                                      |
| `customer_key`  | FK → dim_customers | Reference to the purchasing customer.                               |
| `order_date`    | DATE        | Date when the order was placed.                                             |
| `shipping_date` | DATE        | Date when the order was shipped.                                            |
| `due_date`      | DATE        | Payment due date.                                                           |
| `sales_amount`  | DECIMAL     | Total sales amount for the order line.                                      |
| `quantity`      | INT         | Number of products sold.                                                    |
| `price`         | DECIMAL     | Unit price of the product.                                                  |

**Business Rules:**
- **Sales Calculation:**  
  `sales_amount = quantity * price`  
- Facts are at the **order line level** (one record per product per order).  

---

## 📊 Relationships

- **gold.fact_sales → gold.dim_customers**  
  Joined via `customer_key`.  

- **gold.fact_sales → gold.dim_products**  
  Joined via `product_key`.  

---

## ✅ Usage Examples

- **Sales Dashboard** → Total revenue, average order value, sales trend by time.  
- **Customer Analytics** → Segmentation by marital status, gender, or country.  
- **Product Performance** → Revenue and profitability by product line or category.  

---