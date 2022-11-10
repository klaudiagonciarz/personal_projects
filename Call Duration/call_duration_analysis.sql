--Task: Get total duration of outgoing calls in the first half of 2022 (until end of June) per financial week, splitting by phone type (mobile/landline).
--      That should allow telesales managers to observe trends/seasonality over time.
--      (tables used are available as csvs in a folder shared on github)

select SUM(duration) as [total duration], [phone type], u_fweeknum
from
(select duration, case when [Phone number] like '07%' then 'mobile' else 'landline' end as [phone type], U_FWeekNum
from (select* from Financial_calendar a
left join Call_data b
on a.U_date=b.date
where U_Fyear='2022') as subquery
where direction = 'O'
and len([phone number]) > 8) as subquery1
group by u_fweeknum, [phone type]
order by U_FWeekNum

-- It was assumed that mobile phone calls can be recognised by the first two digits - "07". 
-- All UK phone numbers start with "07".
-- Direction of the calls was set to "O", which stands for outgoing in the database.
-- Only valid phone numbers were taken into account (the length of the phone number must be greater than 8).
-- Please note that due to privacy reasons all phone numbers were randomized" in a file shared on github.