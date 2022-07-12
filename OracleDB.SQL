show user;
desc emp;
desc dept;
desc salgrade;
select * from emp;
SELECT EMPNO, ENAME, DEPTNO FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP; --DISTINCT 중복제거
SELECT ALL JOB, DEPTNO FROM EMP; -- ALL 모두 출력
SELECT ENAME, SAL, SAL*12+COMM,COMM FROM EMP; --수식 입력 CAN
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM FROM EMP; -- AS  로 별칭 , 회사에서는 AS생략시 ""로 헷갈리않게 가독성을 맞춰준다고하심

-- ORDER BY (정렬)
SELECT * FROM EMP ORDER BY SAL; --ORDER BY로 SAL(급여기준)순으로 오름차순 정렬
SELECT * FROM EMP ORDER BY SAL DESC; -- ORDER BY DESC 내림차순 정렬
SELECT * FROM EMP ORDER BY DEPTNO ASC, SAL DESC; --각각의 열에 내림차순, 오름차순 동시 사용

-- WHERE (조건)
-- 아래쪽은 WHERE절에서 사용할 수 있는 문법들 
SELECT * FROM EMP WHERE DEPTNO = 30; --조건검색
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';-- WHERE .. AND .. 동시조건만족(AND연산자)
SELECT * FROM EMP WHERE DEPTNO = 30 OR JOB = 'SALESMAN'; -- WHERE .. OR .. 둘중하나만족(OR연산자)

-- 연산자 종류와 활용
SELECT * FROM EMP WHERE SAL*12 = 36000; --곱셈 연산자
SELECT * FROM EMP WHERE SAL>=3000; -- 비교 연산자
SELECT * FROM EMP WHERE ENAME>='F'; -- 문자 대소 비교연산
SELECT * FROM EMP WHERE SAL != 3000; -- 등가 연산자 => 값이 다를경우 TRUE
SELECT * FROM EMP WHERE SAL <> 3000; -- !=,<>,^= 세가지 다 같은의미(등가연산자)
SELECT * FROM EMP WHERE NOT SAL = 3000; -- 논리 부정 연산자 NOT
SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK'); --IN연산자 -> NOT IN 하면 반대

-- BETWEEN A AND B
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000; --NOT BETWEEN 하면 반대

-- LIKE 연산자 -> 와일드카드는 여러글자 %와 한글자 _
SELECT * FROM EMP WHERE ENAME LIKE 'S%'; 
SELECT * FROM EMP WHERE ENAME LIKE '_L%'; -- 사원이름 두번째 글자가 L인 사원만 출력
SELECT * FROM EMP WHERE ENAME LIKE '%AM%'; -- 사원이름에 AM이 포함되어있는 사원 데이터만 출력
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%'; -- 사원이름에 AM이 포함되어있지 않은 사원 데이터만 출력

-- IS NULL 연산자
SELECT * FROM EMP WHERE COMM IS NULL; --COMM은 직속상관 열 -> 직속상관이 없는 열 출력
SELECT * FROM EMP WHERE COMM IS NOT NULL; -- 위와 반대 -> 직속상관이 있는 열만 출력
SELECT * FROM EMP WHERE SAL > NULL OR COMM IS NULL; -- OR연산자와 IS NULL연산자 사용하기

-- 집합 연산자 UNION, MINUS, INTERSECT
-- 쿼리가 길어질수록 가독성있게 사용하겠다
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 20;  --합집합을 의미하는 UNION 연산자

SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;  --차집합을 의미하는 MINUS 연산자 -> 10번 부서에 있는 사원 데이터 제외한 결과 값 출력

SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO = 10;  --교집합을 의미하는 INTERSECT 연산자

-- 문자데이터 가공 함수
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) -- 순서: 모두 대문자로, 소문자로(LOWER), 첫글자만대문자(UPPER) 나머지 소문자로(INITCAP)
FROM EMP;

--SUBSTR함수 -> 문자열 일부 추출
SELECT ENAME, LENGTH(ENAME) FROM EMP; --문자열 길이 구하는 LENGTH
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB,5) FROM EMP; -- 문자열 일부 추출하는 SUBSTR함수 -> 과장님께서 이 함수 사내 DB에서 많이 쓰인다고 알려주셨다
-- SUBSTR(JOB, 1, 2)은 첫번째 글자부터 2개 출력 

-- INSTR 함수 -> 글자 위치 찾아주는 함수
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, -- L찾기 위치
        INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, -- 5번째 글자부터 시작해서 L찾기
        INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3 -- 2번째 글자부터 시작해서 두번째 L찾기
    FROM DUAL;   -- 특정 문자 위치 찾아주는 INSTR 함수
    

--REPLACE함수    
SELECT '010-1234-5678' AS REPLACE_BEFORE,
        REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1, -- -를 한칸띄어쓰기로
        REPLACE('010-1234-5678', '-') AS REPLACE_2 -- -를 없앰
    FROM DUAL; -- 특정 문자를 다른 문자로 바꾸는 REPLACE 함수
    
-- LPAD,RPAD함수    
SELECT 'Oracle',
        LPAD('Oracle', 10, '#') AS LPAD_1, --10자리 지정하고 글자 6개를 제외한 나머지 왼쪽4개를 문자로 지정 -> LPAD함수
        RPAD('Oracle', 10, '*') AS RPAD_2, --10자리 지정하고 글자 6개를 제외한 나머지 오른쪽4개를 문자로 지정 -> RPAD함수
        LPAD('Oracle', 10) AS LPAD_2,
        RPAD('Oracle', 10) AS LPAD_2
    FROM DUAL;
    
--CONCAT함수 => 문자열 데이터 연결
SELECT CONCAT(EMPNO, ENAME),
        CONCAT(EMPNO, CONCAT(' : ', ENAME))
    FROM EMP
    WHERE ENAME='SCOTT';

-- TRIM 함수 -> 공백 지우기
SELECT '[' || TRIM(' _ _Oracle_ _ ') || ']' AS TRIM
FROM DUAL;

-- 특정 문자를 지우는 TRIM, LTRIM, RTRIM 함수
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM,
        '[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
        '[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM
FROM DUAL;


-- 숫자 데이터를 연산하고 수치를 조정하는 숫자 함수

--ROUND함수
SELECT ROUND(1234.5678) AS ROUND, 
        ROUND(1234.5678, 0) AS ROUND_0,
        ROUND(1234.5678, 1) AS ROUND_1,
        ROUND(1234.5678, 2) AS ROUND_2,
        ROUND(1234.5678, -1) AS ROUND_MINUS1,  -- -1 자연수 첫째짜리까지 반올림 => 1230
        ROUND(1234.5678, -2) AS ROUND_MINUS2   -- -2 자연수 둘째짜리까지 반올림 => 1200
    FROM DUAL;

--TRUNC함수
SELECT TRUNC(1234.5678) AS TRUNC, 
        TRUNC(1234.5678, 0) AS TRUNC_0,
        TRUNC(1234.5678, 1) AS TRUNC_1,
        TRUNC(1234.5678, 2) AS TRUNC_2,
        TRUNC(1234.5678, -1) AS TRUNC_MINUS1, 
        TRUNC(1234.5678, -2) AS TRUNC_MINUS2  0
    FROM DUAL;
    
--CEIL, FLOOR 함수 => 지정한 숫자와 가까운 정수를 찾는 것
SELECT CEIL(3.14),
        FLOOR(3.14)
FROM DUAL; 

--MOD함수
SELECT MOD(15, 6)
FROM DUAL;  -- 나머지

-- 날짜 데이터를 다루는 함수 
-- SYSDATE함수를 사용하여 날짜 출력(일)
SELECT SYSDATE AS NOW, 
        SYSDATE-1 AS YESTERDAY, --하루이전 -1
        SYSDATE+1 AS TOMORROW   --하루 후 +1
    FROM DUAL;
    
-- ADD_MONTHS(개월)
SELECT SYSDATE,
        ADD_MONTHS(SYSDATE, 3) --3개월 후 날짜 구하기
    FROM DUAL; 
-- 예시(이함수가 많이 쓰인다고하심)
-- 입사 32년 미만인 사원 데이터 출력하기
SELECT EMPNO, 
        ENAME, HIREDATE, SYSDATE
    FROM EMP
WHERE ADD_MONTHS(HIREDATE, 384) > SYSDATE; 

-- MONTHS_BETWEEN -> 두 날짜 간의 개월 수 차이 구하는 함수
SELECT ENPNO, ENAME, HIREDATE, SYSDATE,
        MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1
    FROM EMP;
    
-- 돌아오는 요일의 날짜 구하는 NEXT_DAY, 특정 날짜가 속한 달의 마지막 날짜 출력 LAST_DAY
SELECT SYSDATE, 
        NEXT_DAY(SYSDATE, '월요일'),
        LAST_DAY(SYSDATE)
    FROM DUAL;

-- ROUND 함수로 날짜 데이터 줄력
SELECT SYSDATE, 
        ROUND(SYSDATE, 'CC') AS FORMAT_CC,
        ROUND(SYSDARE, 'YYYY') AS FORMAT_YYYY
    FROM DUAL;
    
    
--숫자와 문자열 더하여 출력
SELECT EMPNO, ENAME, EMPNO + '500'
    FROM EMP
    WHERE ENAME = 'SCOTT';
    
    
-- TO_CHAR -- 날짜, 숫자 데이터를 문자데이터로 변환해 주는 함수
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
    FROM DUAL;


-- 월과 요일을 다양한 형식으로 출력하기
SELECT SYSDATE, 
        TO_CHAR(SYSDATE, 'MM') AS MM,
        TO_CHAR(SYSDATE, 'MON') AS MON,
        TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
        TO_CHAR(SYSDATE, 'DD') AS DD
    FROM DUAL;
    
-- SYSDARE 시간 형식 지정하여 출력
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
    TO_CHAR(SYSDATE, 'HH24:MI:SS AM') AS HH24MISS_AM
    FROM DUAL;
    
--여러가지 숫자 형식 사용하여 급여 출력
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$,
    TO_CHAR(SAL, 'L999,999') AS SAL_L,
    TO_CHAR(SAL, '999,999.00') AS SAL_1
    FROM EMP;

--  문자 데이터를 숫자 데이터로 변환하는 TO_NUMBER
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
    FROM DUAL;
    
    
-- 문자 데이터를 날짜 데이터로 변환하는 TO_DATE
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE1,
        TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE2
    FROM DUAL;
    
--날짜 데이터끼리는 연산가능
SELECT * FROM EMP 
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

-- 여러가지 형식으로 날짜 데이터 출력하기
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
        TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49
    FROM DUAL;
    
    
-- NULL처리함수 NVL
--NVL함수 사용하여 출력하기
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
    NVL(COMM, 0),
    SAL+NVL(COMM, 0)
    FROM EMP; --NVL로 NULL을 0으로 처리하여 사용
    
--NVL2는 NVL과 비슷하지만 데이터가 NULL이 아닐때 반환할 데이터를 추가로 지정CAN
SELECT EMPNO, ENAME, COMM, 
        NVL2(COMM, 'O', 'X'),
        NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
    FROM EMP;
    
--조건문 DECODE합수
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
            'MANAGER', SAL*1.1,
            'SALESMAN',SAL*1.05,
            'ANALYST', SAL,
            SAL*1.03) AS UPSAL
        FROM EMP;
        
-- CASE문
-- 특정 조건에 따라 반환할 데이터를 설정할 때 사용
SELECT EMPNO, ENAME, JOB, SAL, 
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
    FROM EMP;
    
    
    
-- 다중행 함수
-- 여러 행 바탕으로 하나의 결가 값 도출해내기 위해 사용하는 함수
SELECT SUM(SAL) FROM EMP;

-- 합계 구하는 SUM 함수
SELECT SUM(DISTINCT SAL),
        SUM(ALL SAL),
        SUM(SAL)
    FROM EMP;

-- 데이터 개수 구하는 COUNT 함수
SELECT COUNT(DISTINCT SAL), 
        COUNT(ALL SAL),
        COUNT(SAL)
    FROM EMP;
    
-- 최대와 최소 구하는 MAX, MIN 함수
-- 예시 : 부서번호 10번인 사원의 최대, 최소 급여 구하기
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10;
SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 10;

-- 평균 구하는 AVG 함수
SELECT AVG(DISTINCT SAL) 
    FROM EMP
    WHERE DEPTNO = 30;
    
-- GROUP BY -- 데이터를 그룹화
-- GROUP BY를 사용하여 부서별 평균 급여 출력
SELECT AVG(SAL), DEPTNO
    FROM EMP
GROUP BY DEPTNO;

-- GROUP BY에 조건을 줄때 사용하는 HAVING절
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;
--HAVING과 WHERE의 유의점 -> WHERE는 출력대상 행을 제한하고 HAVING은 그룹화된 대상을 제한하므로 쓰임이 다르다 주의

-- 그룹화와 관련된 여러 함수 ROLLUP, CUBE, GROUPING SETS함수
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;  -- 기존 GROUP BY절만 사용한 그룹화

-- ROLLUP 함수 적용한 그룹화
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

-- CUBE 함수 적용한 그룹화
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- GROUPING SETS 함수 사용하여 열별로 그룹으로 묶어 출력
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


-- 조인

-- 열 이름을 비교하는 조건식으로 조인
SELECT * 
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

-- 테이블 이름을 별칭으로 표현
SELECT * 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 조인 종류 

-- 등가 조인
-- 두 테이블에 부서 번호가 똑같은 열 이름으로 포함되어 있을 때
SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;

-- 열 이름에 각각의 테이블 이름도 함께 명시할 때
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    ORDER BY D.DEPTNO, E.EMPNO;
    
-- 비등가 조인 -- 등가 조인 방식 외의 방식을 의미
-- 급여 범위를 지정하는 조건식으로 조인하기
SELECT *
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- 자체 조인
-- 같은 테이블을 두번 사용하여 자체 조인하기
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- 외부 조인
-- 왼쪽 외부 조인
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

-- 오른쪽 외부 조인
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS MGR_EMPNO,
    E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;


-- SQL-99 -> 오라클 9i버전부터 SQL-99방식의 문법을 지원하고 있다

-- NATURAL JOIN을 사용하여 조인하기
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
    DEPTNO, D.DNAME, D.LOC
    FROM EMP E NATURAL JOIN DEPT D
    ORDER BY DEPTNO, E.EMPNO;
    
-- JOIN ~ USING 을 사용하여 조인하기
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
    DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D USING (DEPTNO)
    WHERE SAL >= 3000
    ORDER BY DEPTNO, E.EMPNO;
    
    
-- JOIN ~ ON 
-- 기존 WHERE 절에 있는 조인 조건식을 ON키워드 옆에 작성
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
    E.DEPTNO,
    D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
    WHERE SAL <= 3000
    ORDER BY E.DEPTNO, EMPNO;
    
-- SQL-99 왼쪽 외부 조인
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
    ORDER BY E1.EMPNO;
    
-- SQL-99 오른쪽 외부 조인
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
    ORDER BY E1.EMPNO;

-- SQL-99 전체 외부 조인
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
    ORDER BY E1.EMPNO;
    
    
--서브쿼리 --> SQL문을 실행하는 데 필요한 데이터를 추가로 조회사기 위해 SQL문 내부에서 사용하는 SELECT문을 의미
SELECT SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES');
        
        
-- 실행 결과가 하나인 단일행 서브쿼리
-- 서브쿼리의 결과 값이 날짜형인 경우
SELECT * 
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                FROM EMP
                WHERE ENAME = 'SCOTT');
                
-- 서브쿼리 안에서 함수 사용한 경우
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL) 
            FROM EMP);
    

-- 실행 결과가 여러개인 다중행 서브쿼리

-- IN연산자 사용하기
SELECT * FROM EMP WHERE DEPTNO IN (20, 30);
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력하기
SELECT * FROM EMP WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- ANY 연산자 사용하기
SELECT * 
FROM EMP 
WHERE SAL = ANY(SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);
      
-- SOME 연산자 사용하기
SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
            FROM EMP
            GROUP BY DEPTNO);
            
-- ALL연산자 사용하기
SELECT *
FROM EMP 
WHERE SAL < ALL (SELECT SAL     
                FROM EMP 
                WHERE DEPTNO = 30);
                
                
-- EXITSTS 연산자 사용하기
SELECT *
FROM EMP 
WHERE EXISTS (SELECT DNAME
                FROM DEPT
                WHERE DEPTNO = 10);
                
                
-- 비교할 열이 여러개인 다중열 서브쿼리
SELECT *
FROM EMP 
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);
                    
                    
-- FROM 절에서 사용하는 서브쿼리와 WITH절

--인라인 뷰 사용하기
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
        (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 사용하기
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT 절에서 서브쿼리 사용하기
SELECT EMPNO, ENAME, JOB, SAL,
        (SELECT GRADE
            FROM SALGRADE
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
            DEPTNO,
            (SELECT DNAME
                FROM DEPT
            WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
        FROM EMP E;
        
        
-- DML --> 데이터를 추가, 삭제, 수정하는 데이터 조작어

-- DEPT테이블 복사해서 DEPT_TEMP 테이블 만들기
CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

-- 테이블에 데이터 추가하는 INSERT문
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
        VALUES(50, 'DATABASE', 'SEOUL');
        
SELECT * FROM DEPT_TEMP;

-- 테이블에 날짜 데이터 입력하기
-- EMP테이블 복사해서 EMP_TEMP테이블 만들기 FOR 실습
CREATE TABLE EMP_TEMP
AS SELECT * 
FROM EMP
WHERE 1 <> 1;

SELECT * FROM EMP_TEMP;

-- INSERT 문으로 날짜 데이터 입력하기
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
                VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01',
                5000,1000,10);
                
SELECT * FROM EMP_TEMP;

-- TO_DATE 함수를 사용하여 날짜 데이터 입력하기
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR,
                    HIREDATE, 
                    SAL, COMM, DEPTNO)
                VALUES(2111, '이순신', 'MANAGER', 9999,
                TO_DATE('07/01/2001','DD/MM/YYYY'),
                4000, NULL, 20);
SELECT * FROM EMP_TEMP;

-- SYSDATE를 사용하여 날짜 데이터 입력하기
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(3111,'심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

SELECT * FROM EMP_TEMP;

-- 서브쿼리로 여러 데이터 추가하기
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE = 1;

SELECT * FROM EMP_TEMP;

-- 테이블에 있는 데이터 수정하기 UPDATE

-- DEPT 테이블을 복사해서 DEPT_TEMP2 테이블 만들기
CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP2;


-- UPDATE사용하여 LOC열의 데이터를 모두 SEOUL로 수정
UPDATE DEPT_TEMP2
SET LOC = 'SEOUL';

SELECT * FROM DEPT_TEMP2;

--되돌리기
ROLLBACK;

-- 데이터 일부분만 수정하기
UPDATE DEPT_TEMP2
SET DNAME='DATEBASE',
    LOC='SEOUL'
WHERE DEPTNO = 40;

SELECT * FROM DEPT_TEMP2;


-- 서브쿼리로 데이터 일부분 수정하기
UPDATE DEPT_TEMP2
    SET(DNAME, LOC) = (SELECT DNAME, LOC
                        FROM DEPT
                        WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

SELECT * FROM DEPT_TEMP2;

-- 서브쿼리로 데이터 일부분 수정하기
UPDATE DEPT_TEMP2
SET DMAME = (SELECT DNAME  
            FROM DEPT
            WHERE DEPTNO = 40),
        LOC = (SELECT LOC
                FROM DEPT
                WHERE DEPTNO = 40)
    WHERE DEPTNO = 40;
    

-- 테이블에 있는 데이터 삭제하기 DELETE
-- EMP복사해서 EMP_TEMP2만들기
CREATE TABLE EMP_TEMP2
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_TEMP2;

-- WHERE절 사용해서 데이터 일부분만 삭제
DELETE FROM EMP_TEMP2
WHERE JOB = 'MANAGER';

SELECT * FROM EMP_TEMP2;

-- WHERE절에서 서브쿼리를 사용하여 데이터 일부 삭제
DELECT FROM EMP_TEMP2
WHERE EMPNO IN (SELECT E.EMPNO
                FROM EMP_TEMP2 E, SALGRADE S
                WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                AND S.GRADE = 3
                AND DEPTNO = 30);
                
SELECT * FROM EMP_TEMP2;


-- 데이터 전체 삭제
DELETE FROM EMP_TEMP2;


-- 트랜잭션
-- 트랜잭션을 제어하는 명령어

-- DEPT 테이블을 복사해서 DEPT_TCL테이블 만들기
CREATE TABLE DEPT_TCL
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_TCL;

-- DEPT_TCL테이블에 데이터 입력, 수정, 삭제하기
INSERT INTO DEPT_TCL VALUES(50, 'DATEBASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO=40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL;

-- 트랜잭션을 취소하고 싶을때 ROLLBACK
ROLLBACK;
SELECT * FROM DEPT_TCL;

-- 트랜잭션을 영원히 반영하고 싶을 때는 COMMIT
INSERT INTO DEPT_TCL VALUES(50, 'DATEBASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO=40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL;

COMMIT;


-- DDL 데이터 정의어 -> 객체를 생성, 삭제, 변경하는 데이터 정의어
-- 실습
-- 각 열의 자료형을 정의해서 테이블 생성하기
CREATE TABLE EMP_DDL(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2)
    );
    
    DESC EMP_DDL;
    
-- 기존 테이블 열 구조와 데이터를 복사하여 새 테이블 생성
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
    
DESC DEPT_DDL;

SELECT * FROM DEPT_DDL;

-- 다른 테이블의 일부 복하사여 테이블 생성하기
CREATE TABLE EMP_DDL_30
AS SELECT * FROM EMP
WHERE DEPTNO = 30;

SELECT * FROM EMP_DDL_30;

-- 테이블을 변경하는 ALTER
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;


SELECT * FROM EMP_ALTER;

-- 테이블에 열 추가하는 ADD
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);
    
SELECT * FROM EMP_ALTER;

-- ALTER 명령으로 HP열 이름을 TEL로 변경하기
ALTER TABLE EMP_ALTER
RENAME COLUMN HP TO TEL;

SELECT * FROM EMP_ALTER;

-- ALTER명령으로 EMPNO 열 길이 변경하기
-- 열의 자료형을 변경하는 MODIFY
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);

DESC EMP_ALTER;

-- 특정 열을 삭제할 때 사용하는 DROP
ALTER TABLE EMP_ALTER
DROP COLUMN TEL;

SELECT * FROM EMP_ALTER;

-- 테이블 이름 변경하는 RENAME
RENAME EMP_ALTER TO EMP_RENAME; 
DESC EMP_ALTER; -- 오류
SELECT * FROM EMP_RENAME;

-- 테이블이 데이터를 삭제하는 TRUNCATE
TRUNCATE TABLE EMP_RENAME;
SELECT * FROM EMP_RENAME;

-- 테이블 삭제하는 DROP
DROP TABLE EMP_RENAME;


-- 데이터 사전
SELECT * FROM DICT;


-- USER 접두어를 가진 데이터 사전
SELECT TABLE_NAME FROM USER_TABLES;

-- ALL_ 접두어를 가진 데이터 사전
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- DBA_ 접도어 가진 데이터 사전
SELECT * FROM DBA_TABLES; -- 오류 : 이유는 시스템 계정으로 접근CAN


-- 더빠른 검색을 위한 인덱스
-- SCOTT이 소유한 인덱스 컬럼 정보 알아보기
SELECT * FROM USER_IND_COLUMNS;

-- EMP 테이블의 SAL열에 인덱스 생성하기
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;



-- 제약 조건
-- 테이블을 생성할 때 NOT NULL 설정하기
CREATE TABLE TABLE_NOTNULL(
        LOGIN_ID VARCHAR2(20) NOT NULL,
        LOGIN_PWD VARCHAR2(20) NOT NULL,
        TEL       VARCHAR2(20)
        );
        
-- 제약 조건이 NOT NULL인 열에 NULL값 넣어보기
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL)
VALUES ('TEST_ID_01', NULL, '010-1234-4567');

-- 제약 조건이 없는 TEL열에 NULL값 입력하기
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD)
VALUES('TEST_ID_01', '1234');

SELECT * FROM TABLE_NOTNULL;

-- SCOTT계정 제약조건 살펴보기
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- 테이블 생성할 때 제약조건에 이름 지정
CREATE TABLE TABLE_NOTNULL2(
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
    TEL        VARCHAR2(20)
    );
    
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- TEL 열에 NOT NULL 제약 조건 추가하기
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);

-- TEL열 데이터 수정하기
UPDATE TABLE_NOTNULL
    SET TEL='010-1234-5678'
    WHERE LOGIN_ID='TEST_ID_01';
    
SELECT * FROM TABLE_NOTNULL;

-- NOT NULL 제약 조건 추가하기
ALTER TABLE TABLE_NOTNULL
MODIFY(TEL NOT NULL);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;


-- 제약 조건에 이름 지정해서 추가하기
ALTER TABLE TABLE_NOTNULL2
MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

-- TANLE_NOTNULL2 테이블 열 구조 확인
DESC TABLE_NOTNULL2;

-- 이미 생성된 제약조건 이름 변경하기
ALTER TABLE TABLE_NOTNULL2
RENAME CONSTRAINT TBLNN_TEL_NN TO TBLNN2_TEL_NN;

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- 제약 조건 삭제
ALTER TABLE TABLE_NOTNULL2
DROP CONSTRAINT TALNN2_TEL_NN;

DESC TABLE_NOTNULL2;


-- 중복되지 않는 값 UNIQUE
-- 실습을 위해 제약 조건 지정한 테이블 생성
CREATE TABLE TABLE_UNIQUE(
    LOGIN_ID    VARCHAR2(20) UNIQUE,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
    );
    
DESC TABLE_UNIQUE;

-- 중복 허락X UNIQUE
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
VALUES('TEST_ID_01', 'PWD01', '010-1234-5678');

SELECT * FROM TABLE_UNIQUE;

-- 중복되는 데이터 넣으면 안들어감
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
VALUES('TEST_ID_01', 'PWD01', '010-1234-5678');


-- 유일하게 하나만 있는값 PRIMARY KEY
-- 실습을 위해 테이블 지정하며 제약조건 지정하기
CREATE TABLE TABLE_PK(
    LOGIN_ID    VARCHAR2(20) PRIMARY KEY, 
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
    );
    
    DESC TABLE_PK;
    
-- 생성한 PK 확인하기
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'TABLE_PK%';


-- 다른 테이블과 관계를 맺는 FOREIGN KEY
-- 실습을 위해 DEPT_FK 테이블 생성하기
CREATE TABLE DEPT_FK(
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR(14),
LOC   VARCHAR(13)
);

DESC DEPT_FK;

-- EMP_FK 테이블 생성하기
CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO)
    );
    
 DESC EMP_FK;

-- DEPT_FK에 데이터 삽입하기
INSERT INTO DEPT_FK
VALUES(10, 'TEST_DNAME', 'TEST_LOC');

SELECT * FROM DEPT_FK;


-- 기본값을 정하는 DEFAULT
 CREATE TABLE TABLE_DEFAULT(
    LOGIN_ID VARCHAR2(20) CONSTRAINT IBLCK2_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20)
    );
    
    DESC TABLE_DEFAULT;
    
-- 사용자 관리 -> SYSTEM 계정으로


-- PL/SQL  -> SQL만으로 구현이 어려운 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어

-- HELLO PL/SQL 출력학
SET SERCEROUTPUT ON;
BEGIN
DBMS_OUTPUT.PUT_LINE('HELL0, PL/SQL!');
END;

-- 한줄 주석 사용하기
DECLARE
V_EMPNO NUMBER(4) := 7788;
V_ENAME VARCHAR2(10);
BEGIN
V_ENAME := 'SCOTT';
-- DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/
-- 여러줄 주석은 /* ~ */

-- 변수 선언 및 변수 값 출력하기
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/


-- 상수 정의하기
-- 상수 값 대입 후 출력
DECLARE
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN DBMS_OUTPUT.PUT_LINE('V_TEX : ' || V_TAX);
END;
/



-- 변수의 기본값을 설정한 후 출력하기
DECLARE 
    V_DEPTNO NUMBER(2) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO)L
END;
/


-- 변수에 NULL값 저장 막기 --> 변수에 NOT NULL을 설정하고 값을 대입한 후 출력하기
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 10;
BEGIN
    DBMS_OUPTUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

-- 변수에 NOT NULL 및 기본값을 설정한 후 출력하기
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

-- 참조형의 변수에 값을 대입한 후 출력하기
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/


-- 조건 제어문
-- 변수에 입력한 값이 홀수인지 알아보기
DECLARE 
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다');
    END IF;
END;
/


-- 홀수인지 짝수인지 알아보기
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다');
    END IF;
END;
/

DECLARE 
    V_SCORE NUMBER := 87;
BEGIN
    IF B_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
END;
/

--입력 점수에 따른 학점 출력하기 (단순 CASE 사용)
DECLARE 
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('E학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/

-- LOOP 사용하기
DECLARE 
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/


-- WHILE LOOP 사용하기
DECLARE 
    V_NUM NUMBER := 0;
BEGIN
    WHILE V_NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/


-- WHILE LOOP 사용하기
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
    END LOOP;
END;
/

-- FOR LOOP 사용하기
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : '|| i);
    END LOOP;
END;
/


-- 레코드와 컬렉션 
-- 레코드 정의해서 사용하기
DECLARE
    TPYE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
        dept_rec REC_DEPT;
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABASE';
        dept_rec.loc := 'SEOUL';
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.loc);
    END;
    /
    
-- 레코드 사용한 INSERT
CREATE TABLE DEPT_RECORD
AS SELECT * FROM DEPT;
-- DEPT_RECORD 테이블 생성하기
SELECT * FROM DEPT_RECORD;
-- 레코드를 사용하여 INSERT하기
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99;
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
        dept_rec REC_DEPT;
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABASE';
        dept_rec.loc := 'SEOUL';
    
    INSERT INTO DEPT_RECORD
    VALUES dept_rec;
    END;
    /
    
    SELECT * FROM DEPT_RECORD;
    
-- 레코드를 사용한 UPDATE
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno NUMBER(2) NOT NULL := 99;
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
        dept_rec REC_DEPT;
    BEGIN
        dept_rec.deptno := 99;
        dept_rec.dname := 'DATABASE';
        dept_rec.loc := 'SEOUL';
    
    UPDATE DEPT_RECORD
    SET ROW = dept_rec
    WHERE DEPTNO = 99;
    END;
    /
    
    SELECT * FROM DEPT_RECORD;
    
-- 중첩 레코드 -> 레코드를 포함하는 레코드
DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname DEPT.DNAME%TYPE,
        loc DEPT.LOC%TYPE
        );
        TYPE REC_EMP IS RECORD(
        empno EMP.ENPMO%TYPE
        ename EMP.ENAME%TYPE,
        dinfo REC_DEPT
        );
        emp_rec REC_EMP;
    BEGIN
        SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
        
            INTO emp_rec.empno, emp_rec.ename, 
                emp_rec.dinfo.deptno,
                emp_rec.dinfo.dname,
                emp_rec.dinfo.loc
            FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
        AND E.EMPNO = 7788;
         DBMS_OUTPUT.PUT_LINE('EMPNO : ' || dept_rec.empno);
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || dept_rec.ename);
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || dept_rec.dinfo.deptno);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || dept_rec.dinfo.dname);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || dept_rec.dinfo.loc);
    END;
    /


-- PL/SQL 예외처리
DECLARE
    v_wrong MUMBER;
BEGIN
    SELECT DNAME INFO v_wrong
        FROM DEPT
    WHERE DEPTNO = 10;
EXCEPTION
    WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('예외 처리: 수치 또는 값 오류 발생');
END;
/

-- 예외 발생 후의 코드 실행 여부 확인하기
DECLARE
    v_wrong MUMBER;
BEGIN
    SELECT DNAME INFO v_wrong
        FROM DEPT
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
EXCEPTION
    WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('예외 처리: 수치 또는 값 오류 발생');
END;
/
    
-- 사전 정의된 예외 사용하기
DECLARE 
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
        FROM DEPT
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.);

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리: 요구보다 많은 행 추출 오류 발생');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리; 수치 또는 값 오류 발생');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리: 수치 또는 값 오류 발생');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('에외 처리: 사전 정의 외 오류 발생');
END;
/

-- 오류 코드와 오류 메세지 사용하기
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INRTO v_wrong
        FROM DEPT
    WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리: 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
    END;
    /
    
    
-- 프로시저
-- 프로시저 생성하기
CREATE OR REPLACE PROCEDURE pro_noparam
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/

-- 생성한 프로시저 실행하기
SET SERCEROUTPUT ON;
EXECUTE pro_noparam;

-- 익명 블록에서 프로시저 실행하기
BEGIN
    pro_noparam;
END;
/


--USER_SOURCE를 통해 프로시저 확인하기
SELECT * FROM USER_SOURCE WHERE NAME='PRO_NOPARAM';

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'PRO_NOPARAM'; -- SQL PLUS

-- 프로시저 삭제
DROP PROCEDURE PRO_NOPARAM;

-- 프로시저 파라미터 지정
CREATE OR REPLACE PROCEDURE pro_param_in
(
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
    )
    IS
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
        DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);  
        DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
        DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
    END;
    /
    
-- 파라미터를 입력하여 프로시저 사용하기
EXECUTE pro_param_in(1,2,9,8);

-- 기본값이 지정된 파라미터 입력을 제외하고 프로시저 사용하기
EXECUTE pro_param_in(1,2);

-- 실행에 필요한 개수보다 적은 파라미터를 입력하여 프로시저 실행하기
EXECUTE pro_param_in(1);

-- 파라미터 이름 활용하여 프로시저에 값 입력
EXECUTE pro_param_in(param1 => 10, param2 => 20);


-- 함수
-- 함수 생성하기
CREATE OR REPLACE FUNCTION func_aftertax(
    sal IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.05;
BEGIN
    RETURN (ROUND(sal-(sal*tax)));
END func_aftertax;
/

-- PL/SQL에서 함수 사용하기
DECLARE
    aftertax NUMBER;
BEGIN
    aftertax := func_aftettax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

-- SQL문에서 함수 사용하기
SELECT func_aftertax(3000)
FROM DUAL;

-- 함수 삭제하기
DROP FUNCTION func_aftertax;


-- 트리거
CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
    
-- DML 실행 전에 수행할 트리거 생성하기
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF IO_CHAR(sysdate, 'DY') IN ('토','일') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '주말 사원정보 추가 불가');
        ELSIF INSERTING THEN
            raise_application_error(-20001, '주말 사원정보 수정 불가');
        ELSIF INSERTING THEN
            raise_application_error(-20002, '주말 사원정보 삭제 불가');
        ELSE INSERTING THEN
            raise_application_error(-20003, '주말 사원정보 변경 불가');
        END IF;
    END IF;
END;
/

-- 평일 날짜로 EMP_TRG테이블 UPDATE하기
UPDATE emp_trg SET sal-3500 WHEHE EMPNO == 7788;

-- 주말 날짜에 EMP_TRG 테이블 UPDATE하기
UPDATE emp_trg SET sal= 3500 WHERE empno=7788;

-- 트리거 제작 및 사용(AFTER)
-- EMP_TRG_LOG테이블 생성
CREATE TABLE EMP_TRG_LOG(
    TABLENAME VARCHAR2(10),
    DML_TYPE VARCHAR2(10),
    EMPNO NUMBER(4),
    USER_NAME VARCHAR2(30),
    CHANGE_DATE DATE
    );
    
-- DML 실행 후 수행할 트리거 생성
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER 
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW

BEGIN

    IF INSERTING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'INSERT', :new.empno,
                SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
                
    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'UPDATE', :old.empno,
                SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
                
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log
        VALUES ('EMP_TRG', 'DELETE', :old.empno,
                SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
    END IF;
END;
/

-- EMP_TRG 테이블에서 INSERT 실행하기
INSERT INTO EMP_TRG
VALUES(9999, 'TestEmp', 'CLERK', 7788,
        TO_DATE('2018-03-03', 'YYYY-MM-DD'), 1200, null, 20);
        
        
COMMIT;

-- EMP_TRG 테이블의 INSERT 확인하기
SELECT * FROM EMP_TRG;

-- EMP_TRG_LOG테이블의 INSERT기록 확인하기
SELECT * FROM EMP_TRG_LOG;

-- EMP_TRG 테이블에 UPDATE 실행하기
UPDATE EMP_TRG SET SAL = 1300 WHERE MGR = 7788;

COMMIT;

-- 트리거 관리
-- USER_TRIGGERS로 트리거 정보 조회하기
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS FROM USER_TRIGGERS;

-- 트리거 변경
ALTER TRIGGER 트리거 이름 ENABLE | DISABLE;

-- 트리거 삭제 
DROP TRIGGER 트리거 이름;



