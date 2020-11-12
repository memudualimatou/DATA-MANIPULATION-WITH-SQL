/*MYSQL ASSIGNEMENT QUESTION AND SOLUTION*/

--Question 1. How many unique users are in the database?
select count(DISTINCT user_id) from Baskets b2 ;


--Question2. How many unique baskets are in the database?
select COUNT( DISTINCT basket_id)  from BasketProducts bp;


-- Question3. What is the percentage of baskets that were abandoned?
with
aband_baskets_query as 
(select COUNT(DISTINCT basket_id) as aband_baskets from Baskets b where abandond = 1) ,
Total_baskets_query as 
( select COUNT(DISTINCT basket_id) as total_baskets from Baskets b ) select
	round(CAST(ABQ.aband_baskets as float) / CAST(TBQ.total_baskets as float )*100,2) as pc
	from
	aband_baskets_query as ABQ,
	Total_baskets_query as TBQ;

--Question4. What is the percentage of baskets sold with discounts?
with
baskets_sold_disc_query as 
(select COUNT(DISTINCT basket_id) as disc_baskets from Baskets b where discount!=0 and b.abandond=0) ,
Total_baskets_sold_query as 
( select COUNT(DISTINCT basket_id) as total_baskets_sold from Baskets b where b.abandond=0) select
	round(CAST(BSD.disc_baskets as float) / CAST(TBS.total_baskets_sold as float )*100,2) as percentage
	from
	baskets_sold_disc_query as BSD,
	Total_baskets_sold_query as TBS;

--4-1.	What are the discounts?	
select  discount as disc_baskets from Baskets b  GROUP BY discount 

--4-2.	How many baskets has each discount group?
select  discount, count( DISTINCT basket_id) as  NumberOfBaskets from Baskets b  GROUP BY discount 

--4-3.	How many abandoned baskets has each discount group?
select  discount, COUNT (DISTINCT basket_id) as  NumberOfBaskets from Baskets b  WHERE abandond=1 GROUP BY discount 


--Question5. What is the average profit of purchased baskets in these categories

--5-1.	Baskets with a single item,
select AVG(profit) as "AVG_profit_Baskets_single_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where b.abandond=0 group by
	b.basket_id) where distinct_basket_item_number=1 ;


--5-2.	Baskets with 2-5 items,
select AVG(profit) as "AVG_profit_baskets_2-5_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where b.abandond=0 group by
	b.basket_id) where 2<distinct_basket_item_number<5 ;


--5-3.	Baskets with 6-10 items,
select AVG(profit) as "AVG_profit_basket_6-10_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number' from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where b.abandond=0 group by
	b.basket_id) where 6<distinct_basket_item_number<10 ;



--5-4.Baskets with 11+ items.
select AVG(profit) as "AVG_profit_basket_11+_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where b.abandond=0 group by
	b.basket_id) where 11<distinct_basket_item_number ;


--Question6. What is the average possible profit of abandoned baskets in the same categories as in question 5?

--6-1.Baskets with a single item,
select AVG(profit) as "AVG_profit_aband_basket_single_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where  b.abandond=1 group by
	b.basket_id) where distinct_basket_item_number=1 ;


--6-2.Baskets with 2-5 items,
select AVG(profit) as "AVG_profit_basket_2-5_items" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where  b.abandond=1 group by
	b.basket_id) where 2<distinct_basket_item_number<5;


--6-3.Baskets with 6-10 items,
select AVG(profit) as "AVG_profit_aband_basket_6-10_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where  b.abandond=1 group by
	b.basket_id) where 6<distinct_basket_item_number<10 ;


--6-4.	Baskets with 11+ items.
select AVG(profit) as "AVG_profit_aband_basket_11+_item" from ( select
	b.basket_id, SUM(p.price - p.cost) as profit ,
	count(1) as 'basket_item_number',
	count(DISTINCT bp.product_id) as 'distinct_basket_item_number'
from
	Baskets b
inner join BasketProducts bp on
	bp.basket_id = b.basket_id
inner join Products p on
	p.product_id = bp.product_id where  b.abandond=1 group by
	b.basket_id) where 11<distinct_basket_item_number ;





