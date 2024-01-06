 
-- creating database
create database prac8076;
-- using  database
use prac8076;

-- importing data of Lok sabha election 2019 to database prac8076 alter
-- retrieving all tables from prac8076
show tables;
-- query to fetch entire lse19 data (to know name of columns and to go through whole data)
select * from lse19;

-- retrieving political party along with name of their symbol
select PARTY , symbol from lse19;

-- retrieving political party along with name of their symbol and avoid duplicates
select distinct symbol,PARTY from lse19;

 -- all candidates whose name starts with p
 select * from lse19 where NAME like "P%"; 
 
 -- seats won by INC in kerala
 select * from lse19 where STATE = "kerala" and PARTY = "INC" ;
 
 -- query to know age groups of leaders and dividing them as young , middle age, old aged
 
 select AGE,
 case
 when AGE <= 45 then "young leader"
 when AGE > 45 and AGE <= 60 then "middle aged leader"
 when AGE > 60 then "old aged leader"
 end
 as age_analysis
 from lse19;
 
-- query to fetch candidate,party and constituency where TOTAL VOTES to candidates are between 50000 to 500000
 select NAME,PARTY,CONSTITUENCY from lse19 where TotalVotes between 50000 and 500000 ;
 
 desc lse19;
 select * from lse19;


 
 -- AGE of candidates in descending order from maharashtra state with their constituency
 select NAME,CONSTITUENCY,AGE from lse19 where STATE = "Maharashtra" order by AGE desc;
 
-- limit clause

-- to find 3rd highest AGE
select distinct AGE from lse19 order by AGE desc limit 2,1;

-- to know candidate with top3 candidates according to votes
select * from lse19;
select Name, ELECTORS,TotalVotes from lse19 order by TotalVotes desc limit 0,3;

-- query to retrive winning candidate from ASSAM where PARTY not equal to BJP
 select * from lse19 where STATE = "Assam" and PARTY <> "BJP" and WINNER = 1;
 select * from lse19 where PARTY = "INC" and WINNER = 1;
 



-- floor() : immediate lower or equal
select TotalElectors ,floor(TotalElectors) from lse19;
select floor(-9.58);
-- ceil(): immediate greter or equal

select TotalElectors , ceil(TotalElectors)  from lse19;

-- agreegate functions
-- max()
-- query to fetch maximum age
select max(AGE) from lse19;

-- retrive max total votes from Maharashtra
select max(TotalVotes) from lse19 where State = "Maharashtra" ;

-- retrive max total votes of winner from Pune constituency and candidate who got least votes
select NAME, max(TotalVotes) from lse19 where State = "Maharashtra" and CONSTITUENCY = "Pune" and WINNER = 1 group by NAME
union
select NAME, min(TotalVotes) from lse19 where State = "Maharashtra" and CONSTITUENCY = "Pune" and WINNER = 0 group by NAME;

select * from lse19;

-- count()
-- count no of candidates
select count(*) from lse19;
select count(NAME) from lse19;

-- sum of PostalVotes
select sum(PostalVotes) from lse19;
select * from lse19;
-- sum of postal votes from Telengana
select sum(PostalVotes) from lse19 where STATE = "Telangana" ;

-- retrieve max,min,total general votes and no of NAMES(candidates) in punjab

select max(GeneralVotes), min(GeneralVotes), sum(GeneralVotes), count(*) from lse19 where STATE = "Punjab" ;


-- find no of candidates from each constituency genderwise
select * from lse19;

select distinct CONSTITUENCY,GENDER,count(*) from lse19 group by CONSTITUENCY, GENDER order by CONSTITUENCY;



-- having clause
-- no of NAME from each constituency where no of names(candidates) are > 4
select CONSTITUENCY ,count(NAME) from lse19 group by CONSTITUENCY having count(NAME) > 3;

select * from lse19;
-- query from retriving no of criminal cases from each party where criminal cases > 100
select  PARTY,count(criminalcases) from lse19 group by PARTY having count(criminalcases) > 100;
select NAME, criminalcases from lse19 where PARTY = "BJP";

-- subquery 
-- create new table which contains CONSTITUENCY , TotalVoters, VotesPolled from lse19 table

create table voter_Info (select CONSTITUENCY, TotalElectors, VotesPolled from lse19);
select * from voter_Info;

select e.PARTY, e.CONSTITUENCY from lse19 as e; -- using alias for table

-- finding 2nd highest age by subquery
select  max(AGE) from lse19 where  AGE < (select max(AGE) from lse19); -- output 83

-- finding 2nd highest age by using oredr by and limit
select distinct AGE from lse19 order by AGE desc limit 1,1; -- 83



-- joins
select * from lse19;
select * from lse14;
select * from lse09;
show tables;
select * from voter_info;

-- inner join
select * from lse19 join lse14 on lse19.CONSTITUENCY = lse14.CONSTITUENCY;

-- left join: data from table 1 and commom 
 select * from lse19  left join lse14 on lse19.PARTY = lse14.Party;
 
 -- right join : data from table 2 and commom
 
 select * from lse19 as l1 right join lse09 as l2 on l1.STATE = l2.State ;
 
 -- cross join 
 select * from lse19 cross join lse09;
 
 -- union 
 select CONSTITUENCY , PARTY from lse19
 union
 select distinct CONSTITUENCY , Party from lse14 ;
 
 -- write a query to retrieve duplicate records from table lse19 of constituency column
 select CONSTITUENCY,count(*) as repeatedTime
 from lse19
 group by CONSTITUENCY having count(*) > 1;
 
 
 select * from lse19;


-- Query to get election results with candidate names, party names, and constituency details
 SELECT
    l.CONSTITUENCY,
    l.NAME,
    l.PARTY,
    l.TotalVotes,
    l.ELECTORS,
    l.STATE
FROM
    lse19 as l
JOIN lse19 as s ON l.WINNER = s.WINNER
WHERE
    s.WINNER <> 0
GROUP BY
    l.WINNER,  -- Include all non-aggregated columns in the GROUP BY clause
    l.CONSTITUENCY,
    l.NAME,
    l.PARTY,
    l.TotalVotes,
    l.ELECTORS,
    l.STATE;

 drop table lse14;
SELECT
    lse19.CONSTITUENCY AS Constituency_2019,
    lse19.NAME AS CandidateName_2019,
    lse19.PARTY AS Party_2019,
    lse19.TotalVotes AS TotalVotes_2019,
    lse19.ELECTORS AS Electors_2019,
    lse19.STATE AS State_2019,
    lse19.WINNER AS Winner_2019,
    lse14.CONSTITUENCY AS Constituency_2014,
    lse14.WinnerName AS CandidateName_2014,
    lse14.Party AS Party_2014,
    lse14.Votes AS TotalVotes_2014,
    lse14.Electors AS Electors_2014,
    lse14.STATE AS State_2014,
    lse14.WinnerName AS Winner_2014
FROM
    lse19
JOIN lse14 ON lse19.CONSTITUENCY = lse14.CONSTITUENCY
          AND lse19.NAME = lse14.WinnerName
          AND lse19.PARTY = lse14.party
          AND lse19.STATE = lse14.STATE
          where lse19.WINNER <> 0;

select * from lse14;

SELECT
    lse19.CONSTITUENCY AS Constituency_2019,
    lse19.NAME AS CandidateName_2019,
    lse19.PARTY AS Party_2019,
    lse19.TotalVotes AS TotalVotes_2019,
    lse19.ELECTORS AS Electors_2019,
    lse19.STATE AS State_2019,
    lse19.WINNER AS Winner_2019,
    lse14.CONSTITUENCY AS Constituency_2014,
    lse14.WinnerName AS CandidateName_2014,
    lse14.Party AS Party_2014,
    lse14.Votes AS TotalVotes_2014,
    lse14.Electors AS Electors_2014,
    lse14.STATE AS State_2014,
    lse14.WinnerName AS Winner_2014
FROM
    lse19
JOIN lse14 ON lse19.CONSTITUENCY = lse14.CONSTITUENCY
          AND lse19.NAME = lse14.WinnerName
          AND lse19.PARTY = lse14.party
          AND lse19.STATE = lse14.STATE
WHERE
    lse19.WINNER <> 0;

