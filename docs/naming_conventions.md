# **Naming Conventions**

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Rules](#bronze-rules)
   - [Silver Rules](#silver-rules)
   - [Gold Rules](#gold-rules)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure](#stored-procedure-naming-conventions)
---

## **General Principles**

- **Naming Conventions**: Use snake_case, with lowercase letters and underscores (`_`) to separate words.
- **Language**: Use English for all names.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.

## **Table Naming Conventions**

### **Bronze Rules**
- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g.: `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system (e.g.: `cust_info`, `prd_info`).
  - Example: 
	- `crm_cust_info` → Customer information from the CRM system.
	- `crm_prd_info` → Production information from the CRM system.

### **Silver Rules**
- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Exact table name from the source system (e.g.: `cust_info`, `prd_info`).  
  - Example: 
	- `crm_cust_info` → Customer information from the CRM system.
	- `crm_prd_info` → Production information from the CRM system.


## **Stored Procedure**

- All stored procedures used must follow the naming pattern:
- **`<layer>_<action>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - `<action>`: Represents the action performing on the given layer, database and table.
  - Example: 
    - `bronze_load` → Stored procedure for loading data into the Bronze layer.
    - `silver_load` → Stored procedure for loading data into the Silver layer.