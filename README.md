# Snowflake-DataSampling

Data sampling is used to fetch the subset of the data from tables .

1.we use to build any kind of data logic to set up .

2.For easy and fast Analysis on data .

3.To set up limited data for lower env from PROD .

4.This approach helps to reduce storage and processing cost for lower env set up's .


# Keywords

SAMPLE | TABLESAMPLE

BERNOULLI | ROW

SYSTEM | BLOCK

REPEATABLE | SEED 

# Methods (FRACTION | FIXED-SIZE)

1.ROW | BERNOULLI => will get subset from complete rows of table 

2.SYSTEM | BLOCK => will fetch data from table files i.e micro partitions.


# Join conditions 

1.The sample is row-based (Bernoulli).

2.The sampling does not use a seed.

# Query  : 

Select * from table_1 sample(5) 
inner join table_2 sample(8) 
on table_1.value = table_2.value;




