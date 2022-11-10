-- Task: Count the number of missed calls for customers who placed just one order per franchise with a hypothesis that
-- poor customer service, in the form of missing a call, led to disappointment and no futher order.
-- Essentailly, the results obtained will show us customers that were lost.

-- The call has to be made AFTER the order was placed.
-- Since the call is missed, the direction is 'I' (incoming) and duration is 0 (seconds).
select U_reportname,count(duration) as missedcallscount, year from
(select*, left(CardCode, 2) as cardcode2 from
(select CardCode, min([Call datetime]) as firstcall, duration, year(FirstOrder) as year, Direction
from Orders_data a
inner join Call_data b
on a.CardCode collate SQL_Latin1_General_CP1_CI_AS=b.Customer_ID collate SQL_Latin1_General_CP1_CI_AS
where NoOfOrders=1
and direction = 'I'
and duration = '0'
and FirstOrder<[Call datetime]
group by cardcode, duration, U_firstOrder, direction) as subquery
) as d
inner join Franchisees c
on d.cardcode2=c.U_FranchiseID
group by U_reportname, year
-- Please note that customer account numbers in csv files uploaded to github were randomized due to confidentiality reasons.
