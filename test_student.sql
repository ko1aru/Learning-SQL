create table student (
	rollno int, 
    sname varchar(10), 
    age int, 
    marks int, 
    sec char
);

insert into student (rollno, sname, sec, age, marks)
values (8, 'abca', 'B', 13, 50);

select * from student
order by sec;

select 
	sname as 'Name', 
    sec as 'Section', 
    marks as 'Marks '
from student;

select * from student 
where sec='A' and age = 11;

update student
set sec = 'A' 
where rollno=3;

select * from student
where (age>=8 and age<=12);
-- Alternate
select * from student
where age between 8 and 12;

select * from student
where sname='abc' or sname='xyz' or sname='rst';
-- Alternate
select * from student
where sname in ('abc', 'xyz', 'rst');

-- 'is' not '='
select * from student
where marks is not null
order by marks desc;

/* WILD CARDS
	_ --> match exactly 1 character
    % --> 0 or more characters
*/
select * from student 
where sname like 'a%'; --  first letter is 'a'
select * from student
where sname like 'a%a'; -- first and last letter is 'a'
select * from student
where sname like '_b%'; -- 'b' is the second letter

select distinct sec from student;
select distinct age from student order by age;

select
	sname AS 'Name',
    marks*2 AS 'Percentage'
from student
where marks*2 > 60
order by 2 desc;  -- '2' means 2nd column

/* AGGREGATE FUNCTIONS
	1. max
    2. min
    3. avg
    4. sum
    5. count
*/
select count(rollno) from student
where age between 8 and 12;

select count(distinct sec) from student;

select 
	sec as 'Sections',
    count(*) as 'No. of students'
from student
group by sec;

select
	sec as 'Sections',
    count(*) as 'No. of students'
from student
where marks>40
group by sec;

select
	sec as 'Sections',
    count(*) as 'No. of students'
from student
where marks>40 and sec='B'
group by sec
having count(*)>1;

