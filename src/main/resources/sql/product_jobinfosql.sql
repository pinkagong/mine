
CREATE SEQUENCE product_SEQ
    START WITH 1
    INCREMENT BY 1;


CREATE TABLE product (
                         product_num NUMBER PRIMARY KEY,
                         product_title VARCHAR2(1000),
                         product_subtitle VARCHAR2(1000),
                         product_writer VARCHAR2(1000),
                         product_price VARCHAR2(1000),
                         product_img VARCHAR2(4000),
                         product_date DATE,
                         product_page VARCHAR2(1000),
                         product_code CLOB,
                         product_stock NUMBER default 10,
                         product_sale NUMBER default 1,
                         product_visit NUMBER default 1
);

CREATE SEQUENCE job_info_SEQ
    START WITH 1
    INCREMENT BY 1;


CREATE TABLE job_info(
                         job_info_num NUMBER PRIMARY KEY,
                         job_info_Field VARCHAR2(1000),
                         job_info_company_name VARCHAR2(1000),
                         job_info_posting_name VARCHAR2(1000),
                         job_info_field_tag_list VARCHAR2(1000),
                         job_info_Qualification VARCHAR2(1000),
                         job_info_work_type VARCHAR2(1000),
                         job_info_work_area VARCHAR2(1000),
                         job_info_Deadline VARCHAR2(1000),
                         job_info_page_code CLOB,
                         job_info_link VARCHAR2(4000)
);

CREATE TABLE companyScrap (
                              MEMBER_NO NUMBER(10),
                              companyName VARCHAR2(1000),
                              scrap_time DATE,
                              CONSTRAINT fk_MEMBER_NO_CS FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER2(MEMBER_NO)
);

CREATE TABLE InfScrap (
                          MEMBER_NO NUMBER(10),
                          infoname VARCHAR2(4000),
                          scrap_time DATE,
                          CONSTRAINT fk_MEMBER_NO_IS FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER2(MEMBER_NO)
);
