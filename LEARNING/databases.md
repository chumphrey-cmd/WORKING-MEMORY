# PostgreSQL

> [!NOTE]
> Agnostic concept when dealing with information and large data...
> * `C`reate
> * `R`ead
> * `U`pdate
> * `D`elete

## Relational Databases
* Relational (SQL-based, e.g., MySQL, PostgreSQL): Organized in tables with rows (records) and columns (fields). Data links via keys for efficiency and integrity.
    * Enforce structure (schema), rules like no duplicates, and ACID compliance (ensures safe transactions).
    * Best for structured data with relationships, like linking user credentials to orders.

### Terminology (Database Tables)

* `Tables` - the specific objects inside of a database that can be infinitely complex depending on the structure of the data you want organize.
* `Row` - the unique set of information within the table that are comprised of unique cells
* `Columns` - the titles of header of the table the describe what is included inside of the table
* `Cells` - the specific block or set of information that is contained within the table. The individual cross-section within the column or row.
* `Primary Key` - unique identifier that is used to identify the specific row (should always be **serial**); it's the left most identifier in the table (e.g., `customer_id`)
* `Foreign Key` - identifier that points to another table using that tables `Primary Key`
* Unique Key - a key agnostic to other keys (Primary and Foreign) that have been generated, used to verify than an operation has been completed...used to avoid redundancy within tables.
* `views (temporary tables)` - essentially a temporary table that is generated to demo or prototype data creation. Can be used as a `function` to avoid repeating 

<img src="./images/primary_foreign_key.png" width="500">

* `Composite Key` - used to combine two different fields
* `Non-primary Key` (unique key) - 
* `Index` - catalog for faster searches on columns (like a book's index).

### Terminology (PostgreSQL Data Types)

1. https://www.postgresql.org/docs/current/datatype.html

#### Character Types
* `CHARACTER(n)`: Fixed-length character string of length (n).
* `CHARACTER VARYING(n)` (`VARCHAR(n)`): Variable-length character string with a maximum length of (n).
* `TEXT`: Variable-length character string with no specified upper limit.

#### Numeric Types
* `SMALLINT` (`int2`): Signed two-byte integer.
* `INTEGER` (`int`, `int4`): Signed four-byte integer.
* `BIGINT` (`int8`): Signed eight-byte integer.
* `NUMERIC(p,s)` (`DECIMAL(p,s)`): Exact numeric of selectable precision (p) and scale (s).
* `REAL` (`float4`): Single-precision floating-point number (4 bytes).
* `DOUBLE PRECISION` (`FLOAT`, `FLOAT8`): Double-precision floating-point number (8 bytes).
* `SERIAL` (`SERIAL4`): Autoincrementing four-byte integer (alias for `INTEGER` with a sequence).
* `BIGSERIAL` (`SERIAL8`): Autoincrementing eight-byte integer (alias for `BIGINT` with a sequence).

#### Date and Time Types
* `DATE`: Calendar date (year, month, day).
* `TIME[(p)] [WITHOUT TIME ZONE]`: Time of day (no time zone).
* `TIME[(p)] WITH TIME ZONE` (`TIMETZ`): Time of day, including time zone.
* `TIMESTAMP[(p)] [WITHOUT TIME ZONE]`: Date and time (no time zone).
* `TIMESTAMP[(p)] WITH TIME ZONE` (`TIMESTAMPTZ`): Date and time, including time zone.
* `INTERVAL [fields] [(p)]`: Time span.

#### Boolean Types
* `BOOLEAN` (`BOOL`): Logical Boolean value (true/false).

#### Binary Types
* `BYTEA`: Binary data (“byte array”).

#### Other Types
* `BIT(n)`: Fixed-length bit string of length (n).
* `BIT VARYING(n)` (`VARBIT(n)`): Variable-length bit string with a maximum length of (n).
* `MONEY`: Currency amount.
* `UUID`: Universally unique identifier.
* `XML`: XML data.
* `JSON`: Textual JSON data.
* `JSONB`: Binary JSON data, decomposed.

### Terminology (Table Relationships)

1. https://www.red-gate.com/blog/crow-s-foot-notation

* Referential Integrity - a database rule ensuring relationships between tables stay valid, preventing "orphaned records" (like orders for non-existent customers)
* Alter Tables - altering tables after they've been made incorrectly.
* One to Many - one DB to many DBs
* One-to-One - one DB to one DB
* Many-to-Many - many DBs to many DBs
    * e.g., intermediate "views (temporary table)" the interface, "switch", or "core-router" within networks.  

<img src="./images/erd_basics.png" width="500">

## Entity-Relationship Diagram (ERD)
* A visual, structural **blueprint for a database**, illustrating how "entities" (people, objects, concepts) connect within a system
* **ESSENTIALLY** using the desired objective that you want the application to do and arranging and structuring the database in such a way that will allow the application to work...

### Liquor Store Table Conceptual Framework

>[!NOTE]
> Never give a user direct access to the database, only provide **views** to the DB...
>
> When working thinking through ERD mapping use the following:
> * "one `table_a` has "multiple", "single", or "multiple" connection(s) to `table_b`
> * If this logically makes sense, then your ERD should be in good standing...

Customers Table Example
* `Primary Key(s):` **customer_id**; unique identifier that is, used to reference somethgin else, use to identify the row of data unique to that user. **ONLY USE ONE UNIQUE PER ROW**.
* `Columns`: customer_id, date_of_birth, age, gender, cell_phone
    * **NOTE:** naming should be lowercase

Product Table (requires **NF** (normalize formatting))
* `Primary Key(s)`: **product_id**
* `Columns`: upc, qtt, brand, manfacturing, type, distrib, cost

Order Table 
* `Primary Key(s)`: **order_id**
* `Columns`: customer_id, date, cart_id, location_id

Cart Table (table track or reference and ochestrate Product and Order tables)
* `Primary Key`: **cart_id**
* `Columns`: product_id, order_id, custom_qty

Location Table (Customer Shipping)
* `Primary Key`: **location_id**
* `Columns`: address, city, state, zip_code, customer_id


> [!WARNING]
> `DROP` is an irreversible command, BE VERY CAREFUL!


## SQL Basics

### Constraints

* `NOT NULL` – ensures that the values in a column cannot be NULL.
* `UNIQUE` – ensures the values in a column are unique across the rows within the same table.
* `PRIMARY KEY` – a primary key column uniquely identifies rows in a table. A table can have one and only one primary key. The primary key constraint allows you to define the primary key of a table.
* `CHECK` – ensures the data must satisfy a boolean expression. For example, the value in the price column must be zero or positive.
* `FOREIGN KEY` – ensures that the values in a column or a group of columns from a table exist in a column or group of columns in another table. Unlike the primary key, a table can have many foreign keys.

### SQL Command Structure

* Data Definition Language (DDL)
* Data Manipulation Language (DML)
* Data Control Language (or DCL)
* Transaction Control Language (TCL)

#### Data Manipulation Language (DML)
* `UPDATE`: Updates data in a database.
* `DELETE`: Deletes data from a database.
* `INSERT INTO`: Inserts new data into a database.
* `SELECT`: Extracts data from a database.

#### Data Definition Language (DDL)
* `CREATE DATABASE`: Creates a new database.
* `ALTER DATABASE`: Modifies a database.
* `CREATE TABLE`: Creates a new table.
* `ALTER TABLE`: Modifies a table.
* `DROP TABLE`: Deletes a table.
* `CREATE INDEX`: Creates an index (search key).
* `DROP INDEX`: Deletes an index.
* `COMMENT`: Commenting. 
* `TRUNCATE`: Reduce the field length.

### Summary (Databases - 28JAN)