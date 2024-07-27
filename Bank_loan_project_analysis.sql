CREATE DATABASE PROJECT;


USE PROJECT;

Show tables;

select * from bank_loan;

# column information 

desc bank_loan ;


# ENABLE UPDATE QUERY 

SET SQL_SAFE_UPDATES = 1;
 
# DISABLE UPDATE QUERY
 
SET SQL_SAFE_UPDATES = 0;

# Change column data type
 
UPDATE BANK_LOAN
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y')
WHERE STR_TO_DATE(issue_date, '%d-%m-%Y') IS NOT NULL;

UPDATE BANK_LOAN
SET last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y')
WHERE STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y') IS NOT NULL;

UPDATE bank_loan
SET last_payment_date = STR_TO_DATE(last_payment_date, '%d-%m-%Y')
WHERE STR_TO_DATE(last_payment_date, '%d-%m-%Y') IS NOT NULL;

UPDATE bank_loan
SET next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y')
WHERE STR_TO_DATE(next_payment_date, '%d-%m-%Y') IS NOT NULL;

ALTER TABLE bank_loan
MODIFY issue_date DATE ,
MODIFY issue_date DATE,
MODIFY last_credit_pull_date DATE,
MODIFY last_payment_date DATE,
MODIFY next_payment_date DATE;

# describe THE DATA ---

DESC BANK_LOAN;
 
                                  # ANALYSIS THE DATA ---

# Total_loan_application -38576
 

 select count(id) as Total_loan_application from bank_loan;
 
 
 # TOTAL FUNDED AMOUNT ---   435757075
 
 SELECT sum(LOAN_AMOUNT) AS TOTAL_FUNDED_AMOUNT FROM BANK_LOAN ;
 
 
 # TOTAL_AMOUNT_RECIEVED --- 473070933
 
 SELECT SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED  FROM BANK_LOAN;

# AVG INTREST RATE ---12.05 %

SELECT ROUND(avg(INT_RATE) ,4)*100 AS AVG_INT_RATE FROM BANK_LOAN;


# AVERAGE DTI --- 13.33 %

SELECT ROUND(avg(DTI) , 4)* 100 AS AVG_DTI FROM BANK_LOAN;


# COUNT GOOD_LOAN_APPLICAATION  --- 33243

SELECT COUNT(ID) AS GOOD_LOAN_APPLICAATION  FROM BANK_LOAN
WHERE LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT';

# SUM OF GOOD_LOAN_RECIEVED_AMOUNT -- 435786170

SELECT SUM(TOTAL_PAYMENT) AS  GOOD_LOAN_RECIEVED_AMOUNT  FROM BANK_LOAN
WHERE LOAN_STATUS = 'FULLY PAID' OR LOAN_STATUS = 'CURRENT';


#  GOOD LOAN PERCENTAGE---- 86.18 %

SELECT ROUND((COUNT(CASE WHEN LOAN_STATUS = 'Fully Paid' OR LOAN_STATUS = 'Current' THEN ID END) * 100.0) / COUNT(ID), 2) AS GOOD_LOAN_PERCENTAGE 
FROM BANK_LOAN;


# COUNT BAD_LOAN_APPLICATION -- 5333

SELECT count(ID) AS BAD_LOAN_APPLICATION FROM BANK_LOAN
WHERE LOAN_STATUS = 'CHARGED OFF';

#  SUM OF BAD_LOAN_AMOUNT --- 3710416130

SELECT SUM(ID) AS  BAD_LOAN_AMOUNT  FROM BANK_LOAN
WHERE LOAN_STATUS = 'CHARGED OFF';

# BAD LOAN PERCENTAGE ---  13.82 %

SELECT ROUND((COUNT(CASE WHEN LOAN_STATUS = 'CHARGED OFF' THEN ID END) * 100 )/
count(ID) ,2) AS  BAD_LOAN_PERCENTAGE
FROM BANK_LOAN;

# LOAN_STATUS --

SELECT 
   LOAN_STATUS,
   COUNT(ID) AS TOTAL_LOAN_APPLICATION,
   SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECEIVED,
   SUM(LOAN_AMOUNT) AS TOTAL_FUNDED_AMOUNT,
   ROUND(AVG(INT_RATE) , 4) * 100 AS AVG_INT_RATE,
   ROUND(AVG(DTI) , 4 ) * 100 AS AVG_DTI
FROM  
   BANK_LOAN
GROUP BY 
   (LOAN_STATUS);
   
   
   # MONTH  WISE --
   
SELECT
    MONTH(ISSUE_DATE) AS MONTH_NUMBER,
    DATE_FORMAT(ISSUE_DATE, '%M') AS MONTH_NAME,
    COUNT(ID) AS TOTAL_LOAN_APPLICATION,
    SUM(LOAN_AMOUNT) AS TOTAL_FUNDED_AMOUNT,
    SUM(TOTAL_PAYMENT) AS TOTAL_RECEIVED_AMOUNT
FROM
    BANK_LOAN
GROUP BY
    MONTH(ISSUE_DATE), DATE_FORMAT(ISSUE_DATE, '%M')
ORDER BY
    MONTH(ISSUE_DATE);
    
    
    # STATE WISE --
    
    SELECT 
           address_state AS STATE ,
		COUNT(ID) AS TOTAL_LOAN_APPLICATION,
        SUM(LOAN_AMOUNT) AS TOTAL_LOAN_AMOUNT,
        SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED
	FROM 
        BANK_LOAN
	GROUP BY address_state
    ORDER BY address_state;
    
    
    # TERM --
    
    SELECT 
          TERM AS TERM ,
          COUNT(ID) as TOTAL_LOAN_APPLICATION ,
          SUM(LOAN_AMOUNT) AS TOTAL_LOAN_AMOUNT,
          SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED
	FROM
        BANK_LOAN
	GROUP BY TERM
    ORDER BY TERM;
    
    
    
    # EMPLOYEES LENGTH --
    
    SELECT 
          emp_length AS  EMP_LENGTH,
          COUNT(ID) AS TOTAL_LOAN_APPLICATION,
          SUM(LOAN_AMOUNT) AS TOTAL_LAON_AMOUNT,
          SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED
	FROM 
          BANK_LOAN
    GROUP BY emp_length
    ORDER BY emp_length;
    
    
    
	# PURPOSE --
	SELECT
		   PURPOSE,
           COUNT(ID) AS TOTAL_LOAN_APPLICATION,
           SUM(LOAN_AMOUNT) AS TOTAL_LAON_AMOUNT,
           SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED
	FROM 
          BANK_LOAN
	GROUP BY PURPOSE
    ORDER BY PURPOSE;
    
    
    
    # HOME OWNERSHIP
    
    SELECT 
          HOME_OWNERSHIP AS HOME_OWNERSHIP,
          COUNT(ID) AS TOTAL_LOAN_APPLICATION,
           SUM(LOAN_AMOUNT) AS TOTAL_LAON_AMOUNT,
           SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_RECIEVED
	FROM 
          BANK_LOAN
	GROUP BY HOME_OWNERSHIP
    ORDER BY HOME_OWNERSHIP;
    
    # GRADE 
    
    
    SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;

          
        
    
    
    
    
    

         






