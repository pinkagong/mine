/**
  CART_ITEM
  여기서는 MEMBER_NO를 MEMBER_NUM 으로 변경하였습니다.
  MEMBER_NO를 외부키로 참조하였습니다.
  PRODUCT_NUM 을 외부키로 참조하였습니다.
 */
CREATE SEQUENCE cart_item_num_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
  NOCYCLE;

CREATE TABLE cart_item (
                           cart_item_num NUMBER(10) PRIMARY KEY,
                           member_num NUMBER(10),
                           product_num NUMBER(10),
                           cart_item_stock NUMBER(10)

);

ALTER TABLE CART_ITEM
    ADD CONSTRAINT CART_ITEM_MEMBER_NUM_FK FOREIGN KEY(MEMBER_NUM) REFERENCES MEMBER2(MEMBER_NO);

ALTER TABLE CART_ITEM
    ADD CONSTRAINT CART_ITEM_PRODUCT_NUM_FK FOREIGN KEY(PRODUCT_NUM) REFERENCES PRODUCT(PRODUCT_NUM);


/**
  CART
  여기서는 MEMBER_NO를 MEMBER_NUM 으로 변경하였습니다.
  MEMBER_NO를 외부키로 참조하였습니다.
 */

CREATE SEQUENCE CART_NUM_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
  NOCYCLE;

CREATE TABLE CART (
                      CART_NUM NUMBER(20,0) NOT NULL,
                      MEMBER_NUM NUMBER(20,0) NOT NULL,
                      CART_DATE TIMESTAMP(6) DEFAULT SYSTIMESTAMP,
                      CONSTRAINT CART_PK PRIMARY KEY (CART_NUM)
);


ALTER TABLE CART
    ADD CONSTRAINT CART_MEMBER_NUM_FK FOREIGN KEY(MEMBER_NUM) REFERENCES MEMBER2(MEMBER_NO);


/**
  장바구니 조회 쿼리
 */
SELECT
    cart.CART_NUM,
    cart.MEMBER_NUM,
    cart.CART_DATE,
    cart_item.CART_ITEM_NUM,
    cart_item.PRODUCT_NUM,
    cart_item.CART_ITEM_STOCK,
    product.PRODUCT_TITLE,
    product.PRODUCT_PRICE
FROM
    cart
        JOIN cart_item ON cart.MEMBER_NUM = cart_item.MEMBER_NUM
        JOIN product ON cart_item.PRODUCT_NUM = product.PRODUCT_NUM;


/**
  회원별 장바구니 조회
 */

SELECT
    cart.MEMBER_NUM,
    cart.CART_DATE,
    cart_item.CART_ITEM_NUM,
    cart_item.PRODUCT_NUM,
    cart_item.CART_ITEM_STOCK,
    product.PRODUCT_TITLE,product.PRODUCT_PRICE
FROM
    cart
        JOIN cart_item ON cart.MEMBER_NUM = cart_item.MEMBER_NUM
        JOIN product ON cart_item.PRODUCT_NUM = product.PRODUCT_NUM
WHERE
        cart.MEMBER_NUM = 41;