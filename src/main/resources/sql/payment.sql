drop table payment;

create table payment (
                         payment_num varchar2(50),
                         member_no number(10),
                         product_num number,
                         payment_stock number,
                         payment_date date,
                         payment_phone varchar2(13),
                         payment_email varchar2(50),
                         payment_address varchar2(150),
                         delivery_info varchar2(200),
                         delivery_num number,
                         visible number(1),
                         success number(1),
                         CONSTRAINT fk_mn foreign key(member_no) REFERENCES member2(member_no),
                         CONSTRAINT fk_pn foreign key(product_num) REFERENCES product(product_num)
);