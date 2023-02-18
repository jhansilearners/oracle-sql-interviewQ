Fetch the number of Weekends in the current month
Get the last 5 Records from the Student table
Get the common records present in two different tables that have no joining conditions.
->Display records 5 to 9 from the Employee table.
=>Display the last record of a table
=>Display the third-last record of a table
Q -Convert seconds into time format => hh:mm  120s
   
SQL> select to_char(to_date(1700,'sssss'),'hh24:mi:ss') from dual;

Q Remove duplicate rows from a table
Find the number of duplicate rows
SQL> select distinct job from emp; --> non duplicate 
   select deptno,job from emp group by deptno,job having count(*)>1 --> to find duplicate record
   
   SQL> ed
Wrote file afiedt.buf

  1* select deptno,job from emp group by deptno,job having count(*)>1
SQL> /

    DEPTNO JOB
---------- ---------
        20 CLERK
        30 SALESMAN
        20 ANALYST

Elapsed: 00:00:00.03
SQL> ed
Wrote file afiedt.buf

  1* select deptno,job,count(*) from emp group by deptno,job having count(*)>1
SQL> /

    DEPTNO JOB         COUNT(*)
---------- --------- ----------
        20 CLERK              2
        30 SALESMAN           4
        20 ANALYST            2

Elapsed: 00:00:00.03

Q:- Find the fourth-highest score in the Students table using self-join
 we have perform this on emp table not in student because we have emp which has sal.
Wrote file afiedt.buf

  1  select * from emp e1
  2  where
  3  3=(
  4  select count(distinct(e2.sal))
  5  from emp e2 where e1.sal<e2.sal
  6* )
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30

Elapsed: 00:00:00.04
SQL> \
SP2-0042: unknown command "\" - rest of line ignored.
SQL> ed
Wrote file afiedt.buf

  1  select * from emp e1
  2  where
  3  3=(
  4  select count((e2.sal))
  5  from emp e2 where e1.sal<e2.sal
  6* )
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20

Elapsed: 00:00:00.00
SQL>

Q:-Show the max and min salary together from the Employees table
SQL> select max(sal),min(sal) from emp;

  MAX(SAL)   MIN(SAL)
---------- ----------
      5000        800

Q :- Display date in a DD-MM-YYYY table
select to_char(sysdate,'dd-mm-yyyy') from dual;


  1* select to_char(sysdate,'dd-mm-yyyy') from dual
SQL> /

TO_CHAR(SY
----------
15-02-2023

Q:-Create Employee_C table, which is the exact replica of the Employee table
create table Employee_C as select * from emp;

Q:- Drop all user tables from Oracle
 drop table Employee_C;  -- if we have to drop multiple table then we have use cursor  for same.
Q:- Calculate the number of rows in a table without using count
select count(*) from emp; --no need to use the count. we can do this by cursor or function
SQL> select max(rownum) from emp;

MAX(ROWNUM)
-----------
         14


Q:-Find repeated characters from your name -- this can we done using the function.
CREATE OR REPLACE FUNCTION EXPRESSION_COUNT( pEXPRESSION VARCHAR2, pPHRASE VARCHAR2 ) RETURN NUMBER AS
  vRET NUMBER := 0;
  vPHRASE_LENGTH NUMBER := 0;
  vCOUNTER NUMBER := 0;
  vEXPRESSION VARCHAR2(4000);
  vTEMP VARCHAR2(4000);
BEGIN
  vEXPRESSION := pEXPRESSION;
  vPHRASE_LENGTH := LENGTH( pPHRASE );
  LOOP
    vCOUNTER := vCOUNTER + 1;
    vTEMP := SUBSTR( vEXPRESSION, 1, vPHRASE_LENGTH);
    IF (vTEMP = pPHRASE) THEN        
        vRET := vRET + 1;
    END IF;
    vEXPRESSION := SUBSTR( vEXPRESSION, 2, LENGTH( vEXPRESSION ) - 1);
  EXIT WHEN ( LENGTH( vEXPRESSION ) = 0 ) OR (vEXPRESSION IS NULL);
  END LOOP;
  RETURN vRET;
END;

Q:-Display department and month-wise maximum salary

select max(sal) , hiring_date from emp group by hiredate; -- it will group hiring date wise 
Correct answer :-

  1* select max(sal),to_char(hiredate,'month') from emp group by to_char(hiredate,'month')
SQL> /

  MAX(SAL) TO_CHAR(HIREDATE,'MONTH')
---------- ------------------------------------
      2850 may
      1600 february
      3000 december
      2450 june
      3000 april
      1500 september
      5000 november
      1300 january

8 rows selected.

Elapsed: 00:00:00.01
SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

14 rows selected.

Elapsed: 00:00:00.02
SQL>


Q18:-Find the second-highest salary in the Employee table.

select * from emp e1 where 1=(select count(distinct(e2.sal)) from emp e2 where e1.sal<e2.sal); -- written self
SQL>
SQL> select * from emp e1 where 1=(select count(distinct(e2.sal)) from emp e2 where e1.sal<e2.sal);

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20

SQL>


Q:19-Select all the records from the Student table, where the names are either Anu or Dan.

select * from student where names in ('Anu','Dan');

Q:20 Select all the records from the Student table where the name is not Anu and Dan.

select * from student where names not in ('Anu','Dan');
Q21: Get Nth Record from the Student table.  ==> todo (rowid and rownum)
 -select * from emp where rownum=

Q:22 Get the 3 Highest salaries records from the Student table
 similar to second highest sal Q18
 
Q:-23 Show even rows in the Student table
  1* select * from emp where empno=decode(mod(empno,2)=0,empno)
SQL> /
select * from emp where empno=decode(mod(empno,2),empno)
                              *
ERROR at line 1:
ORA-00938: not enough arguments for function


SQL> ed
Wrote file afiedt.buf

  1* select mod(empno,2), empno, ename from emp
SQL> /

MOD(EMPNO,2)      EMPNO ENAME
------------ ---------- ----------
           1       7839 KING
           0       7698 BLAKE
           0       7782 CLARK
           0       7566 JONES
           0       7788 SCOTT
           0       7902 FORD
           1       7369 SMITH
           1       7499 ALLEN
           1       7521 WARD
           0       7654 MARTIN
           0       7844 TURNER
           0       7876 ADAMS
           0       7900 JAMES
           0       7934 MILLER

14 rows selected.

SQL> ed
Wrote file afiedt.buf

  1* select mod(empno,2), empno, ename from emp where mod(empno,2)=0
SQL> /

MOD(EMPNO,2)      EMPNO ENAME
------------ ---------- ----------
           0       7698 BLAKE
           0       7782 CLARK
           0       7566 JONES
           0       7788 SCOTT
           0       7902 FORD
           0       7654 MARTIN
           0       7844 TURNER
           0       7876 ADAMS
           0       7900 JAMES
           0       7934 MILLER

10 rows selected.

SQL> select * from emp where mod(rownum,2)=0;

no rows selected

SQL> select * from emp where mod(empno,2)=0;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

10 rows selected.

SQL>










Q241 Show Even rows in the Student table
similar to 23 need to change 0 for even 1 for odd

Q:25 Get the DDL of a table
create, alter, rename , truncate

Q:26 Get all the records from Employees who have joined in the year 2020.
select * from emp where to_char(hiredate,'yyyy')=2020;


SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

14 rows selected.

SQL> select * from emp where to_char(hiredate,'yyyy')=1981
  2  ;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30

10 rows selected.


Q27 : Find the maximum salary of each department.
select max(sal) , deptno from emp group by deptno;


SQL> select max(sal) , deptno from emp group by deptno;

  MAX(SAL)     DEPTNO
---------- ----------
      2850         30
      3000         20
      5000         10

Q-28 Find all Employees with their managers.
select e1.* from emp e1,emp e2 where e1.empno=e2.mgr and e1.empno<> e2.empno -- wrong because we have to find the 
e1 --> mgr to empno to e2 as we are mapping we have to care about the quries we wrote while writing where condition
-->final result
SQL> ed
Wrote file afiedt.buf

 select
 e1.ename as employee , e2.ename as manager
 from emp e1 ,emp e2
 where
  e1.mgr=e2.empno
SQL> /

EMPLOYEE   MANAGER
---------- ----------
JONES      KING
CLARK      KING
BLAKE      KING
JAMES      BLAKE
TURNER     BLAKE
MARTIN     BLAKE
WARD       BLAKE
ALLEN      BLAKE
MILLER     CLARK
FORD       JONES
SCOTT      JONES
ADAMS      SCOTT
SMITH      FORD

13 rows selected.



Q:- Display the name of employees who joined in 2020 and have a salary is greater than 50000.
 select ename form emp where to_char(hiredate,'yyyy') = 2020 and sal> 50000;
 
 Wrote file afiedt.buf

  1* select ename from emp where to_char(hiredate,'yyyy') = 2020 and sal> 50000
SQL> /

no rows selected

SQL> ed
Wrote file afiedt.buf

  1* select ename from emp where to_char(hiredate,'yyyy') = 1981 and sal> 1250
SQL> /

ENAME
----------
KING
BLAKE
CLARK
JONES
FORD
ALLEN
TURNER

7 rows selected.

SQL> select * from emp where to_char(hiredate,'yyyy')=1981;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30

10 rows selected.

 

Q:-Get the first 5 Records from the Student table.

SQL> select * from  emp where rownum<=5;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20

SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

14 rows selected.
Q:-Get information of Employees where Employee is not assigned to any department.
 select * from emp where deptno is null;
Q:-Show 1 to 100 Numbers 
function/  Rownum --later todo

SQL> select level as numbers from dual connect by level<=10;

   NUMBERS
----------
         1
         2
         3
         4
         5
         6
         7
         8
         9
        10

10 rows selected.

SQL>

Q: Find duplicate rows in a table
select deptno,job from emp group by deptno,job having count(empno)>1;

SQL> ed
Wrote file afiedt.buf

  1* select deptno,job,count(empno) from emp group by deptno,job having count(empno)>1
SQL> /

    DEPTNO JOB       COUNT(EMPNO)
---------- --------- ------------
        20 CLERK                2
        30 SALESMAN             4
        20 ANALYST              2

SQL> ed
Wrote file afiedt.buf

  1* select deptno,job,count(empno) from emp group by deptno,job
SQL> /

    DEPTNO JOB       COUNT(EMPNO)
---------- --------- ------------
        20 MANAGER              1
        20 CLERK                2
        30 SALESMAN             4
        30 CLERK                1
        10 PRESIDENT            1
        30 MANAGER              1
        10 CLERK                1
        10 MANAGER              1
        20 ANALYST              2

9 rows selected.

SQL>
Q Get the previous month’s last day.


  1* select sysdate,to_date(to_char(sysdate,'mm')-1,'mm') as pre_month from dual --not reocommanded because it fail if current mont his jan
SQL> /

SYSDATE   PRE_MONTH
--------- ---------
17-FEB-23 01-JAN-23

SQL> Select To_char(ADD_MONTHS(sysdate,-1),'MON') "PREV_MONTH" from dual;

PREV_MONTH
------------
JAN

SQL> ed
Wrote file afiedt.buf

  1* Select To_char(ADD_MONTHS(sysdate,-2),'MON') "PREV_MONTH" from dual
SQL> /

PREV_MONTH
------------
DEC

SQL>

Q:-Display a string vertically.

SQL> ed
Wrote file afiedt.buf

  1  select
  2    substr('oracle',level,1) substr1
  3  from
  4     dual
  5* connect by level <= length('oracle')
SQL> /

SUBS
----
o
r
a
c
l
e

6 rows selected.


Q:- The marks column in the Student table contains comma-separated values. 
How would you calculate the number of those comma-separated values?

this will we done in function topic todo


Q: Get the 3rd highest salary using Rank Function.
 in oracle we dont have the rank function we use co-related quries


Q:DDL:-Create a table with its structure the same as the structure of the Student table.
create table clone_Student as select * from student where 1<>1


SQL> create table tmp_t as select * from temp_emp where 1<>1;

Table created.

SQL> select * from tmp_t;

no rows selected

SQL>

Q:- Display first 25% records from the Student table
select * from emp where rownum<=25;

Q:- Display last 25% records from the Student table
TODO --> for rownum , rowid
Q:- Create a table with the same structure and data as the Student table
similar to DDL where we to remove the where condition

Q: Get only the common records between two tables
Wrote file afiedt.buf

  1  select * from temp_emp
  2  intersect
  3* select * from tmp_emp
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

14 rows selected.

SQL>


  1  select * from temp_emp
  2  union
  3* select * from tmp_emp
SQL> /

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
        11 anil       IT                                    200
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20
      7499 ALLEN      SALESMAN        7698 20-FEB-81       1600        300         30
      7521 WARD       SALESMAN        7698 22-FEB-81       1250        500         30
      7566 JONES      MANAGER         7839 02-APR-81       2975                    20
      7654 MARTIN     SALESMAN        7698 28-SEP-81       1250       1400         30
      7698 BLAKE      MANAGER         7839 01-MAY-81       2850                    30
      7782 CLARK      MANAGER         7839 09-JUN-81       2450                    10
      7788 SCOTT      ANALYST         7566 19-APR-87       3000                    20
      7839 KING       PRESIDENT            17-NOV-81       5000                    10
      7844 TURNER     SALESMAN        7698 08-SEP-81       1500          0         30
      7876 ADAMS      CLERK           7788 23-MAY-87       1100                    20
      7900 JAMES      CLERK           7698 03-DEC-81        950                    30
      7902 FORD       ANALYST         7566 03-DEC-81       3000                    20
      7934 MILLER     CLERK           7782 23-JAN-82       1300                    10

15 rows selected.


Q:Get unique records from the table without using distinct keywords.
select deptno,job from emp group by deptno,job having count(empno) =1;

  1* select deptno,job,count(empno) from emp group by deptno,job having count(empno) =1
SQL> /

    DEPTNO JOB       COUNT(EMPNO)
---------- --------- ------------
        20 MANAGER              1
        30 CLERK                1
        10 PRESIDENT            1
        30 MANAGER              1
        10 CLERK                1
        10 MANAGER              1

6 rows selected.

SQL> select job,deptno,ename from emp order by deptno;

JOB           DEPTNO ENAME
--------- ---------- ----------
MANAGER           10 CLARK
CLERK             10 MILLER
PRESIDENT         10 KING
ANALYST           20 FORD
ANALYST           20 SCOTT
MANAGER           20 JONES
CLERK             20 SMITH
CLERK             20 ADAMS
SALESMAN          30 WARD
SALESMAN          30 MARTIN
SALESMAN          30 TURNER
CLERK             30 JAMES
SALESMAN          30 ALLEN
MANAGER           30 BLAKE

14 rows selected.

SQL>
Q: Find the admission date of the Student in YYYY-DAY-Date format.

SQL> select to_char(hiredate,'yyyy-day-')||sysdate as "yyyy-day-date" from emp;

yyyy-day-date
------------------------------------------------------------
1981-tuesday  -17-FEB-23
1981-friday   -17-FEB-23
1981-tuesday  -17-FEB-23
1981-thursday -17-FEB-23
1987-sunday   -17-FEB-23
1981-thursday -17-FEB-23
1980-wednesday-17-FEB-23
1981-friday   -17-FEB-23
1981-sunday   -17-FEB-23
1981-monday   -17-FEB-23
1981-tuesday  -17-FEB-23
1987-saturday -17-FEB-23
1981-thursday -17-FEB-23
1982-saturday -17-FEB-23

14 rows selected.

SQL>

Q:-Convert the System time into seconds.
SQL> select to_char(sysdate,'sssss') from dual;

TO_CH
-----
62813

SQL>

Q:- Display monthly Salary of Employee given annual salary.

select sal/12 as "monthly-sal" from emp ;


SQL> select sal/12 as "monthly-sal" from emp ;

monthly-sal
-----------
 416.666667
      237.5
 204.166667
 247.916667
        250
        250
 66.6666667
 133.333333
 104.166667
 104.166667
        125
 91.6666667
 79.1666667
 108.333333

14 rows selected.

SQL>

Q:- Get the first record from the Student table
select * from emp where rownum=1;
or 
select * from emp where rownum<=1;

Get the last record from the Student table
select * from emp where rownum<=1 order by empno;
TODO
