# ☕ Coffee Shop Sales Analysis – SQL Project  

## 📌 Project Overview  
This project analyzes sales transactions for a coffee shop chain using **MySQL**.  
The goal is to answer key **business questions** around sales performance, orders, quantities sold, product categories, and store locations.  

By cleaning and structuring raw transactional data, the analysis generates insights on:  
- Monthly sales trends  
- Growth/decline patterns (Month-on-Month)  
- Store performance rankings  
- Product category & top-sellers analysis  
- Weekday vs Weekend sales behavior  
- Time-based breakdown (Month, Day, Hour)  

---

## 🗂️ Dataset  
- Table: `coffee_shop_sales`  
- Columns (assumed):  
  - `transaction_id` (INT)  
  - `transaction_date` (DATE)  
  - `transaction_time` (TIME)  
  - `unit_price` (DECIMAL)  
  - `transaction_qty` (INT)  
  - `store_location` (VARCHAR)  
  - `product_category` (VARCHAR)  
  - `product_name` (VARCHAR)  

---

## ❓ Business Questions Answered  
1. **Total Sales Analysis**  
   - Monthly sales totals  
   - Month-on-Month % changes  
2. **Total Orders Analysis**  
   - Monthly order counts  
   - MoM growth/decline in orders  
3. **Total Quantity Sold**  
   - Monthly product quantities sold  
   - MoM change in quantities  
4. **Specific Date KPIs**  
   - Orders, quantities, and sales for a chosen date  
5. **Weekday vs Weekend Sales**  
   - Segment performance comparison  
6. **Sales by Store Location**  
   - Ranking stores by sales revenue  
7. **Daily Sales Analysis**  
   - Average daily sales per month  
   - Daily trends within selected months  
8. **Sales by Product Category**  
   - Category performance per month  
9. **Top Products**  
   - Top 10 overall  
   - Top 10 for Coffee specifically  
10. **Sales by Month, Day, and Hour**  
   - Monthly, weekly, and hourly breakdowns  

---

## ⚙️ Tools & Tech  
- **Database**: MySQL 8.0  
- **Language**: SQL  
- **Documentation**: Word & PDF (auto-generated with Python)  

---

## 📊 Key Insights  
- Sales and orders fluctuate month-to-month, highlighting demand seasonality.  
- Weekends show different purchasing behavior compared to weekdays.  
- Certain store locations and product categories dominate revenue share.  
- Peak hours analysis shows when customers are most active.  

---

## 🚀 How to Use  
1. Clone this repo:  
   ```bash
   git clone https://github.com/yourusername/coffee-shop-sales-sql.git
   ```
2. Import the dataset into MySQL.  
3. Run queries from the `.sql` script.  
4. Check the documentation (`.docx` / `.pdf`) for explanations.  

---

## 📌 Files in this Repo  
- `Coffee shop Sales Analysis.sql` → All SQL queries  
- `Coffee_Shop_Sales_FULL_Documentation.docx` → Word documentation with explanations  
- `Coffee_Shop_Sales_FULL_Documentation.pdf` → (optional) PDF version  
- `README.md` → This file  

---

## 📝 Author  
👤 **Moses**  
- Data Analyst | SQL | Power BI | Python | Excel  
