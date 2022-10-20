select * from project#1.dbo.data1;
select * from project#1.dbo.data2;
select count(*) from project#1..data1
select count(*) from project#1..data2
--data set for jharkhand and bihar
select * from ..Data1 where state in ('Jharkhand','Bihar')
--popultion of india
select sum(population) from project#1..data2
--avg growth
select state, avg(growth)*100 avg_growth from project#1..Data1 group by state;
--avg sex ratio
select state, round(avg(sex_ratio),0) avg_sex_ratio from project#1..Data1 group by state order by avg_sex_ratio desc;


--avg literacy rate
select state,round(avg(literacy),0) literacy_ratio from project#1..Data1 group by state
having round(avg(literacy),0)>90 order by literacy_ratio desc;

--top three state showing higest growth ratio

select top 3 state,avg(growth)*100 avg_growth from project#1..Data1 group by state order by avg_growth desc;

-- botom 3 state
select top 3 state,round(avg(sex_ratio),0) avg_sex_ratio from project#1..Data1 group by state order by avg_sex_ratio asc;


--top  and bottom 3 states in literacy state
drop table if exists #topstate
create table #topstate
( state nvarchar(255),
topstate float
)
insert into #topstate
select state,round(avg(literacy),0) literacy_ratio from project#1..Data1 group by state order by literacy_ratio desc;
select top 3 * from  #topstate order by #topstate.topstate desc;
-- for bottom

drop table if exists #bottomstates;
create table #bottomstates
( state nvarchar(255),
bottomstates float
)
insert into #bottomstates
select state,round(avg(literacy),0) literacy_ratio from project#1..Data1 group by state order by literacy_ratio desc;
select top 3 * from  #bottomstates order by #bottomstates.bottomstates asc;

--union opertaor
select * from(
select top 3 * from  #topstate order by #topstate.topstate desc) a
union
select * from(
select top 3 * from  #bottomstates order by #bottomstates.bottomstates asc) b;

--select starting with letter a
select state from project#1..Data1 where lower(state) like 'a%' or lower(state) like 'b%';

select state from project#1..Data1 where lower(state) like 'a%' or lower(state) like '%d';
