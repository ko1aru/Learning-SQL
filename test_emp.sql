use test;
create table emp (
	eno int,
    ename varchar(10),
    designation varchar(15),
    sal int,
    mgr int,
    deptno int
);
insert into emp values(6, 'fff', null, null, null, 20);

create table dept (
	deptno int, 
    dname varchar(15),
    loc varchar(10)
);
insert into dept values(40, 'production', 'bengaluru');

show tables;
select * from emp;


select designation, count(*) from emp
where sal>10000 and deptno in (select deptno from dept where dname='sales')
group by designation;

select designation, count(*) from emp
group by designation
order by count(*);

select designation, count(*) from emp
where deptno in (select deptno from dept where loc='delhi')
group by designation
having count(*)>=1
order by count(*);

select ename, sal from emp
where sal > (select sal from emp where eno=1);

select eno, ename from emp
where 
	designation = (select designation from emp where eno=2) and
    deptno = (select deptno from dept where loc='delhi');
    
select designation, count(*) from emp
group by designation
having count(*) = (select max(designation_count) 
				   from (select designation, count(*) as designation_count from emp group by designation) as counts);

-- second highest salary
select ename from emp where sal= (select max(sal) from emp
									where sal<(select max(sal) from emp));
                                    
/* JOINS
	Inner join --> returns only matched records from both tables
		select ename, loc
		from emp E inner join dept D on E.deptno = D.deptno;
    
    Outer join -->  left outer join - matched records with unmatched records in left table			select ename, dname from emp E left outer join dept D on E.deptno = D.deptno;
					right outer join - matched records with unmatched records in right table		select ename, dname from emp E right outer join dept D on E.deptno = D.deptno;
                    full outer join - matched records with unmatched records in both tables			select ename, dname from emp E full outer join dept D on E.deptno = D.deptno;
                    
	Self join --> used in a single table
		select E.ename as 'Employee', M.ename as 'Manager' from emp E, emp M where E.mgr = M.eno;
        
	Natural Join --> automatically identifies the Primary key and Foreign key
		select ename, loc from emp natural join dept;
*/
select eno, ename as 'Name', sal as 'Salary', dname as 'Department', loc as 'Location'
from emp E, dept D
where E.deptno = D.deptno;

select ename, loc, sal from emp E, dept D
where sal = (select max(sal) from emp) and E.deptno = D.deptno;

select ename, sal, deptno from emp E
where sal > (select avg(sal) from emp where deptno=E.deptno);

update emp E
set (sal, ename) = (select sal+100, concat(ename, 'hello')
					from emp where eno=E.eno);
                    
UPDATE emp E
JOIN (
    SELECT eno, sal + 100 AS new_sal, CONCAT(ename, 'hello') AS new_ename
    FROM emp
) AS subquery
ON E.eno = subquery.eno
SET E.sal = subquery.new_sal, E.ename = subquery.new_ename;

start transaction;
delete from emp
where eno=6;
rollback