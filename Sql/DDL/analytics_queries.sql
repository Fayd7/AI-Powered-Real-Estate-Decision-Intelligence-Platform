-- Data Validation Queries 

SELECT * FROM raw.agents;
SELECT * FROM raw.sales;
SELECT * FROM raw.customer_feedback;
SELECT * FROM raw.marketing_campaigns;
SELECT * FROM raw.leads;

SELECT * FROM raw.agents 
WHERE agent_id IS NULL 
OR agent_name IS NULL;

SELECT * FROM raw.properties 
WHERE property_id IS NULL 
OR property_name IS NULL;

SELECT property_id, COUNT(*)
FROM raw.properties 
GROUP BY property_id
HAVING COUNT(*)>1;

SELECT agent_id, COUNT(*)
FROM raw.agents
GROUP BY agent_id
HAVING COUNT(*)>1;

SELECT * FROM raw.properties
WHERE listed_price <=0;

SELECT * FROM raw.sales
WHERE sale_amount <=0;

SELECT * FROM raw.customer_feedback 
WHERE rating NOT BETWEEN 1 AND 5;

SELECT s.* , p.status FROM raw.sales s
JOIN raw.properties p ON s.property_id = s.property_id
WHERE p.status <> 'sold';

SELECT s.* , l.lead_status FROM raw.sales s
JOIN raw.leads l ON s.property_id = l.property_id
WHERE l.lead_status <> 'Converted';

SELECT l.lead_id , l.lead_status FROM raw.leads l
JOIN raw.sales s  ON l.lead_id = s.lead_id
WHERE l.lead_status <> 'Converted';

SELECT DISTINCT lead_status
FROM raw.leads;

--Data Cleaning

UPDATE raw.leads l 
SET lead_status = 'Converted'
FROM raw.sales s
WHERE l.lead_id = s.lead_id
AND l.lead_status <> 'Converted';

UPDATE raw.properties p
SET status = 'Sold'
FROM raw.sales s
WHERE p.property_id = s.property_id
  AND UPPER(TRIM(p.status)) <> 'SOLD';

SELECT p.property_id,
       p.status
FROM raw.properties p
JOIN raw.sales s
    ON p.property_id = s.property_id
WHERE UPPER(TRIM(p.status)) <> 'SOLD';

-- total revenue

SELECT SUM(sale_amount) AS total_revenue FROM clean.sales;

-- total number of sales

SELECT COUNT(sale_id) as total_sales from clean.sales

-- revenue by region

select p.region, SUM(s.sale_amount) AS total_revenue
from clean.sales s 
join clean.properties p on s.property_id = p.property_id
group by p.region
order by  total_revenue desc;

-- top performing agents

select a.agent_name, count(s.agent_id) as total_sales from clean.sales s
join clean.agents a on s.agent_id = a.agent_id
group by a.agent_name 
order by total_sales desc ;

-- lead conversion rate

select ROUND(100* SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END)
/ COUNT(*),2 ) AS conversion_rate from clean.leads;

-- average customer rating

select round(avg(rating),2) as avg_rating from clean.customer_feedback;

-- campaign performance

select m.campaign_name,  count(l.lead_id) as leads_generated
from clean.leads l
join clean.marketing_campaigns m on l.campaign_id = m.campaign_id
group by campaign_name
order by leads_generated desc;

-- revenue trend

select extract(year from sale_date) sale_year, 
extract(month from sale_date) as sale_month, to_char(sale_date, 'month') as month_name, sum(sale_amount) as trend 
from clean.sales 
group by sale_month, sale_year, month_name
order by trend desc;

-- property type performance

select p.property_type, sum(s.sale_amount)
as performance from clean.properties p
join clean.sales s on p.property_id = s.property_id
group by p.property_type
order by performance desc ;

-- Power BI Views

CREATE OR REPLACE VIEW clean.sales_details AS
SELECT s.sale_amount, s.sale_date, s.sale_id,
p.property_name, p.property_type, p.region, a.agent_name
FROM clean.sales s 
join clean.properties p on s.property_id = p.property_id
join clean.agents a on s.agent_id = a.agent_id;


select * from clean.sales_details limit 10;
select * from clean

CREATE OR REPLACE VIEW clean.lead_details AS
SELECT
    l.lead_id,
    l.lead_date,
    l.lead_status,
    p.property_name,
    mc.campaign_name
FROM clean.leads l
JOIN clean.properties p
    ON l.property_id = p.property_id
JOIN clean.marketing_campaigns mc
    ON l.campaign_id = mc.campaign_id;


select * from clean.lead_details limit 10;
