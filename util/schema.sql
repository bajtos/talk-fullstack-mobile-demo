DROP DATABASE IF EXISTS slex;

CREATE DATABASE slex;

USE slex;

CREATE TABLE Employee (
  Id INT NOT NULL PRIMARY KEY,
  Email NVARCHAR(60) NOT NULL UNIQUE,
  LastName NVARCHAR(20) NOT NULL,
  FirstName NVARCHAR(20) NOT NULL,
  Title NVARCHAR(30) NOT NULL,
  ReportsTo INT,
  BirthDate DATETIME,
  HireDate DATETIME,
  AddressLine NVARCHAR(70),
  City NVARCHAR(40),
  State NVARCHAR(40),
  Country NVARCHAR(40),
  PostalCode NVARCHAR(10),
  Phone NVARCHAR(24),

  CONSTRAINT FK_EmployeeReportsTo
    FOREIGN KEY (ReportsTo) REFERENCES Employee (Id) ON DELETE NO
    ACTION ON UPDATE NO ACTION,

  INDEX IFK_EmployeeReportsTo (ReportsTo)
);

CREATE TABLE ExpenseRecord (
  Id INT NOT NULL PRIMARY KEY,
  Amount NUMERIC(15,4) NOT NULL,
  Description NVARCHAR(140) NOT NULL,
  ReceiptUrl NVARCHAR(140),
  CreatedBy INT NOT NULL,
  ReviewedBy INT,
  CreatedDate DATETIME NOT NULL,
  ReviewedDate DATETIME,
  ReimbursedDate DATETIME,
  Status ENUM('created', 'approved', 'rejected', 'reimbursed'),

  CONSTRAINT FK_ExpenseRecordCreatedBy FOREIGN KEY (CreatedBy)
    REFERENCES Employee (Id) ON DELETE NO ACTION ON UPDATE NO ACTION,

  CONSTRAINT FK_ExpenseRecordReviewedBy FOREIGN KEY (ReviewedBy)
    REFERENCES Employee (Id) ON DELETE NO ACTION ON UPDATE NO ACTIOm
);
