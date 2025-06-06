use empdb;
SELECT * FROM employee;
-- 1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT
    JOB_CODE  직급코드
     , COUNT(JOB_CODE) '직급별 사원수'
     , CAST(AVG(SALARY) AS SIGNED INTEGER) 평균급여
--      , FORMAT(AVG(SALARY),0)
FROM
    employee
GROUP BY
    JOB_CODE
HAVING
    JOB_CODE != 'J1';

/*
    --------------- 출력 예시 -------------
    직급코드  `직급별 사원수`      평균급여
    ----------------------------------------
        J2           3              4726666
        J3           3              3600000
        J4           4              2330000
        J5           3              2820000
        J6           6              2624373
        J7           4              2017500

*/

#     챗GPT 으용
# SELECT
#     CONCAT(hire_year, '년') AS 입사년,
#     CONCAT(COUNT(*), '명') AS 인원수
# FROM (
#          SELECT YEAR(HIRE_DATE) AS hire_year
#          FROM employee
#          WHERE JOB_CODE != 'J1'
#      ) AS sub
# GROUP BY hire_year
# ORDER BY hire_year;

-- 2. EMPLOYEE테이블에서 직급이 J1을 제외하고, 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
-- (select에는 groupby절에 명시한 컬럼만 작성가능)
SELECT
    INSERT(CAST(YEAR(HIRE_DATE) AS CHAR), 5, 0, '년') AS 입사년
    , COUNT(*) 인원수
FROM
    employee
WHERE
    JOB_CODE != 'J1'
GROUP BY
    YEAR(HIRE_DATE)
ORDER BY
    YEAR(HIRE_DATE);

/*
    ---- 출력 예시 -------
    입사년          인원수
    ----------------------
    1994             3
    1996             1
    1997             1
    1999             3
    2000             1
    2001             3
    ...
    총 출력row는 17

*/

# 답안지 풀이
-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.
SELECT * FROM employee;

SELECT
      CASE SUBSTR(emp_no, 8, 1)
        WHEN 1 THEN '남'
        WHEN 3 THEN '남'
        ELSE '여' END 성별
    , FORMAT(TRUNCATE(AVG(SALARY), 0),0) 평균
    , FORMAT(SUM(SALARY), 0) 합계
    , COUNT(*)
  FROM
      employee
GROUP BY
      CASE SUBSTR(emp_no, 8, 1)
        WHEN 1 THEN '남'
        WHEN 3 THEN '남'
        ELSE '여'
        END
/*
    ------------------- 출력 예시 -------------------
    셩별          평균          합계          인원수
    -------------------------------------------------
    남       "3,317,333"     "49,760,000"       15
    여       "2,757,360"     "24,816,240"       9
*/


-- 4. 직급별 인원수가 3명이상이 직급과 총원을 조회
SELECT
    JOB_CODE  직급
     , COUNT(JOB_CODE) 인원수
FROM
    employee
GROUP BY
    JOB_CODE
HAVING
    COUNT(JOB_CODE) >= 3;
/*
    ------------ 출력 예시 ---------------
    직급          인원수
    -------------------------------------
    J2              3
    J3              3
    J4              4
    J5              3
    J6              6
    J7              4


*/