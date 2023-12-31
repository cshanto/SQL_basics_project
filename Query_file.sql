-- This is short Library Management System Database
-- Its goal is to implement fundamental MySQL queries
-- Following are the phases of the entire Database System
-- 1. Database Schema [Here: Library]
-- Database Schema is the blueprint of the Database containing the relationships of the tables in it.
-- All tables in the schema {ERD is given}
-- : Books table, Authors table, Users table, and Transactions table
-- 2.Create the mentioned tables with Primary Keys(PM) ans Foreign Keys(FK) for relationships
-- 3. Populate the created tables with appropriate data
-- 4. Perform basic Operations(SQl Queries) :
-- * Adding new books and authors to the system
-- * Registerig new users
-- * Borrowing and returning books
-- * Retrieeving a list of books that are available
-- * Displaying users borrowing history

-- 5.Perform complex operations : 
-- * Find the most borrowed book
-- * Identify user with most borrowed book
-- * Calculate late returns and fines
-- 6. Reporting :
-- * Create SQL queries for generating reports on overdue books, ppopular genre, and activity summary
-- 7. Indexing and Optimization :
-- Experiment with indexing on appropriate columns to optimize query performance, especially for large datasets. 

-- note : Kindly ignore if any mistakes are found. And I will try to add more stuffs into it 

-- The following statements are covered :
-- DDL commands such as 'CREATE', 'DROP', 'ALTER'
-- DML commands such as 'INSERT', 'UPDATE', 'DELETE'
-- DQL command 'SELECT'
-- INDEX creation for query optimizations

-- CREATE DATABASE
create database library;
-- show available databases
show databases;
-- use library database as primary database
use library;
-- Creating Books table
create table Books(
BOOK_ID integer primary key, 
TITLE varchar(100) not null,
ISBN varchar(13) not null,
PUBLICATION_DATE date,
GENRE varchar(15), 
AVAILABLE boolean default true
);
Alter table books
modify column ISBN varchar(15);
Alter table books
modify column GENRE varchar(30);

-- Creating Authors table --
create table Authors(
AUTHOR_ID integer primary key, 
FIRSTNAME varchar(20) not null,
LASTNAME varchar(20) not null,
NATIONALITY varchar(20) not null,
`D.O.B` date
);
-- note : " ` "(Acute) is used to escape the column name containing special characters

-- Creating Users table --
create table Users(
USER_ID integer primary key, 
USERNAME varchar(20) not null,
PASSWORD varchar(255),
FIRSTNAME varchar(20) not null,
LASTNAME varchar(20) not null,
EMAIL varchar(30) not null
);

-- Creating Tansactions table --
create table Transactions(
TRANSACTION_ID varchar(20) primary key, 
USER_ID integer,
BOOK_ID integer,
BORROW_DATE date not null,
RETURN_DATE date not null,
LATE_FEE decimal(10,2),
foreign key(user_id) references Users(user_id),
foreign key(book_id) references Books(book_id)
);

-- POPULATING THE TABLES --
insert into Books(BOOK_ID,TITLE, ISBN, PUBLICATION_DATE, GENRE, AVAILABLE) 
Values(1,'The Martian','978-0316031617','2011-10-26','Sci-Fi',TRUE),
	  (2,'Jane Eyre','978-0140620611','1847-10-19','Romance',TRUE),
      (3,'The Lord of the Rings','978-0345339774','1970-07-22','Fantasy',TRUE),
      (4,'Pride and Prejudice','978-0140435083','1813-01-28','Romance',TRUE),
	  (5,'To Kill a Mockingbird','978-0143038334','1960-07-11','Historical Fiction',TRUE),
	  (6,"The Hitchhiker's Guide to the Galaxy",'978-0345391823','1979-09-25','Sci-Fi Humor',TRUE),
      (7,'The Great Gatsby','978-0312085325','1925-04-10','American Literature',TRUE),
      (8,'One Hundred Years of Solitude','978-0547344839','1967-06-01','Magical Realism',TRUE),
	  (9,"The Handmaid's Tale", '978-0517138855','1985-07-18','Dystopian Fiction',TRUE),
	  (10,"Invisible Man",'978-0140177425','1952-04-22','African American Literature',TRUE),
	  (11,'Frankenstein','978-0140623114','1818-01-01','Gothic Fiction',TRUE ),
      (12,'The Book Thief','978-0312069907','2005-09-13','Historical Fiction', TRUE ),
      (13,'The God of Small Things','978-0393319282','1997-06-08','Indian Literature',TRUE),
      (14,'The Remains of the Day','978-0140233678','1989-04-27','British Literature',TRUE),
      (15,'Cloud Atlas','978-0307451857','2006-09-12','Historical Fiction',TRUE);

insert into Authors(AUTHOR_ID, FIRSTNAME, LASTNAME, NATIONALITY,`D.O.B`)
Values(1,'Peter','Jackson','German','1984-09-27'),
      (2,'Frank','Evans','German','1910-04-20'),
      (3,'Peter','Nguyen','Nigerian','2011-10-11'),
      (4,'Lily','Williams','Vietnamese','1911-12-05'),
      (5,'Charlie','Taylor','Korean','1990-09-10'),
      (6,'Quinn','Parker','Nigerian','1980-03-11'),
	  (7,'Olivia','Smith','American','1909-12-25'),
	  (8,'Kim','Taylor','Russian','1925-02-06'),
      (9,'Eve','Miller','Italian','1915-09-26'),
      (10,'Jack','Davis','Turkish','1957-12-02'),
      (11,'Bob','Brown','Italian','2017-02-13'),
	  (12,'Diana','Garcia','American','1900-09-05'),
      (13,'Nina','Parker','Canadian','2019-08-28'),
      (14,'Max','Nguyen','Turkish','1939-08-17'),
      (15,'Peter','Evans','Nigerian','1913-07-14');

-- Rename Users table column PASSWORD to PASSWORD(hashed)
Alter table Users rename column PASSWORD to `PASSWORD(hashed)`;

insert into Users (USER_ID, USERNAME, `PASSWORD(hashed)`, FIRSTNAME, LASTNAME, EMAIL)
Values(1, 'user1', 'hashed_password_1', 'John', 'Doe', 'john.doe1@example.com'),
	  (2, 'user2', 'hashed_password_2', 'Jane', 'Smith', 'jane.smith2@example.com'),
      (3, 'user3', 'hashed_password_3', 'Bob', 'Johnson', 'bob.johnson3@example.com'),
      (4, 'user4', 'hashed_password_4', 'Alice', 'Williams', 'alice.williams4@example.com'),
      (5, 'user5', 'hashed_password_5', 'Charlie', 'Jones', 'charlie.jones5@example.com'),
      (6, 'user6', 'hashed_password_6', 'Eva', 'Davis', 'eva.davis6@example.com'),
      (7, 'user7', 'hashed_password_7', 'Frank', 'Miller', 'frank.miller7@example.com'),
      (8, 'user8', 'hashed_password_8', 'Grace', 'Taylor', 'grace.taylor8@example.com'),
      (9, 'user9', 'hashed_password_9', 'Henry', 'Brown', 'henry.brown9@example.com'),
      (10, 'user10', 'hashed_password_10', 'Ivy', 'Clark', 'ivy.clark10@example.com'),
	  (11, 'user11', 'hashed_password_11', 'Jack', 'Anderson', 'jack.anderson11@example.com'),
	  (12, 'user12', 'hashed_password_12', 'Karen', 'Moore', 'karen.moore12@example.com'),
	  (13, 'user13', 'hashed_password_13', 'Leo', 'Wilson', 'leo.wilson13@example.com'),
      (14, 'user14', 'hashed_password_14', 'Mia', 'Johnson', 'mia.johnson14@example.com'),
      (15, 'user15', 'hashed_password_15', 'Nathan', 'Smith', 'nathan.smith15@example.com');
      
-- Rename Users table column PASSWORD to LATE_FEE(₹)
alter table transactions rename column LATE_FEE to `LATE_FEE(₹)`;

insert into Transactions (TRANSACTION_ID, USER_ID, BOOK_ID, BORROW_DATE, RETURN_DATE, `LATE_FEE(₹)`)
Values('txn1', 1, 1, '2023-01-01', '2023-01-10', 5.00),
      ('txn2', 2, 2, '2023-02-05', '2023-02-15', 8.50),
      ('txn3', 3, 3, '2023-03-10', '2023-03-20', 12.00),
      ('txn4', 4, 4, '2023-04-15', '2023-04-25', 6.75),
      ('txn5', 5, 5, '2023-05-20', '2023-05-30', 10.25),
      ('txn6', 6, 6, '2023-06-25', '2023-07-05', 15.50),
      ('txn7', 7, 7, '2023-07-30', '2023-08-09', 7.00),
      ('txn8', 8, 8, '2023-08-15', '2023-08-25', 9.75),
      ('txn9', 9, 9, '2023-09-20', '2023-09-30', 11.25),
      ('txn10', 10, 10, '2023-10-25', '2023-11-04', 14.00),
      ('txn11', 11, 11, '2023-11-10', '2023-11-20', 6.50),
      ('txn12', 12, 12, '2023-12-15', '2023-12-25', 8.25),
      ('txn13', 13, 13, '2024-01-01', '2024-01-10', 10.75),
      ('txn14', 14, 14, '2024-02-05', '2024-02-15', 13.50),
      ('txn15', 15, 15, '2024-03-10', '2024-03-20', 11.00);

-- dislay all the data in the tables --
show databases;
use library;
select * from Books;
select * from Authors;
select * from Users;
select * from Transactions;

-- Add new books to the books table
insert into Books(BOOK_ID,TITLE, ISBN, PUBLICATION_DATE, GENRE, AVAILABLE) 
			values(16,'Atonement',978-0312427459,'2007-09-18','Historical Fiction',FALSE),
				  (17,'Life of Pi',978-0316172322,'2003-09-09','Philosophical Fiction',FALSE),
				  (18,'The Girl with the Dragon Tattoo',978-0307451668,'2005-08-30','Crime Thriller',FALSE),
				  (19,'The Wind Up Bird Chronicle',978-0375420036,'1997-05-20','Magical Realism',FALSE),
                  (20,'Half of a Yellow Sun',978-0060534292,'2006-04-04','Historical Fiction',FALSE);
            
-- Add some new authors
insert into Authors(AUTHOR_ID, FIRSTNAME, LASTNAME, NATIONALITY,`D.O.B`)
values(16, 'Ethan', 'Taylor', 'Russian', '1903-12-30'),
      (17, 'Sophia', 'Smith', 'Canadian', '1985-09-01'),
      (18, 'Daniel', 'Garcia', 'American', '1933-04-15'),
      (19, 'Alex', 'Nguyen', 'Vietnamese', '1914-07-23'),
      (20, 'Benjamin', 'Parker', 'Indian', '1958-03-08');
      
      
-- Add some new users
insert into Users (USER_ID, USERNAME, `PASSWORD(hashed)`, FIRSTNAME, LASTNAME, EMAIL)
	values(16,'sophie_2015','$2a$10$38384.39839.38383.73837','Sophie','Williams','sophie_2015@email.com'),
          (17,'alex.martin2000','$2a$10$83748.3748.37483.3748','Alex','Martin','alex.martin2000@email.com'),
          (18,'maya_2020','$2a$10$38374.38374.38374.38374','Maya','Lopez','maya_2020@email.com'),
          (19,'ethan_c2005','$2a$10$38938.38938.38938.38938.','Ethan','Carter','ethan_c2005@email.com'),
          (20,'ava_dancer','$2a$10$38474.38743.38473.38473.','Ava','Garcia','ava_dancer@email.com');
    

-- Add some new transactions --
insert into Transactions (TRANSACTION_ID, USER_ID, BOOK_ID, BORROW_DATE, RETURN_DATE, `LATE_FEE(₹)`)
            values('txn16', 10, 10, '2023-10-25', '2023-11-04', 14.00),
				  ('txn17', 11, 11, '2023-11-10', '2023-11-20', 6.50),
				  ('txn18', 12, 12, '2023-12-15', '2023-12-25', 8.25),
				  ('txn19', 13, 13, '2024-01-01', '2024-01-10', 10.75),
				  ('txn20', 14, 14, '2024-02-05', '2024-02-15', 13.50);

-- Borrowing and Returning Books
-- Add new transaction as 'borrowing a book'
insert into Transactions (TRANSACTION_ID, USER_ID, BOOK_ID, BORROW_DATE, RETURN_DATE, `LATE_FEE(₹)`)
            values('txn21', 15, 15, '2023-12-15', '2023-12-17', 20.00);

-- Update the previous transaction as 'returing the book'
update transactions 
set `LATE_FEE(₹)` = 00.00
where transaction_id = 'txn21';

-- Retrieving a List of Available Books 
select * from books
where available = TRUE;

-- Display user borrowing history
select B.TITLE, B.GENRE, T.BORROW_DATE, T.RETURN_DATE, T.`LATE_FEE(₹)`
from Books B
JOIN Transactions T on B.Book_id = T.Book_id
where T.user_id in (1,2,3);

-- Find the most popular book
SELECT B.title AS most_borrowed_book, COUNT(T.book_id) AS borrow_count
FROM Transactions T
JOIN Books B ON T.book_id = B.book_id
GROUP BY T.book_id, B.title
ORDER BY borrow_count DESC
LIMIT 1;

-- identify users with most borrowed books
select U.firstname, count(T.User_id) 
from Users U
Join Transactions T
on U.user_id = T.user_id
Group by T.user_id, U.firstname
order by count(T.user_id) desc;

-- Add 'due date' column in Transactions table
Alter table Transactions add column DUE_DATE date;

-- Populate the DUE_DATE column

update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn1';
update transactions
set DUE_DATE = '2023-11-02'
where TRANSACTION_ID = 'txn10';
update transactions
set DUE_DATE = '2023-11-02'
where TRANSACTION_ID = 'txn11';
update transactions
set DUE_DATE = '2023-01-12'
where TRANSACTION_ID = 'txn12';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn13';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn14';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn15';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn16';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn17';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn18';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn19';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn2';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn20';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn21';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn3';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn4';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn5';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn6';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn7';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn8';
update transactions
set DUE_DATE = '2023-01-10'
where TRANSACTION_ID = 'txn9';

-- Calculating late returns and fines.
SELECT
    T.transaction_id,
    U.username,
    B.title AS book_title,
    T.borrow_date,
    T.return_date,
    T.`LATE_FEE(₹)`,
    CASE
        WHEN T.return_date > T.due_date THEN 'Yes' -- Book returned late
        ELSE 'No' -- Book returned on time or early
    END AS late_return
FROM Transactions T
JOIN Users U ON T.user_id = U.user_id
JOIN Books B ON T.book_id = B.book_id
WHERE T.return_date IS NOT NULL
ORDER BY T.return_date DESC;
       
-- Calculate Total late fees
select sum(`LATE_FEE(₹)`) as 'Total late fees'
from transactions;

-- Calculate least late fees
select min(`LATE_FEE(₹)`) as 'Least late fees'
from transactions;
-- Calculate maximum late fees
select max(`LATE_FEE(₹)`) as 'Maximum late fees'
from transactions;

-- Alter the transactions table so that return_date column has not null values
Alter table transactions modify RETURN_DATE date null; 

-- update the transaction table with data which has passed the due date and not yet returned
insert into transactions(TRANSACTION_ID, USER_ID, BOOK_ID, BORROW_DATE, RETURN_DATE, `LATE_FEE(₹)`, DUE_DATE)
				  values('txn26', '15', '15', '2023-12-15',null , '5.00', '2023-12-15');

-- QUERIES FOR GENERATING REPORTS
-- 1. Overdue Book Report
select B.TITLE, B.GENRE,
       CONCAT(U.FIRSTNAME,' ',U.LASTNAME) as USER,
       T.BORROW_DATE, T.RETURN_DATE, T.DUE_DATE
       from transactions T
       join Books B on T.book_id = B.book_id
       join Users U on T.user_id = U.user_id
       where T.return_date is Null and T.due_date < current_date();
       
-- select current_date() from dual;

-- 2. popular genre report
select GENRE, count(*) as Count
from Books
group by GENRE
order by Count desc;

-- 3. User Activity Summary
Select 
	U.username,
	Count(DISTINCT T.BOOK_ID) as BOOKS_BORROWED,
	Count(DISTINCT CASE WHEN T.RETURN_DATE is not null then T.BOOK_ID END) as BOOKS_RETURNED,
	Count(DISTINCT CASE WHEN T.RETURN_DATE is null then T.BOOK_ID END) as BOOKS_NOT_RETURNED
from 
	Users U
LEFT JOIN 
	transactions T on U.USER_ID = T.USER_ID
GROUP BY 
	U.username;
    
-- INDEXING AND QUERY OPTIMIZATION
-- Create an INDEX on the 'TITLE' column of the Books table
CREATE INDEX idx_title on Books(TITLE);
show indexes from Books;
-- create an Composite index on the FIRSTNAME and LASTNAME columns of the Authors table
CREATE INDEX FULL_NAME on Authors(FIRSTNAME,LASTNAME);

-- Create an unique index on the TRANSACTION_ID column of the transactions table
CREATE UNIQUE INDEX unq_Borrow_date on Transactions(TRANSACTION_ID);

-- Query to delete an INDEX
DROP INDEX unq_Borrow_date on Transactions;
