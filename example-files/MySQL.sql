CREATE TABLE employee (
    fname varchar(20),
    minit char,
    lname varchar(20),
    ssn varchar(9) NOT NULL,
    bdate DATE,
    address varchar(50),
    sex char(1),
    salary double(7,2),
    superssn varchar(9),
    dno varchar(2),
    CONSTRAINT employee_ssn_pk PRIMARY KEY (ssn),
    CONSTRAINT employee_superssn_fk FOREIGN KEY (superssn) REFERENCES employee(ssn)
); 
