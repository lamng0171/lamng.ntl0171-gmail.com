-- =============================================
-- Create Structure database
-- =============================================

-- Drop the database if it already exists
DROP DATABASE IF EXISTS Java_FinalExam;
-- Create database
CREATE DATABASE IF NOT EXISTS Java_FinalExam;
USE Java_FinalExam;

-- Create table user
DROP TABLE IF EXISTS 	`User`;
CREATE TABLE IF NOT EXISTS `User` ( 	
    email 			VARCHAR(50) NOT NULL UNIQUE CHECK (LENGTH(email) >= 6 AND LENGTH(email) <= 50),
    `password` 		VARCHAR(800) NOT NULL CHECK (LENGTH(`password`) >= 6 AND LENGTH(`password`) <= 12),
	firstName 		VARCHAR(50) NOT NULL,
	lastName 		VARCHAR(50) NOT NULL,
	phone 			CHAR(15) NOT NULL UNIQUE CHECK (LENGTH(phone) >= 9 AND LENGTH(phone) <= 12)
);

-- Create table manager
DROP TABLE IF EXISTS 	Manager;
CREATE TABLE IF NOT EXISTS Manager ( 	
    email 			VARCHAR(50) NOT NULL PRIMARY KEY CHECK (LENGTH(email) >= 6 AND LENGTH(email) <= 50),
    expInYear 		TINYINT UNSIGNED NOT NULL CHECK (expInYear >= 0 AND expInYear <= 20),
    FOREIGN KEY (email) 		REFERENCES `User`(email)
);

-- Create table employee
DROP TABLE IF EXISTS 	Employee;
CREATE TABLE IF NOT EXISTS Employee ( 	
    email 			VARCHAR(50) NOT NULL PRIMARY KEY CHECK (LENGTH(email) >= 6 AND LENGTH(email) <= 50),
	projectName 	ENUM ('Testing System', 'CRM', 'TimeSheet') NOT NULL,
    proSkill 		VARCHAR(10) NOT NULL,
    FOREIGN KEY (email) 		REFERENCES `User`(email)
);


