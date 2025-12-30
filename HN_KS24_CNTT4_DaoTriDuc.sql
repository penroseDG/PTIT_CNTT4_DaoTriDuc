drop database if exists session04_cau1;
create database if not exists session04_cau1;
use session04_cau1;

create table reader (
  reader_id int auto_increment primary key,
  reader_name varchar(100) not null,
  phone varchar(15) unique,
  register_date date default (current_date)
);

create table book (
  book_id int primary key,
  book_title varchar(150) not null,
  author varchar(100),
  publish_year int,
  check (publish_year >= 1900)
);

create table borrow (
  reader_id int,
  book_id int,
  borrow_date date default (current_date),
  return_date date,

  primary key (reader_id, book_id, borrow_date),

  constraint fk_borrow_reader foreign key (reader_id) references reader(reader_id),
  constraint fk_borrow_book foreign key (book_id) references book(book_id)
);

alter table reader
add column email varchar(100) unique;
alter table book
modify column author varchar(150);

alter table borrow
add constraint chk_return_date
check (return_date is null or return_date >= borrow_date);

insert into reader (reader_id, reader_name, phone, email, register_date) values
(1, 'Nguyễn Văn An', '0901234567', 'an.nguyen@gmail.com', '2024-09-01'),
(2, 'Trần Thị Bình', '0912345678', 'binh.tran@gmail.com', '2024-09-05'),
(3, 'Lê Minh Châu', '0923456789', 'chau.le@gmail.com', '2024-09-10');

insert into book (book_id, book_title, author, publish_year) values
(101, 'Lập trình C căn bản', 'Nguyễn Văn A', 2018),
(102, 'Cơ sở dữ liệu', 'Trần Thị B', 2020),
(103, 'Lập trình Java', 'Lê Minh C', 2019),
(104, 'Hệ quản trị MySQL', 'Phạm Văn D', 2021);

insert into borrow (reader_id, book_id, borrow_date, return_date) values
(1, 101, '2024-09-15', null),
(1, 102, '2024-09-15', '2024-09-25'),
(2, 103, '2024-09-18', null);

set sql_safe_updates = 0;

update borrow
set return_date = '2024-10-01'
where reader_id = 1;

update book
set publish_year = 2023
where publish_year >= 2021;

set sql_safe_updates = 1;

set sql_safe_updates = 0;

delete from borrow
where borrow_date < '2024-09-18';

set sql_safe_updates = 1;

select * from reader;
select * from book;
select * from borrow;

select
  br.reader_id,
  r.reader_name,
  br.book_id,
  b.book_title,
  br.borrow_date,
  br.return_date
from borrow br
join reader r on r.reader_id = br.reader_id
join book b on b.book_id = br.book_id;
