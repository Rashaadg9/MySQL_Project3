DROP DATABASE IF EXISTS MySQL_Project3;
CREATE DATABASE MySQL_Project3;
USE MySQL_Project3;

CREATE TABLE EmployeeDetails
(
	EmpId INT NOT NULL,
    FullName VARCHAR(255),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(255),
    PRIMARY KEY (EmpID)
);

CREATE TABLE EmployeeSalary
(
	EmpId INT NOT NULL,
    Project VARCHAR(2),
    Salary INT DEFAULT 0,
    Variable INT DEFAULT 0,
    PRIMARY KEY (EmpID),
    FOREIGN KEY (EmpID) REFERENCES EmployeeDetails(EmpID)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO EmployeeDetails VALUES(121, "John Snow", 321, "2014-01-31", "Toronto");
INSERT INTO EmployeeDetails VALUES(321, "Walter White", 986, "2015-01-30", "California");
INSERT INTO EmployeeDetails VALUES(421, "Kuldeep Rana", 876, "2016-11-27", "New Delhi");

INSERT INTO EmployeeSalary VALUES(121, "P1", 8000, 500);
INSERT INTO EmployeeSalary VALUES(321, "P2", 10000, 1000);
INSERT INTO EmployeeSalary VALUES(421, "P1", 12000, 0);

/* 1. Write an SQL query to fetch all the employees who either live in California or work under
a manager with ManagerId – 321. */

SELECT * FROM EmployeeDetails WHERE City = "California" OR ManagerId = 321;

/* 2. Write an SQL query to fetch the employees whose name begins with any two characters,
followed by a text “hn” and ending with any sequence of characters. */

SELECT * FROM EmployeeDetails WHERE FullName LIKE "__hn%";

/* 3. Write an SQL query to fetch the EmpIds that are present in both the tables –
‘EmployeeDetails’ and ‘EmployeeSalary. */

SELECT EmployeeDetails.EmpId FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId=EmployeeSalary.EmpId;

/* 4. Write an SQL query to find the count of the total occurrences of a particular character –
‘n’ in the FullName field. */

SET @Char = 'A';
SELECT EmpId, FullName, (LENGTH(FullName) - LENGTH(REGEXP_REPLACE(FullName, @Char, '') ) ) AS Char_Count FROM EmployeeDetails;
/* ALTERNATE ANS --> SELECT EmpId, FullName, (LENGTH(FullName) - LENGTH(REPLACE(LOWER(FullName) , LOWER(@Char), '') ) ) AS Char_Count FROM EmployeeDetails; */

/* 5. Write an SQL query to fetch employee names having a salary greater than or equal to
5000 and less than or equal to 10000. */

SELECT EmployeeDetails.FullName FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId=EmployeeSalary.EmpId
WHERE EmployeeSalary.Salary BETWEEN 5000 AND 10000;

/* 6. Write an SQL query to fetch all employee records from EmployeeDetails table who have a
salary record in EmployeeSalary table. */

SELECT EmployeeDetails.* FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId=EmployeeSalary.EmpId;

/* 7. Write a query to fetch employee names and salary records. Display the employee details
even if the salary record is not present for the employee.  */

SELECT EmployeeDetails.FullName, EmployeeSalary.* FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId=EmployeeSalary.EmpId;

-- INSERT INTO EmployeeDetails VALUES(521, "TEST NAME", 876, CURDATE(), "New City");

/* 8. Write an SQL query to fetch all the Employees who are also managers from the
EmployeeDetails table. */

SELECT * FROM EmployeeDetails WHERE EmpId IN (SELECT ManagerId FROM EmployeeDetails);

/* 9. Write an SQL query to remove duplicates from a table without using a temporary table */

DELETE r1 FROM EmployeeDuppTest r1, EmployeeDuppTest r2 WHERE (r1.FirstName = r2.FirstName) AND 
(r1.LastName = r2.LastName) AND (r1.TestKey > r2.TestKey);

-- SET SQL_SAFE_UPDATES = 0;
/*DROP TABLE IF EXISTS EmployeeDuppTest;
CREATE TABLE EmployeeDuppTest
(
	TestKey INT PRIMARY KEY,
    FirstName VARCHAR(25),
    LastName VARCHAR(25)
);

INSERT INTO EmployeeDuppTest VALUES(1, "first1", "last1");
INSERT INTO EmployeeDuppTest VALUES(2, "first1", "last1");
INSERT INTO EmployeeDuppTest VALUES(3, "first2", "last2");
INSERT INTO EmployeeDuppTest VALUES(4, "first2", "last2");

SELECT * FROM EmployeeDuppTest;*/


/* 10.Write an SQL query to find the nth highest salary from table. */

SET @num = 1;
SET @sql = CONCAT("SELECT Salary FROM EmployeeSalary ORDER BY Salary DESC LIMIT ", (@num - 1), ", 1");
PREPARE STMT FROM  @sql;
EXECUTE STMT;

/* 11.Write SQL query to find the 3rd highest salary from a table without using the TOP/limit keyword. */

SELECT Salary FROM EmployeeSalary s1 WHERE(3) = (SELECT COUNT(*) FROM EmployeeSalary s2 WHERE s1.Salary <= s2.Salary);