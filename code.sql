create database cdms;
use cdms;



desc Agents;

alter table Agents
modify column AGENT_NAME varchar(50);

alter table Orders
add primary key (ORD_NUM);

alter table Orders
add constraint fk_ord_cus
foreign key (CUST_CODE)
references Customer(CUST_CODE);

select * from Agents;
select * from Customer;
select * from Orders;

-- ques 1
select c.CUST_CODE,c.CUST_NAME,c.OUTSTANDING_AMT,a.AGENT_NAME
from Customer as c
inner join Agents as a
on c.AGENT_CODE=a.AGENT_CODE;

-- ques 2
select a.AGENT_CODE,a.AGENT_NAME,sum(o.ORD_AMOUNT) as total_amount
from Agents as a
inner join Orders as o
on a.AGENT_CODE=o.AGENT_CODE
group by a.AGENT_NAME,a.AGENT_CODE
having sum(o.ORD_AMOUNT)>10000;

-- ques 3
create view order_customer_agent as
select o.ORD_NUM,a.AGENT_NAME,c.CUST_NAME
from Orders as o
inner join Agents as a
on o.AGENT_CODE=a.AGENT_CODE
inner join Customer as c
on o.CUST_CODE=c.CUST_CODE;

select * from order_customer_agent;

-- ques 4
select c.CUST_CODE,c.CUST_NAME,c.WORKING_AREA,o.ORD_NUM
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
where c.CUST_CITY='New York';

-- ques5
select AGENT_CODE,count(ORD_NUM) as total_orders from Orders
group by AGENT_CODE;

-- ques 6
select c.CUST_CODE,c.CUST_NAME,o.ORD_NUM,o.ORD_AMOUNT,o.ADVANCE_AMOUNT
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
where o.ADVANCE_AMOUNT >= (0.5*o.ORD_AMOUNT);

-- ques7
select CUST_CITY,count(CUST_CODE) as total_customers,sum(OUTSTANDING_AMT) as total_amount from Customer
group by CUST_CITY;

-- ques 8
select *
from Customer as c
left join Orders as o
on c.CUST_CODE=o.CUST_CODE;

-- ques 9
select c.CUST_CODE,c.CUST_NAME,o.ORD_AMOUNT
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
order by o.ORD_AMOUNT desc
limit 1;

select c.CUST_CODE,c.CUST_NAME,o.ORD_AMOUNT
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
where o.ORD_AMOUNT=
(select max(ORD_AMOUNT) from Orders);


-- ques 10
select c.CUST_CODE,c.CUST_NAME,count(o.ORD_NUM) as no_of_orders,sum(o.ORD_AMOUNT) as total_amount
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
group by c.CUST_CODE,c.CUST_NAME
having count(o.ORD_NUM)>2;

select c.CUST_CODE,c.CUST_NAME,sum(o.ORD_AMOUNT) as total_amount
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
where c.CUST_CODE in
(select CUST_CODE from Orders
group by CUST_CODE
having count(ORD_NUM)>2)
group by c.CUST_CODE,c.CUST_NAME;

-- ques 11
select ORD_NUM,ORD_DATE from Orders
where month(ORD_DATE)=5 and year(ORD_DATE)=2008;

-- ques 12
select ORD_NUM,ORD_DATE,ORD_AMOUNT from Orders
where ORD_AMOUNT>1000 OR ORD_DATE<'2008-12-31';

-- ques 13
select c.CUST_CODE,c.CUST_NAME,c.CUST_CITY,o.ORD_NUM,o.ORD_AMOUNT
from Customer as c
inner join Orders as o
on c.CUST_CODE=o.CUST_CODE
where c.CUST_CITY='New York' or o.ORD_AMOUNT>5000;

-- ques 14
select a.AGENT_CODE,a.AGENT_NAME,count(distinct o.CUST_CODE) as distinct_customers
from Orders as o
inner join Agents as a
on o.AGENT_CODE=a.AGENT_CODE
group by a.AGENT_NAME,a.AGENT_CODE
having count(distinct o.CUST_CODE)>3;

-- ques 15
select CUST_CODE,CUST_NAME,PAYMENT_AMT,OUTSTANDING_AMT from Customer
where PAYMENT_AMT > 0 and  OUTSTANDING_AMT > 7000;

-- question(imp)
SELECT DISTINCT o1.CUST_CODE,c.CUST_NAME
FROM orders o1
INNER JOIN customer as c
on o1.CUST_CODE=c.CUST_CODE
WHERE o1.ORD_AMOUNT >
(
    SELECT AVG(o2.ORD_AMOUNT)
    FROM orders o2
    WHERE o1.CUST_CODE = o2.CUST_CODE
);
-- --------------------------------------------------------------------------------------------------------------------
select * from Orders
order by ORD_AMOUNT
limit 5
offset 5;


SELECT * FROM orders;
SELECT * FROM customer;
SELECT * FROM agents;