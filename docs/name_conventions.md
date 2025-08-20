# Name Conventions
This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.
## 📍 Table of Contents
1. [**General Principles**](#general-principles)
2. [**Table Name Conventions**](#table-name-conventions)
    - [Bronze Rules](#bronze-rules)
    - [Silver Rules](#silver-rules)
    - [Gold Rules](#gold-rules)
3. [**Column Name Conventions**](column-name-conventions)
    - [Surrogate Keys](#surrogate-keys)
    - [Technical Columns](#technical-columns)
4. [**Stored Procedure**](#stored-procedure)
---

## 📖 **General Principles**

- **Naming Conventions**: Use snake_case, with lowercase letters and underscores (`_`) to separate words.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.

## 🏷️ **Table Name Conventions**
### 🥉 **Bronze Rules**

- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system. 

### 🥈 **Silver Rules**

- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system. 

### 🥇 **Gold Rules**

- All names must use meaningful, business-aligned names for tables, starting with the category prefix.
- **`<category>_<entity>`**  
  - `<category>`: Describes the role of the table, such as `dim` (dimension) or `fact` (fact table).  
  - `<entity>`: Descriptive name of the table, aligned with the business domain (e.g., `customers`, `products`, `sales`).  

## 🏷️ **Column Name Conventions**
### 🔑 **Surrogate Keys**

- All primary keys in dimension tables must use the suffix `_key`.
- **`<table_name>_key`**  
  - `<table_name>`: Refers to the name of the table or entity the key belongs to.  
  - `_key`: A suffix indicating that this column is a surrogate key.  

### **Technical Columns**

- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.
- **`dwh_<column_name>`**  
  - `dwh`: Prefix exclusively for system-generated metadata.  
  - `<column_name>`: Descriptive name indicating the column's purpose.  

## 📦 **Stored Procedure**

- All stored procedures used for loading data must follow the naming pattern:
- **`load_<layer>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.