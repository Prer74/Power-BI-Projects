-- select * from sample;

-- Q1. Total Sales and Profit in each Country
select country,sum(sales) as Total_Sales,sum(profit) as Total_Profit from sample
group by country;

-- Q2. Products with highest units sold 
select distinct product,max(units_sold) as Highest_units_sold from sample
group by product;

-- Q3. Effects of Discounts on number of units sold in each country
select discount_band, sum(units_sold) as Total_Units_sold from sample
group by discount_band
order by sum(units_sold) desc;

-- Q4. Top 2 products in each country by there sales

WITH item_counts AS (
    SELECT
        product,
        country,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY SUM(sales) DESC
        ) AS item_rank
    FROM sample
    GROUP BY country, product
)

SELECT
    item_rank,
    country,
    product,
    total_sales
FROM item_counts
WHERE item_rank <= 2;

-- Q5. Yearly trend of sales in each country by the segment

select country,segment,sale_year,sum(sales) as 'Total sales' from sample
group by country,segment,sale_year
order by sum(sales) desc;

--