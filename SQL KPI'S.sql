CREATE DATABASE Bank_Loan_Project;
USE Bank_Loan_Project;

/*
1. Year wise loan amount Stats
2. Grade and sub grade wise revol_bal
3. Total Payment for Verified Status Vs Total Payment for Non Verified Status
4. State wise and last_credit_pull_d wise loan status
5. Home ownership Vs last payment date stats
*/

# KPI 1 - Year wise loan amount stats
SELECT YEAR(issue_d) AS Year_of_issue_d, SUM(loan_amnt) AS Total_loan_amnt 
from finance_1
GROUP BY Year_of_issue_d
ORDER BY Year_of_issue_d;


# KPI 2
SELECT grade, sub_grade, SUM(revol_bal) AS Total_revol_bal
FROM finance_1 INNER JOIN finance_2
ON finance_1.id = finance_2.id
GROUP BY grade, Sub_grade;
              /*OR*/
SELECT finance_1.grade, finance_1.sub_grade, SUM(finance_2.revol_bal) AS Total_revol_bal
FROM finance_1
INNER JOIN finance_2 ON finance_1.id = finance_2.id
GROUP BY finance_1.grade, finance_1.sub_grade;


# KPI 3
SELECT verification_status, CONCAT("$",FORMAT(ROUND(SUM(total_pymnt)/1000000,2),2),"M") AS Total_payment
FROM finance_1 INNER JOIN finance_2
ON finance_1.id = finance_2.id
GROUP BY verification_status;


# KPI 4
SELECT addr_state, last_Credit_pull_D, loan_Status
FROM finance_1 INNER JOIN finance_2 ON finance_1.id = finance_2.id
GROUP BY addr_state, last_credit_pull_D, loan_status
ORDER BY last_credit_pull_D; 


# KPI 5
SELECT 
	   home_ownership, 
	   last_pymnt_d, 
       CONCAT('S', FORMAT (ROUND(SUM(last_pymnt_amnt) / 10000, 2), 2), 'K') AS total_amount
FROM
       finance_1 
INNER JOIN 
       finance_2 ON finance_1.id = finance_2.id
GROUP BY 
       home_ownership, last_pymnt_d
ORDER BY 
       last_pymnt_D DESC, home_ownership DESC
LIMIT 0,10000;
                       /*OR*/
SELECT 
    home_ownership, 
    last_pymnt_d, 
    CONCAT('S', FORMAT(ROUND(SUM(last_pymnt_amnt) / 10000, 2), 2), 'K') AS total_amount 
FROM 
    finance_1 
INNER JOIN 
    finance_2 ON finance_1.id = finance_2.id 
GROUP BY 
    home_ownership, last_pymnt_d 
ORDER BY 
    last_pymnt_d DESC, home_ownership DESC 
LIMIT 0, 1000;
