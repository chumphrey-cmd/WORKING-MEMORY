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

<img src="./images/primary_foreign_key.png" width="500">

* `Composite Key` - used to combine two different 
* `Non-primary Key` - (unique key): ??
* `Index` - catalog for faster searches on columns (like a book's index).

### Terminology (SQL Data Types)

#### Character Types
* `CHAR(n)`: Fixed-length character string with a specified length (n). Padded with spaces if shorter; useful for consistent storage like codes or abbreviations.
* `VARCHAR(...)`: Variable-length character string with a maximum length (255). More efficient for varying text lengths, like names or emails (very efficient in databases)
* `TEXT`: Variable-length string for large amounts of text (up to 65,535 characters in some systems); no fixed max like VARCHAR, ideal for descriptions or articles.

#### Numeric Types
* `INT`: Integer data type (equivalent to INTEGER). Stores whole numbers, typically from -2^31 to 2^31-1 (signed); common for IDs or counts.
* `DECIMAL(p,s)`: Exact numeric data type with precision (p) and scale (s). Precision is total digits, scale is after decimal; e.g., DECIMAL(5,2) for money like 123.45.
* `FLOAT`: Single-precision floating-point number (equivalent to REAL). Approximate values for scientific or imprecise decimals; less accurate than DECIMAL.
* `BIGINT`: Large integer, supporting bigger ranges (e.g., -2^63 to 2^63-1); for very large counts or IDs.
* `SMALLINT`: Smaller integer, typically -32,768 to 32,767; space-efficient for limited ranges.
* `DOUBLE`: Double-precision floating-point number; higher precision than FLOAT for more accurate approximations.

#### Date and Time Types
* `DATE`: Stores calendar dates (year, month, day) without time; format like 'YYYY-MM-DD', e.g., '2026-01-28'.
* `TIME`: Stores time of day (hours, minutes, seconds) without date; format like 'HH:MM:SS'.
* `DATETIME`: Combines date and time; stores values like 'YYYY-MM-DD HH:MM:SS'; useful for events or logs.
* `TIMESTAMP`: Similar to DATETIME but often includes timezone info and auto-updates (e.g., for record creation/modification times).
* `YEAR`: Stores a year value, typically as 4 digits (e.g., 2026) or 2 digits in some systems.

#### Boolean Types
* `BOOLEAN`: Stores true/false values (often 1/0 internally); equivalent to BOOL in some databases; for flags like 'is_active'.

#### Binary Types
* `BINARY(n)`: Fixed-length binary string (bytes) with length (n); for raw binary data like hashes.
* `VARBINARY(n)`: Variable-length binary string with max length (n); similar to VARCHAR but for bytes.
* `BLOB`: Binary Large Object for large binary data like images or files; variants include TINYBLOB, MEDIUMBLOB, LONGBLOB based on size.

#### Other Types
* `ENUM`: A string object with a value chosen from a predefined list (e.g., ENUM('small', 'medium', 'large')); restricts input to valid options.
* `SET`: Similar to ENUM but allows multiple values from a list (e.g., SET('red', 'blue', 'green')); for flags or tags.

### Terminology (Table Relationships)

1. https://www.red-gate.com/blog/crow-s-foot-notation

* Referential Integrity - a database rule ensuring relationships between tables stay valid, preventing "orphaned records" (like orders for non-existent customers)
* Alter Tables - altering tables after they've been made incorrectly.
* One to Many - one DB to many DBs
* One-to-One - one DB to one DB
* Many-to-Many - many DBs to many DBs

<img src="./images/erd_basics.png" width="500">

## Entity-Relationship Diagram (ERD)
* A visual, structural **blueprint for a database**, illustrating how "entities" (people, objects, concepts) connect within a system
* **ESSENTIALLY** using the desired objective that you want the application to do and arranging and structuring the database in such a way that will allow the application to work...

### Liquor Store Table Example 

>[!NOTE]
> Never give a user direct access to the database, only provide **views** to the DB...

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


* Client accesses the database on a server using these terms:
    * Application software
    * Data access API
    * Database management system
    * SQL query and query results

### Summary (Databases - 28JAN)