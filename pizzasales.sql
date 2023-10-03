--total revenue
select round(SUM(total_price),2) as total_revenue from pizza_sales

select * from pizza_sales

--average revenue
select SUM(total_price)/count(distinct order_id) as average_revenue from pizza_sales

--total pizza sold
select SUM(quantity) as total_pizza_sold from pizza_sales

--total order
select count(distinct order_id) as total_order from pizza_sales

--average pizza per order
select cast(cast(SUM(quantity) as decimal(10,2))
/cast(count(distinct order_id) as decimal(10,2))as decimal(10,2))  as avg_pizza_perorder from pizza_sales

--daily trend
select DATENAME(dw,order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(dw,order_date) 

--monthly trend
select datenAME(MONTH,order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(month,order_date) 
order by total_orders desc

--percentage of sales by pizza category
select pizza_category, sum(total_price) as total_sales, SUM(total_price) * 100/
(select SUM(total_price) from pizza_sales where month(order_date) = 1) as PCT
from pizza_sales
where month(order_date) = 1
group by pizza_category

--percentage of sales by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales,cast(SUM(total_price) * 100/
(select SUM(total_price) from pizza_sales) as decimal(10,2)) as Per_sales_PS 
from pizza_sales
where DATEPART(quarter,order_date) = 1
group by pizza_size
order by Per_sales_PS desc

--top 5 best sellers
select top 5 pizza_name,cast(sum(total_price) as decimal(10,2))as total_sales from pizza_sales
group by pizza_name 
order by total_sales desc

--top 5 lowest revenue
select top 5 pizza_name,cast(sum(total_price) as decimal(10,2))as total_sales from pizza_sales
group by pizza_name 
order by total_sales asc

--top 5 best sellers by quantity
select top 5 pizza_name,sum(quantity)as total_quantity from pizza_sales
group by pizza_name 
order by total_quantity desc

--bottom 5 best sellers by quantity
select top 5 pizza_name,sum(quantity)as total_quantity from pizza_sales
group by pizza_name 
order by total_quantity asc