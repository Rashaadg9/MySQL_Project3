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