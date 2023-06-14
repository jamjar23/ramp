/* Using this dataset, show the SQL query that provides January 31's rolling 3 day average of total transaction amount processed per day
   q.v. https://www.db-fiddle.com/f/k5xTesx1bJNLTewWrpho9a/0
*/

with 
C as (select distinct DATE(transaction_time) tr_date from transactions),
T as (select DATE(transaction_time) tr_date, sum(transaction_amount) daily_total, 
      count(*) num_trans
      from transactions
      group by 1)

select C.tr_date, avg(T.daily_total) 
from C left join T on T.tr_date between C.tr_date-2 and C.tr_date
group by C.tr_date
order by C.tr_date
;
