

--1. Total Revenue
select SUM(total_price) AS Total_Revenue
from pizza_sales

--_2. Average order value
Select sum(total_price)/count(distinct order_id) AS Avg_Order_Value from pizza_sales

---3. Total pizzas sold
Select Sum(quantity) AS Total_Pizza_Sold from pizza_sales


--4. Total Ordes Placed
Select Count(distinct order_id) AS Total_Orders from pizza_sales


--5. _Average Pizzas Per Order
Select Cast (Cast (Sum(quantity)as decimal(10,2))/ 
Cast (count(distinct order_id) as decimal (10,2)) as decimal(10,2)) AS Avg_Pizzas_Per_Order from pizza_sales

---6. Daily Trend for orders
Select datename (DW, order_date) as order_day, count(distinct order_id) AS Total_orders 
from pizza_sales
group by datename(DW, order_date)


--7. Hourly Trend
Select datepart (hour, order_time) as order_hours, count(distinct order_id) AS Total_orders 
from pizza_sales
group by datepart(hour, order_time)
order by order_hours

--8. Percentage of Sales by Pizza Category (filtered by month)
Select pizza_category, sum(total_price) as Total_sales, Cast (Sum(total_price)*100 /(Select sum(total_price) from pizza_sales where Month(order_date) = 1) as decimal(10,2) ) as PCT
from pizza_sales
where Month(order_date) = 1
group by pizza_category


--9 Percentage of Sales by Pizza Size (filtered by month)

Select pizza_size, Cast(sum(total_price) as decimal(10,2)) as Total_sales, Cast (Sum(total_price)*100 /(Select sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1) as decimal(10,2) ) as PCT
from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_size
order by PCT Desc

--Total Pizzas sold by Pizza Category

Select pizza_category, sum(quantity) AS Total_Pizzas_Sold
from pizza_sales
group by pizza_category


--Top 5 Best Sellers by total pizzas sold

Select Top 5 pizza_name, sum(quantity) AS Total_Pizzas_Sold
from pizza_sales
where month(order_date) = 8
group by pizza_name 
order by Total_Pizzas_Sold asc


Select * from pizza_sales