use empdb;

SELECT * FROM employee;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산
SELECT
    SUM(SALARY) '급여 총 합'
FROM
    employee
WHERE
    EMP_NO LIKE '%-2%' OR EMP_NO LIKE '%-4%';

/*
    ---------- 출력 예시 ------------
    `급여 총 합`
    ---------------------------------
    24816240
*/


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
SELECT
    FORMAT(SUM(SALARY), 0) 급여총합
     , FORMAT(SUM(SALARY*BONUS), 0) '보너스 총합'
FROM
    employee
WHERE
    DEPT_CODE = 'D5';
/*
    ------- 출력 예시 ------------
    급여총합        `보너스 총합`
    ------------------------------
    15,760,000      745,000
*/

# 답안지 풀이
-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
SELECT
    FORMAT(12*(SUM(SALARY) + SUM(SALARY*BONUS)) , 0) 연봉
FROM
    employee
WHERE
    DEPT_CODE = 'D5';
/*
    ------- 출력 예시 ----------
    연봉
    ----------------------------
    198,060,000
*/


# CASE
#         WHEN menu_price < 5000 THEN '싼거'
#         WHEN menu_price BETWEEN 5000 AND 10000 THEN '적당한거'
#         WHEN menu_price BETWEEN 10000 AND 20000 THEN '좀 비싼거'
#         ELSE '많이 비싼거'

-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계) [X}
SELECT * FROM employee;


SELECT
      FORMAT(SUM(CASE WHEN SUBSTR(EMP_NO, 8, 1) IN (1,3) THEN SALARY ELSE 0 END), 0)
    , FORMAT(SUM(CASE WHEN SUBSTR(EMP_NO, 8, 1) IN (2,4) THEN SALARY ELSE 0 END), 0)

  FROM
    employee;

/*
    ---------------- 출력 예시 -------------------
    `남사원 급여 합계`         `여사원 급여 합계`
    ----------------------------------------------
     49,760,000                24,816,240
*/

-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)


/*
    ------ 출력 예시 -------
    `부서 수`
    ------------------------
    6
*/

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)