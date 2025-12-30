create database if not EXISTS session04_cau1;
USE session04_cau1;


CREATE TABLE Reader (
    reader_id int AUTO_INCREMENT primary key,
    reader_name varchar(100) not null,
    phone varchar(15) unique,
    register_date date default (CURRENT_DATE)
);


CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    book_title varchar(150) not null,
    author varchar(100),
    publish_year int check (publish_year >= 1900)
);


CREATE TABLE Borrow (
    reader_id INT,
    book_id INT,
    borrow_date date default (CURRENT_DATE),
    return_date date,

    primary key (reader_id, book_id, borrow_date),

    foreign key (reader_id) references Reader(reader_id),
    foreign key  (book_id) references Book(book_id)
);
SELECT * FROM Reader;
SELECT * FROM Book;
SELECT * FROM Borrow;
ALTER TABLE Reader
ADD COLUMN email VARCHAR(100) UNIQUE;

ALTER TABLE Book
MODIFY COLUMN author VARCHAR(150);

ALTER TABLE Borrow
ADD CONSTRAINT chk_return_date
CHECK (return_date >= borrow_date);
SELECT * FROM Reader;
SELECT * FROM Book;
SELECT * FROM Borrow;

insert into Reader(reader_id, reader_name, phone, email, register_date)
values
(1, 'Nguyễn Văn An', '0901234567', 'an.nguyen@gmail.com', '2024-09-01'),
(2, 'Trần Thị Bình', '0912345678', 'binh.tran@gmail.com', '2024-09-05'),
(3, 'Lê Minh Châu', '0923456789', 'chau.le@gmail.com', '2024-09-10');
insert into Book (book_id, book_title, author, publish_year)
values
(101, 'Lập trình C căn bản', 'Nguyễn Văn A', 2018),
(102, 'Cơ sở dữ liệu', 'Trần Thị B', 2020),
(103, 'Lập trình Java', 'Lê Minh C', 2019),
(104, 'Hệ quản trị MySQL', 'Phạm Văn D', 2021);
insert into Borrow (reader_id, book_id, borrow_date, return_date)
values
(1, 101, '2024-09-15', NULL),
(1, 102, '2024-09-15', '2024-09-25'),
(2, 103, '2024-09-18', NULL);

update Borrow
set  return_date = '2024-10-01' 
where 	reader_id = 1;

update Book
set publish_year = 2023
where publish_year >= 2021;

delete from Borrow
where borrow_date < '2024-09-18';

SELECT * FROM Reader;
SELECT * FROM Book;
SELECT * FROM Borrow;