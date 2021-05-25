-----------���� ���̺�---------------

DROP TABLE USERS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_USER;

CREATE TABLE USERS(
    USERSEQ NUMBER(8) PRIMARY KEY,
	EMAIL VARCHAR2(50) NOT NULL,
	PWD VARCHAR2(20) NOT NULL,
	NICKNAME VARCHAR2(20),
	PROFILENAME VARCHAR2(100),
	PHONE VARCHAR2(50),
    AUTH NUMBER(1) NOT NULL,
    MILEAGE NUMBER(10),
    DEFAULTADDRESS NUMBER(2)
);

CREATE SEQUENCE SEQ_USER
START WITH 1
INCREMENT BY 1;

COMMIT;


--------�˻��� ���̺�--------------------


DROP TABLE SEARCH_HISTORY
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_SEARCH;

CREATE TABLE SEARCH_HISTORY(
    SEARCHSEQ NUMBER(8) PRIMARY KEY,
	SEARCHWORD VARCHAR2(100) NOT NULL,
	SEARCHDATE DATE NOT NULL
);

CREATE SEQUENCE SEQ_SEARCH
START WITH 1
INCREMENT BY 1;

COMMIT;


------���� ����� ���̺�----------------

DROP TABLE ADDRESS
CASCADE CONSTRAINTS;


CREATE TABLE ADDRESS(
    ADDRESSSEQ NUMBER(8) PRIMARY KEY,
	USERSEQ NUMBER(8) NOT NULL,
	ADDRESSNAME VARCHAR2(50),
	ADDRESS VARCHAR2(500),
	RECEIVEUSER VARCHAR2(50),
    RECEIVEPHONE VARCHAR2(50)
);


------��ٱ��� ���̺�-----------------

DROP TABLE CART
CASCADE CONSTRAINTS;

--DROP SEQUENCE SEQ_CART;

CREATE TABLE CART(
    CARTCLASSIFY VARCHAR2(50) NOT NULL,
    USERSEQ NUMBER(8) NOT NULL,
    PRODUCTSEQ NUMBER(8) NOT NULL,
    SELECTOPTION VARCHAR2(500),
    QUANTITY NUMBER(8),
    PRICE NUMBER(8),
    CARTDATE DATE NOT NULL,
    CARTDEL NUMBER(1) NOT NULL
);

--CREATE SEQUENCE SEQ_CART
--START WITH 1
--INCREMENT BY 1;

ALTER TABLE CART
ADD CONSTRAINT FK_CART_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);

ALTER TABLE CART
ADD CONSTRAINT FK_CART_PRODUCTSEQ FOREIGN KEY(PRODUCTSEQ)
REFERENCES PRODUCTIONS(PRODUCTSEQ);


SELECT CARTCLASSIFY, C.USERSEQ, C.PRODUCTSEQ, SELECTOPTION, QUANTITY, PRICE, CARTDATE, CARTDEL,
        P.PRODUCTNAME, P.PRODUCTMAKER, P.PRODUCTFILENAME
FROM CART C, PRODUCTIONS P
WHERE C.PRODUCTSEQ=P.PRODUCTSEQ AND CARTCLASSIFY='CT-5'
ORDER BY CARTDATE ASC;





------- �ֹ� ���̺� --------------------

DROP TABLE ORDERS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_ORDER;

CREATE TABLE ORDERS(
    ORDERSEQ NUMBER(8) PRIMARY KEY,
    USERSEQ NUMBER(8) NOT NULL,
    ADDRESSSEQ NUMBER(8) NOT NULL,
    PRODUCTAMOUNT NUMBER(8),
    DELIVERYAMOUNT NUMBER(8),
    TOTALAMOUNT NUMBER(8),
    AMOUNTTYPE NUMBER(2),
    USEMILEAGE NUMBER(8),
    SAVEMILEAGE NUMBER(8)
);

CREATE SEQUENCE SEQ_ORDER
START WITH 1
INCREMENT BY 1;

ALTER TABLE ORDERS
ADD CONSTRAINT FK_ORDER_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);

ALTER TABLE ORDERS
ADD CONSTRAINT FK_ORDER_ADDRESSSEQ FOREIGN KEY(ADDRESSSEQ)
REFERENCES ADDRESS(ADDRESSSEQ);


------���� ��ǰ ��� ���̺� -------------------


DROP TABLE PURCHASE_PRODUCT
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PURC_PROD;

CREATE TABLE PURCHASE_PRODUCT(
    PURCHASESEQ NUMBER(8) PRIMARY KEY,
    ORDERSEQ NUMBER(8) NOT NULL,
    PRODUCTSEQ NUMBER(8) NOT NULL,
    USERSEQ NUMBER(8) NOT NULL,
    SELECTOPTION VARCHAR2(500),
    QUANTITY NUMBER(8),
    PRICE NUMBER(8)
);

CREATE SEQUENCE SEQ_PURC_PROD
START WITH 1
INCREMENT BY 1;


ALTER TABLE PURCHASE_PRODUCT
ADD CONSTRAINT FK_PURC_ORDERSEQ FOREIGN KEY(ORDERSEQ)
REFERENCES ORDERS(ORDERSEQ);

ALTER TABLE PURCHASE_PRODUCT
ADD CONSTRAINT FK_PURC_PRODUCTSEQ FOREIGN KEY(PRODUCTSEQ)
REFERENCES PRODUCTIONS(PRODUCTSEQ);

ALTER TABLE PURCHASE_PRODUCT
ADD CONSTRAINT FK_PURC_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);



----------���丮 �Խñ� ���̺�-----------------

DROP TABLE CARD_COLLECTIONS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_CARD;

CREATE TABLE CARD_COLLECTIONS(
    CARDSEQ NUMBER(8) PRIMARY KEY,
	CARDTITLE VARCHAR2(100) NOT NULL,
	CARDCONTENT VARCHAR2(500) NOT NULL,
	USERSEQ NUMBER(8) NOT NULL,
	CARDREADCOUNT NUMBER(8) NOT NULL,
	CARDDATE DATE NOT NULL,
    CARDFILENAME VARCHAR2(100) NOT NULL,
    CARDDEL NUMBER(1) NOT NULL
);

CREATE SEQUENCE SEQ_CARD
START WITH 1
INCREMENT BY 1;


INSERT INTO CARD_COLLECTIONS  VALUES (SEQ_CARD.NEXTVAL, '�׽�Ʈ1', '�׽�Ʈ��1', 1, 0, SYSDATE, '123.jpg', 0);
commit;

-----------���丮 ���ƿ� ���̺�---------------

DROP TABLE CARD_FAVORITE
CASCADE CONSTRAINTS;

CREATE TABLE CARD_FAVORITE(
    USERSEQ NUMBER(8) NOT NULL,
    CARDSEQ NUMBER(8) NOT NULL
);

ALTER TABLE CARD_FAVORITE
ADD CONSTRAINT FK_FAVO_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);

ALTER TABLE CARD_FAVORITE
ADD CONSTRAINT FK_FAVO_CARDSEQ FOREIGN KEY(CARDSEQ)
REFERENCES CARD_COLLECTIONS(CARDSEQ);



-----------���丮 ��� ���̺�---------------


DROP TABLE CARD_REVIEW
CASCADE CONSTRAINTS;

CREATE TABLE CARD_REVIEW(
    CARDREVSEQ NUMBER(8) PRIMARY KEY,
    CARDSEQ NUMBER(8) NOT NULL,
    NICKNAME VARCHAR2(20) NOT NULL,
    CARDREVCONTENT VARCHAR2(100) NOT NULL,
    CARDREVDATE DATE NOT NULL,
    CARDREVDEL NUMBER(1) NOT NULL,
    CONSTRAINT FK_REVIEW_CARDSEQ FOREIGN KEY(CARDSEQ)
    REFERENCES CARD_COLLECTIONS(CARDSEQ)
);

CREATE SEQUENCE SEQ_REVIEW_CARD
START WITH 1
INCREMENT BY 1;


INSERT INTO CARD_REVIEW
VALUES (SEQ_REVIEW_CARD.NEXTVAL, 4, 'nickname1', 'ħ�� ��𲫰���??', 
        SYSDATE, 0);
INSERT INTO CARD_REVIEW
VALUES (SEQ_REVIEW_CARD.NEXTVAL, 4, 'nickname2', '�ʹ� �̻���', 
        SYSDATE, 0);
INSERT INTO CARD_REVIEW
VALUES (SEQ_REVIEW_CARD.NEXTVAL, 4, 'nickname3', '���', 
        SYSDATE, 0);
        INSERT INTO CARD_REVIEW
VALUES (SEQ_REVIEW_CARD.NEXTVAL, 4, 'nickname4', '�߲ٸ��', 
        SYSDATE, 0);
        INSERT INTO CARD_REVIEW
VALUES (SEQ_REVIEW_CARD.NEXTVAL, 4, 'nickname5', '�������׽�Ʈ', 
        SYSDATE, 0);

COMMIT;

SELECT CARDREVSEQ, CARDSEQ, NICKNAME, CARDREVCONTENT, CARDREVDATE, CARDREVDEL
FROM (SELECT ROW_NUMBER()OVER(ORDER BY CARDREVSEQ DESC) AS RNUM, CARDREVSEQ, CARDSEQ, NICKNAME, CARDREVCONTENT, CARDREVDATE, CARDREVDEL FROM CARD_REVIEW)	
WHERE CARDSEQ=1 AND RNUM>=1 AND RNUM<=4;

-----------���丮 �� �±� ���̺�---------------

DROP TABLE CARD_TAG
CASCADE CONSTRAINTS;

CREATE TABLE CARD_TAG(
    CARDSEQ NUMBER(8) NOT NULL,
    TAGCOLOR VARCHAR2(50),
    TAGHOMETYPE VARCHAR2(50),
    TAGSTYLE VARCHAR2(50),
    CONSTRAINT FK_TAG_CARDSEQ FOREIGN KEY(CARDSEQ)
    REFERENCES CARD_COLLECTIONS(CARDSEQ)
);

-----------���丮 ���� ��ǥ ���̺�---------------

DROP TABLE CARD_COORDINATES
CASCADE CONSTRAINTS;

CREATE TABLE CARD_COORDINATES(
    CARDSEQ NUMBER(8) NOT NULL,
    PRODUCTSEQ NUMBER(8) NOT NULL,
    LOCATIONX NUMBER(8),
    LOCATIONY NUMBER(8),
    CONSTRAINT FK_COORDI_CARDSEQ FOREIGN KEY(CARDSEQ)
    REFERENCES CARD_COLLECTIONS(CARDSEQ)
);


-----------------------------------------------

SELECT C.CARDSEQ, C.CARDTITLE, C.CARDCONTENT, U.USERSEQ, C.CARDREADCOUNT, C.CARDDATE, CARDFILENAME, CARDDEL, U.NICKNAME, F.LIKECOUNT  
FROM USERS U, CARD_COLLECTIONS C, (SELECT CARDSEQ, NVL(COUNT(*), 0) LIKECOUNT FROM CARD_FAVORITE GROUP BY CARDSEQ) F
WHERE U.USERSEQ=C.USERSEQ AND C.CARDSEQ=F.CARDSEQ(+);



SELECT CARDSEQ, NVL(COUNT(*), 0)
FROM CARD_FAVORITE
GROUP BY CARDSEQ;



-------��ǰ ���̺�------------------------


DROP TABLE PRODUCTIONS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PRODUCT;

CREATE TABLE PRODUCTIONS(
    PRODUCTSEQ NUMBER(8) PRIMARY KEY,
	PRODUCTNAME VARCHAR2(100) NOT NULL,
	PRODUCTCONTENT CLOB NOT NULL,
	PRODUCTPRICE NUMBER(8) NOT NULL,
	PRODUCTDISCOUNT NUMBER(8),
	PRODUCTMAKER VARCHAR2(100),
    PRODUCTFILENAME VARCHAR2(100) NOT NULL,
    PRODUCTRATING NUMBER
);

CREATE SEQUENCE SEQ_PRODUCT
START WITH 1
INCREMENT BY 1;

INSERT INTO PRODUCTIONS(PRODUCTSEQ, PRODUCTNAME, PRODUCTCONTENT, PRODUCTPRICE, PRODUCTDISCOUNT, PRODUCTMAKER, PRODUCTFILENAME, PRODUCTRATING)
VALUES (SEQ_PRODUCT.NEXTVAL, 'OFFICY ������ 4.1��', '���� ����', '78900', '38900', '���ɾ�', 'product1.jpg', 4.1);

INSERT INTO PRODUCTIONS(PRODUCTSEQ, PRODUCTNAME, PRODUCTCONTENT, PRODUCTPRICE, PRODUCTDISCOUNT, PRODUCTMAKER, PRODUCTFILENAME, PRODUCTRATING)
VALUES (SEQ_PRODUCT.NEXTVAL, 'LED USB ������ �ø���', '���� ����', '11000', null, '���ɾ�', 'product2.jpg', 4.4);

INSERT INTO PRODUCTIONS(PRODUCTSEQ, PRODUCTNAME, PRODUCTCONTENT, PRODUCTPRICE, PRODUCTDISCOUNT, PRODUCTMAKER, PRODUCTFILENAME, PRODUCTRATING)
VALUES (SEQ_PRODUCT.NEXTVAL, '��� ������ 3/4/5�� ������', '���� ����', 69900, 39900, '����̺���', 'product3.png', 4.4);

COMMIT;

SELECT PRODUCTSEQ, PRODUCTNAME, PRODUCTCONTENT, PRODUCTPRICE, PRODUCTDISCOUNT, PRODUCTMAKER, PRODUCTFILENAME, PRODUCTRATING
FROM PRODUCTIONS
ORDER BY PRODUCTSEQ DESC;



SELECT PRODUCTSEQ, PRODUCTNAME, PRODUCTCONTENT, PRODUCTPRICE, PRODUCTDISCOUNT, PRODUCTMAKER, PRODUCTFILENAME, PRODUCTRATING
FROM PRODUCTIONS
WHERE PRODUCTSEQ=1;

------��ǰ �ɼ� ���̺�----------------------

DROP TABLE PRODUCTION_OPTION
CASCADE CONSTRAINTS;


CREATE TABLE PRODUCTION_OPTION(
    PRODUCTSEQ NUMBER(8) NOT NULL,
    OPTIONSEQ NUMBER(8) NOT NULL,
    OPTIONTITLE VARCHAR2(100) NOT NULL,
    OPTIONCONTENT VARCHAR2(500),
    OPTIONPRICE NUMBER
);


------��ǰ �±� ���̺�---------------------

DROP TABLE PRODUCTION_TAG
CASCADE CONSTRAINTS;


CREATE TABLE PRODUCTION_TAG(
    PRODUCTSEQ NUMBER(8) NOT NULL,
    LARGECATEGORY VARCHAR2(100) NOT NULL,
    MEDIUMCATEGORY VARCHAR2(100) NOT NULL,
    SMALLCATEGORY VARCHAR2(100) NOT NULL
);



-------��ǰ ���� ���̺�-----------------------------

DROP TABLE PRODUCTION_REVIEW
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PRODUCT_REV;

CREATE TABLE PRODUCTION_REVIEW(
    PRODUCTREVSEQ NUMBER(8) PRIMARY KEY,
    PRODUCTSEQ NUMBER(8) NOT NULL,
    USERSEQ NUMBER(8) NOT NULL,
    PURCHASESEQ NUMBER(8) NOT NULL,
    PRODUCTREVCONTENT VARCHAR2(200),
    PRODUCTREVFILENAME VARCHAR2(100),
    PRODUCTREVDEL NUMBER(8) NOT NULL,
    PRODUCTREVRATING NUMBER(8) NOT NULL
);

CREATE SEQUENCE SEQ_PRODUCT_REV
START WITH 1
INCREMENT BY 1;

ALTER TABLE PRODUCTION_REVIEW
ADD CONSTRAINT FK_PRODREV_PRODUCTSEQ FOREIGN KEY(PRODUCTSEQ)
REFERENCES PRODUCTIONS(PRODUCTSEQ);

ALTER TABLE PRODUCTION_REVIEW
ADD CONSTRAINT FK_PRODREV_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);

ALTER TABLE PRODUCTION_REVIEW
ADD CONSTRAINT FK_PRODREV_PURCHASESEQ FOREIGN KEY(PURCHASESEQ)
REFERENCES PURCHASE_PRODUCT(PURCHASESEQ);



-----��ǰ ���� ���̺�-----------------


DROP TABLE PRODUCTION_QUESTION
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PRODUCT_QNA;

CREATE TABLE PRODUCTION_QUESTION(
    PRODUCTQNASEQ NUMBER(8) PRIMARY KEY,
    PRODUCTSEQ NUMBER(8) NOT NULL,
    USERSEQ NUMBER(8) NOT NULL,
    PURCHASESEQ NUMBER(8) NOT NULL,
    PRODUCTQCONTENT VARCHAR2(200),
    PRODUCTACONTENT VARCHAR2(200),
    PRODUCTQNADATE DATE NOT NULL,
    PRODUCTQNADEL NUMBER(8) NOT NULL
);

CREATE SEQUENCE SEQ_PRODUCT_QNA
START WITH 1
INCREMENT BY 1;

ALTER TABLE PRODUCTION_QUESTION
ADD CONSTRAINT FK_PRODQNA_PRODUCTSEQ FOREIGN KEY(PRODUCTSEQ)
REFERENCES PRODUCTIONS(PRODUCTSEQ);

ALTER TABLE PRODUCTION_QUESTION
ADD CONSTRAINT FK_PRODQNA_USERSEQ FOREIGN KEY(USERSEQ)
REFERENCES USERS(USERSEQ);

ALTER TABLE PRODUCTION_QUESTION
ADD CONSTRAINT FK_PRODQNA_PURCHASESEQ FOREIGN KEY(PURCHASESEQ)
REFERENCES PURCHASE_PRODUCT(PURCHASESEQ);


---------------------------------------------


SELECT C.CARDSEQ, C.CARDTITLE, C.CARDCONTENT, U.USERSEQ, C.CARDREADCOUNT, C.CARDDATE, CARDFILENAME, CARDDEL, U.NICKNAME, F.LIKECOUNT  
FROM USERS U, CARD_COLLECTIONS C, (SELECT CARDSEQ, NVL(COUNT(*), 0) LIKECOUNT FROM CARD_FAVORITE GROUP BY CARDSEQ) F
WHERE U.USERSEQ=C.USERSEQ AND C.CARDSEQ=F.CARDSEQ(+)
ORDER BY F.LIKECOUNT DESC NULLS LAST;



















