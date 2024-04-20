create function MostSuccessNdFaildCampaing(
)
returns table as 
return
with cte as
 (
select e.status,cmp.customer_id,cmp.name,count(1) as total
from events
e left join  campaigns cmp on cmp.id=e.campaign_id
group by e.status,cmp.customer_id,cmp.name
),
cte2 as ( select status,customer_id,STRING_AGG(name,',') as cmpnName,
 RANK() over(partition by status order by sum(total) desc) as rnk,
  sum(total) as total
from cte group by status,customer_id)
select cte2.status,(c.first_name+' '+c.last_name)CusName,
cte2.cmpnName,cte2.total
from cte2   left join customers c on c.id=cte2.customer_id
where rnk=1
--order by status desc

 
