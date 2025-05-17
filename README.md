# 🎨 Art Gallery SQL Project

This is a mini-project designed to practice and demonstrate proficiency with MySQL, including database design, data insertion, querying, and stored functions. The project simulates a database system for managing an art gallery's collection, artists, and exhibitions.

## 📁 Contents

- Database schema setup
- Data population
- SQL queries for insights and reports
- A custom SQL function

---

## 📌 Objectives

This project helps simulate a real-world use case for managing:
- Artists and their backgrounds
- Artworks, including metadata like style and production year
- Exhibitions where artworks are showcased

---

## 🛠️ Database Structure

### Tables

#### 1. `Artists`
Stores information about each artist.
- `Name` (VARCHAR)
- `Artist_id` (PRIMARY KEY, INTEGER)
- `Country` (VARCHAR)
- `IsAlive` (BOOLEAN)

#### 2. `Exhibitions`
Stores information about exhibitions.
- `Exhibition_id` (PRIMARY KEY, INTEGER)
- `Exhibition_name` (VARCHAR)
- `Exhibition_price` (FLOAT)

#### 3. `Artworks`
Links artworks to artists and exhibitions.
- `Artwork_id` (PRIMARY KEY, INTEGER)
- `Title` (VARCHAR)
- `Date_produced` (INTEGER)
- `Artist_id` (FOREIGN KEY to Artists)
- `Movement` (VARCHAR)
- `Exhibition_id` (FOREIGN KEY to Exhibitions)

---

## 🧪 Features & Queries

- Delete specific artworks from the collection
- Retrieve artwork details sorted by date
- List living artists
- Filter exhibitions under a certain price
- Get artworks within a date range
- Find artistic movements starting with a specific letter
- View artist contributions and artwork stats
- Join data across tables for richer context
- Calculate average exhibition prices

---

## ⚙️ Stored Function

Includes a custom SQL function:
```sql
average_price_exhibitions()
```
Returns the average ticket price of all exhibitions, rounded to 2 decimal places.

## 🚀 Getting Started
Create the Database:

sql
Copy
Edit
CREATE DATABASE art_gallery;
USE art_gallery;
Run the SQL file:
Execute the script in any MySQL environment (e.g., MySQL Workbench, DBeaver, or CLI).

## 🧠 Learnings
Designing relational schemas with foreign keys

Applying aggregate functions and grouping

Using string pattern matching (LIKE)

Writing and using stored SQL functions