--find the number of seat won by each party
--there are many constituencies in a state and many candidates
--who are contesting the election from each constituency
--each candidate belongs to a party
--with the candidate maximum number of votes in given constituency
--wins for the constituency
-- SOLUTION
--select * from Party_seats_won_function()
CREATE function Party_seats_won_function()
returns table as 
return
with cte as
    (select *
    , rank() over(partition by r.constituency_id order by r.votes desc) as rnk
    from candidates c
    join results r on r.candidate_id = c.id)
select concat(party, ' ', count(1)) as party_seats_won
from cte 
where rnk = 1
group by party 
--order by count(1) desc;
