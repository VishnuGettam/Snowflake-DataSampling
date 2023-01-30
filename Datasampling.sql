--data sampling with ROW/BERNOLI method or SYSTEM/BLOCK method along with uses FRACTION or FIXED-SIZE ways

--FRACTION METHOD

--ROW method(will get the (p/100) * table count of records)
--(12/100) * count of table rows
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample row(12);
select * from snowflake_sample_data.tpcds_sf100tcl.customer tablesample row(12);
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample bernoulli(8);

--SYSTEM method(will fetch data (p/100) * number of micro-partitions)
--will get (7/100) * number of micro-partitions 
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample system(7);
select * from snowflake_sample_data.tpcds_sf100tcl.customer tablesample block(7);

--FIXED METHOD (Supported by ROW method only)

--will fetch records with fixed size of 10 rows
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample(10 rows);
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample row(10 rows);

--SEED or REPEATABLE 
--to get the same deterministic data for multiple executions we used SEED or REPEATABLE
--we have to assing a number to the SEED(number) which will register to get the same set of data for all executions
select * from snowflake_sample_data.tpcds_sf100tcl.customer sample row(12) SEED(125);
select * from snowflake_sample_data.tpcds_sf100tcl.customer tablesample system(5) repeatable(111);


--JOIN( Works only for ROW )
--3 % of data from customer matches with 4 % of data from customer_address .
select * 
from snowflake_sample_data.tpcds_sf100tcl.customer cs sample row(3)
inner join snowflake_sample_data.tpcds_sf100tcl.customer_address ca sample row(4)
on cs.c_current_addr_sk = ca.ca_address_sk;

--complete customer data with matched 8 % of customer address data .
select * 
from snowflake_sample_data.tpcds_sf100tcl.customer cs 
inner join snowflake_sample_data.tpcds_sf100tcl.customer_address ca sample row(4)
on cs.c_current_addr_sk = ca.ca_address_sk;

--to do sampling on join records we have to use sub query  

select * from 
(
select * 
from snowflake_sample_data.tpcds_sf100tcl.customer cs 
inner join snowflake_sample_data.tpcds_sf100tcl.customer_address ca  
on cs.c_current_addr_sk = ca.ca_address_sk
) sampled_joined sample row(8);
