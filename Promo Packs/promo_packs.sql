-- TASK 1: In this promotional activity, customers are only allowed to get one promo pack each. Let's check if that was not exploited at franchise level;
-- In other words check the number of packs ordered per customer since the activity launch.
select _CustID, COUNT(itemcode) as packsorderedpercustumer
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
       group by _CustID, itemcode
       order by packsorderedpercustumer desc

-- TASK2: Repeat the above tasks but only for selected franchises: franchiseID = 23, 27, 11, 38, 17 or 35.
select _CustID, COUNT(itemcode) as packsorderedpercustumer
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
       and (_CustID like '23%'
       or _CustID like '27%'
       or _CustID like '11%'
       or _CustID like '38%'
       or _CustID like '17%'
       or _CustID like '35%')
       group by _CustID, itemcode
       order by packsorderedpercustumer desc

-- TASK3: Calculate the percentage of customers that ordered a pack more than once. Complete the whole task in SQL for practice, even though
-- simplu using Excel or calculator would speed up the process.

drop table if exists #temp1
select count(*) as count218 
into #temp1
from(
select _CustID, COUNT(itemcode) as packsorderedpercustumer
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
       group by _CustID, itemcode) as subquery
       where packsorderedpercustumer > 1
      
select * FROM #TEMP1

drop table if exists #temp2
select count(*) as count218
into #temp2
from(
select _CustID, COUNT(itemcode) as packsorderedpercustumer
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
       group by _CustID, itemcode) as subquery2

       select * from #temp2

drop table if exists #temp3
select *
into #temp3
from 
(select t2.count218 as count1, t1.count218 as count2,
lag (t2.count218,1) over (order by t1.count218) as lag
       from #temp2 t2
       full outer join #temp1 t1
       on t2.count218=t1.count218) as subquery3

select * from #temp3

select (cast(count2 as numeric(10,2))/(cast(lag as numeric(10,2))))*100 as perc
from #temp3 t3
where count2 is not NULL
and lag is not null

--TASK4: Has any customer ordered more than 1 pack type? If yes, count the number of such customers.
select count(*) as OrderedMoreThan1Pack
from
(select _CustID, count(_CustID) as Count
from
(select distinct _CustID, itemcode
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01') as subquery
       group by _CustID) as subquery2
       where count>1


-- TASK5: This promotional activity should have been offered only to new customers. Check how many customers redeemed the promo pack NOT on their first order.
drop table if EXISTS #temptable
select count (*) as count0 into #temptable
from
(select _CustID, PackOrderDate from(
    select _CustID, DocDate as PackOrderDate, count(_CustID) over (PARTITION by _CustID order by DocDate) as OrdPerCust
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
) as subquery
where OrdPerCust = 1
EXCEPT
select _CustID, MIN (U_docdate) as firstorder
from
(Select b._CustID, U_docdate from Order_data a
right join Order_details b
on a.CustID=b._CustID
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01') as subquery
       group by _CustID) as subquery3

select * from #temptable

-- TASK 6: Continuing from task above, check the percentage of pack orders that were not redeemed as first order (taking into account customers who ordered just one pack)
drop table if EXISTS #temptable1
select count (*) as count1 into #temptable1
from
(select _CustID, PackOrderDate from(
    select _CustID, DocDate as PackOrderDate, count(_CustID) over (PARTITION by _CustID order by DocDate) as OrdPerCust
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01') as subquery4
) as subquery5

drop table if exists #temp3
select *
into #temp3
from 
(select t1.count1 as count1, t0.count0 as count0,
lag (t1.count1,1) over (order by t0.count0) as lag
       from #temptable1 t1
       full outer join #temptable t0
       on t1.count1=t0.count0) as subquery3


select * from #temp3


select (cast(count0 as numeric(10,2))/(cast(lag as numeric(10,2))))*100 as perc
from #temp3 t3
where count0 is not NULL
and lag is not null


--TASK 8: Calculate average order value of customers who purchased a pack as a first purchase  and made at least one (non-pack) purchase apart from that.
drop table if exists #temp1
select *
into #temp1
from 
 (select _CustID, MIN (U_docdate) as firstorder
from
(Select b._CustID, U_docdate from Order_data a
right join Order_details b
on a.CustID=b._CustID
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01') as subquery
       group by _CustID
       EXCEPT
select _CustID, PackOrderDate from(
    select _CustID, DocDate as PackOrderDate, count(_CustID) over (PARTITION by _CustID order by DocDate) as OrdPerCust
from Order_details
where ItemCode in ( 'XMP-314' , 'XMP-315',  'XMP-316' ,'XMP-317'  ,'XMP-318' , 'XMP-319' , 'XMP-320' , 'XMP-322' , 'XMP-323', 'XMP-324',
       'XMP-325' , 'XMP-326' , 'XMP-327', 'XMP-328' , 'XMP-329' , 'XMP-330' , 'XMP-331',  'XMP-332'  ,'XMP-333'  ,'XMP-334',
       'XMP-335',  'XMP-336', 'XMP-337', 'XMP-338' ,'XMP-343' , 'XMP-344' ,'XMP-345' , 'XMP-346' ,'XMP-347', 'XMP-348',
       'XMP-349'  ,'XMP-350', 'XMP-304' , 'XMP-303', 'XMP-302' , 'XMP-351'  ,'XMP-352' , 'XMP-353' , 'XMP-354',  'XMP-355',
       'XMP-356'  ,'XMP-362',  'XMP-358' ,'XMP-359' ,'XMP-363' ,'XMP-364' ,'XMP-365' , 'XMP-366', 'XMP-367' ,'XMP-368',
       'XMP-370', 'XMP-371' , 'XMP-372' ,'XMP-374',  'XMP-375' , 'XMP-379' ,'XMP-381' , 'XMP-383' ,'XMP-384' , 'XMP-385',
       'XMP-386','XMP-387')
       and Docdate >= '2021-01-01'
) as subquery
where OrdPerCust > 1) as subquery1


select AVG(OrdValue) from
(select CustID, count(CustID) over (partition by CustID) as ordercount, OrdValue 
from Order_data t0
inner join #temp1 t1
on t0.CustID=t1._CustID) as subquery
where ordercount>1
