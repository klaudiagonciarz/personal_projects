-- The company wants to improve their sales by sending customers a leaflet with an offer for products from Cheese category. 
-- It is believed that the best target may be:
    -- people who never bougth products from Cheese category
    -- people who sometimes buy Cheese products but are below average

-- In order to help marketing team solved that problem, find
    -- list of people who never bought a product from Cheese category
    -- percentage of orders that specific customers buy Cheese products on
    -- average percentage of orders that customers in general buy Cheese products on
-- Make sure that you only consider active customers (their last purchase was within last 6 months)

select * from Order_details
select * from CategoriesOfProducts
select * from Order_data

--Active customers
select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02'

--Cheese orders
select a.itemcode, a.itemcat1, b.itemcode, b._Cust_D
from CategoriesOfProducts a
inner join Order_details b
on a.itemcode collate SQL_Latin1_General_CP850_CI_AS = b.itemcode collate SQL_Latin1_General_CP850_CI_AS
where ItemCat1= 'Cheese'

--List of active customers that have bought Cheese products in the past
select distinct Cust_ID
from
(select a.itemcode as itcod, itemcat1, b.itemcode as idcod1, b._Cust_D
from CategoriesOfProducts a
inner join Order_details b
on a.itemcode collate SQL_Latin1_General_CP850_CI_AS = b.itemcode collate SQL_Latin1_General_CP850_CI_AS
where ItemCat1= 'Cheese') a
inner join 
(select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02') b
on b.Cust_ID=a._Cust_D

--List of active customers that have never bought Cheese products in the past
select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02'
EXCEPT
select distinct b._Cust_D
from CategoriesOfProducts a
inner join Order_details b
on a.itemcode collate SQL_Latin1_General_CP850_CI_AS = b.itemcode collate SQL_Latin1_General_CP850_CI_AS
where ItemCat1= 'Cheese'

--List of all orders by active customers
select a.Cust_ID, a.U_Docdate 
from Order_data a
inner join 
(select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02') b
on a.Cust_ID=b.Cust_ID

--Percentage of orders that specific customers bought Cheese products on
drop table if EXISTS #temp1
select count(a.Cust_ID) as NumOfOrdPerCust, a.Cust_ID into #temp1
from Order_data a
inner join 
(select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02') b
on a.Cust_ID=b.Cust_ID 
group by a.Cust_ID

drop table if EXISTS #temp2
select Cust_ID, count(Cust_ID) as numofCheeseord into #temp2
from
(select distinct itemcat1, b._Cust_D
from CategoriesOfProducts a
inner join Order_details b
on a.itemcode collate SQL_Latin1_General_CP850_CI_AS = b.itemcode collate SQL_Latin1_General_CP850_CI_AS
where ItemCat1= 'Cheese') a
inner join 
(select distinct Cust_ID
from Order_data
where U_Docdate >= '2022-05-02') b
on b.Cust_ID=a._Cust_D
GROUP by Cust_ID

select a.itemcode as itcod, itemcat1, b.itemcode as idcod1, b._Cust_D, b.DocDate
from CategoriesOfProducts a
inner join Order_details b
on a.itemcode collate SQL_Latin1_General_CP850_CI_AS = b.itemcode collate SQL_Latin1_General_CP850_CI_AS
where ItemCat1= 'Cheese'

select numofCheeseord, NumOfOrdPerCust, (cast(numofCheeseord as numeric)/(cast(NumOfOrdPerCust as numeric)))*100 as PERCENTAGE
from #temp1 a
right join #temp2 b
on a.Cust_ID=b.Cust_ID
order by percentage DESC

--Overall percentage of orders that customers bought Cheese products on
select AVG(percentage) as OverallPercentage
from
(select numofCheeseord, NumOfOrdPerCust, (cast(numofCheeseord as numeric)/(cast(NumOfOrdPerCust as numeric)))*100 as PERCENTAGE
from #temp1 a
right join #temp2 b
on a.Cust_ID=b.Cust_ID) as subquery