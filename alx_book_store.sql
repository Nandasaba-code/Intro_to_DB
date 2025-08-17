-- =========================================================
--  ALX BOOK STORE DATABASE
-- This is like building a digital filing cabinet for a bookstore.
-- Every table is like a drawer where we keep related information.
-- =========================================================

--  First, create the database (the big cabinet)
CREATE DATABASE IF NOT EXISTS alx_book_store;

-- Tell MySQL we want to work inside this database
USE alx_book_store;

-- =========================================================
-- AUTHORS TABLE
-- This is where we keep information about book authors.
-- Each author gets a unique ID number.
-- =========================================================
CREATE TABLE authors (
  author_id INT AUTO_INCREMENT,    -- ID number (1, 2, 3…)
  author_name VARCHAR(215) NOT NULL, -- Author's full name
  PRIMARY KEY (author_id)          -- author_id is the main identifier
);

-- =========================================================
--  BOOKS TABLE
-- This is where we keep information about books.
-- Each book belongs to one author.
-- =========================================================
CREATE TABLE books (
  book_id INT AUTO_INCREMENT,      -- Unique ID for each book
  title VARCHAR(130) NOT NULL,     -- Book title
  author_id INT NOT NULL,          -- Which author wrote it (link to AUTHORS)
  price DOUBLE NOT NULL,           -- Price of the book
  publication_date DATE,           -- When it was published
  PRIMARY KEY (book_id),
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- =========================================================
--  CUSTOMERS TABLE
-- This is where we store info about our customers.
-- Each customer gets their own unique ID.
-- =========================================================
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT,  -- Unique ID for customer
  customer_name VARCHAR(215) NOT NULL, -- Customer’s name
  email VARCHAR(215) NOT NULL,     -- Email (must be unique)
  address TEXT,                    -- Where they live
  PRIMARY KEY (customer_id),
  UNIQUE (email)                   -- Prevents duplicate emails
);

-- =========================================================
--  ORDERS TABLE
-- Every time a customer buys books, we create an order.
-- =========================================================
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT,     -- Unique ID for each order
  customer_id INT NOT NULL,        -- Who made the order (link to CUSTOMERS)
  order_date DATE NOT NULL,        -- When the order was placed
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =========================================================
--  ORDER_DETAILS TABLE
-- Each order can have multiple books.
-- This table keeps track of which books are in which order.
-- =========================================================
CREATE TABLE order_details (
  orderdetailid INT AUTO_INCREMENT, -- Unique ID for each line item
  order_id INT NOT NULL,            -- Which order it belongs to
  book_id INT NOT NULL,             -- Which book was bought
  quantity DOUBLE NOT NULL,         -- How many copies of the book
  PRIMARY KEY (orderdetailid),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON DELETE CASCADE,              -- If an order is deleted, its details also go
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);
