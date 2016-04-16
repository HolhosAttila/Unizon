/*
CSERE:

EZT: VARCHAR2 (
ERRE: VARCHAR(

(igen ott extra szokoz van a number elott)
EZT:  NUMBER
ERRE:  INT

TOROLNI:
NOT DEREFERRABLE

ADMIN USER: USERNAME: admin 
            PASSWORD: admin
TEST USER: USERNAME: teszt
           PASSWORD: teszt
*/

DROP DATABASE IF EXISTS unizon;

CREATE DATABASE unizon CHARACTER SET UTF8;

USE unizon;

CREATE TABLE ADDRESS
  (
    ADDRESS_ID INT NOT NULL ,
    ZIP        VARCHAR(10) NOT NULL ,
    COUNTRY    VARCHAR(100) NOT NULL ,
    CITY       VARCHAR(100) NOT NULL ,
    STREET     VARCHAR(100) NOT NULL ,
    STR_NUMBER INT NOT NULL ,
    FLOOR      INT ,
    DOOR       INT
  ) ;
ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS_PK PRIMARY KEY ( ADDRESS_ID ) ;
ALTER TABLE ADDRESS ADD CONSTRAINT ADDRESS__UN UNIQUE ( ZIP , COUNTRY , CITY , STREET , STR_NUMBER , FLOOR , DOOR ) ;


CREATE TABLE ADDRESS_TO_USER
  (
    USER_ID    INT NOT NULL ,
    ADDRESS_ID INT NOT NULL
  ) ;
ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESSES_OF_USER_PK PRIMARY KEY ( USER_ID, ADDRESS_ID ) ;


CREATE TABLE ADMINISTRATOR
  ( USER_ID INT NOT NULL
  ) ;
ALTER TABLE ADMINISTRATOR ADD CONSTRAINT ADMINISTRATOR_PK PRIMARY KEY ( USER_ID ) ;


CREATE TABLE CATEGORY
  (
    CATEGORY_ID INT NOT NULL ,
    NAME        VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_PK PRIMARY KEY ( CATEGORY_ID ) ;
ALTER TABLE CATEGORY ADD CONSTRAINT CATEGORY_UNIQUE UNIQUE ( NAME ) ;


CREATE TABLE CAT_TO_PROD
  (
    PRODUCT_ID  INT NOT NULL ,
    CATEGORY_ID INT NOT NULL
  ) ;
ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_PK PRIMARY KEY ( PRODUCT_ID, CATEGORY_ID ) ;


CREATE TABLE IMAGE
  ( IMAGE_ID INT NOT NULL , IMAGE_URL VARCHAR(1000)
  ) ;
ALTER TABLE IMAGE ADD CONSTRAINT IMAGE_PK PRIMARY KEY ( IMAGE_ID ) ;
ALTER TABLE IMAGE ADD CONSTRAINT IMAGE__UN UNIQUE ( IMAGE_URL ) ;


CREATE TABLE PHONE_NUMBER
  (
    PHONE_NUMBER_ID INT NOT NULL ,
    PHONE_NUMBER    VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE PHONE_NUMBER ADD CONSTRAINT PHONE_NUMBER_PK PRIMARY KEY ( PHONE_NUMBER_ID ) ;
ALTER TABLE PHONE_NUMBER ADD CONSTRAINT PHONE_NUMBER__UNIQUE UNIQUE ( PHONE_NUMBER ) ;


CREATE TABLE PRODUCT
  (
    PRODUCT_ID       INT NOT NULL ,
    TITLE            VARCHAR(100) NOT NULL ,
    PRICE            INT ,
    AMOUNT           INT ,
    DESCRIPTION      VARCHAR(1000) ,
    DEFAULT_IMAGE_ID INT NOT NULL
  ) ;
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY ( PRODUCT_ID ) ;


CREATE TABLE PRODUCT_TO_IMAGE
  (
    PRODUCT_ID INT NOT NULL ,
    IMAGE_ID   INT NOT NULL
  ) ;
ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_PK PRIMARY KEY ( PRODUCT_ID, IMAGE_ID ) ;


CREATE TABLE PROD_TO_ORDER
  (
    ORDER_ID   INT NOT NULL ,
    PRODUCT_ID INT NOT NULL ,
    AMOUNT     INT NOT NULL
  ) ;
ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_PK PRIMARY KEY ( ORDER_ID, PRODUCT_ID ) ;


CREATE TABLE PROD_TO_TAG
  (
    PRODUCT_ID INT NOT NULL ,
    TAG_ID     INT NOT NULL
  ) ;
ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_PK PRIMARY KEY ( PRODUCT_ID, TAG_ID ) ;


CREATE TABLE TAG
  ( TAG_ID INT NOT NULL , NAME VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE TAG ADD CONSTRAINT TAG_PK PRIMARY KEY ( TAG_ID ) ;
ALTER TABLE TAG ADD CONSTRAINT TAG_UNIQUE UNIQUE ( NAME ) ;


CREATE TABLE UNI_ORDER
  (
    ORDER_ID            INT NOT NULL ,
    USER_ID             INT NOT NULL ,
    PHONE_NUMBER_ID     INT NOT NULL ,
    ORDER_DATE          DATE NOT NULL ,
    SHIPPING_ADDRESS_ID INT NOT NULL ,
    BILLING_ADDRESS_ID  INT NOT NULL
  ) ;
ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_PK PRIMARY KEY ( ORDER_ID ) ;


CREATE TABLE UNI_USER
  (
    USER_ID           INT NOT NULL ,
    USERNAME          VARCHAR(100) NOT NULL ,
    PASSWORD          VARCHAR(100) NOT NULL ,
    E_MAIL            VARCHAR(100) NOT NULL ,
    NAME              VARCHAR(100) NOT NULL ,
    REGISTRATION_DATE DATE NOT NULL ,
    STATUS_ID         INT NOT NULL
  ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_PK PRIMARY KEY ( USER_ID ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_EMAIL UNIQUE ( E_MAIL ) ;
ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_USERNAME UNIQUE ( USERNAME ) ;


CREATE TABLE USER_ACTIVATION
  (
    USER_ID        INT NOT NULL ,
    ACTIVATION_KEY VARCHAR(200) NOT NULL
  ) ;
ALTER TABLE USER_ACTIVATION ADD CONSTRAINT USER_ACTIVATION_PK PRIMARY KEY ( USER_ID ) ;


CREATE TABLE USER_STATUS
  (
    STATUS_ID   INT NOT NULL ,
    STATUS_NAME VARCHAR(100) NOT NULL
  ) ;
ALTER TABLE USER_STATUS ADD CONSTRAINT USER_STATUS_PK PRIMARY KEY ( STATUS_ID ) ;
ALTER TABLE USER_STATUS ADD CONSTRAINT USER_STATUS__UN UNIQUE ( STATUS_NAME ) ;


CREATE TABLE USER_TO_PHONE_NUMBER
  (
    USER_ID         INT NOT NULL ,
    PHONE_NUMBER_ID INT NOT NULL
  ) ;
ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_PK PRIMARY KEY ( USER_ID, PHONE_NUMBER_ID ) ;


ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESS_TO_USER_ADDRESS_FK FOREIGN KEY ( ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE ADDRESS_TO_USER ADD CONSTRAINT ADDRESS_TO_USER_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE ADMINISTRATOR ADD CONSTRAINT ADMINISTRATOR_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_CATEGORY_FK FOREIGN KEY ( CATEGORY_ID ) REFERENCES CATEGORY ( CATEGORY_ID ) ;

ALTER TABLE CAT_TO_PROD ADD CONSTRAINT CAT_TO_PROD_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_BI_ADDRESS_FK FOREIGN KEY ( BILLING_ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_PHONE_NUMBER_FK FOREIGN KEY ( PHONE_NUMBER_ID ) REFERENCES PHONE_NUMBER ( PHONE_NUMBER_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT ORDER_SH_ADDRESS_FK FOREIGN KEY ( SHIPPING_ADDRESS_ID ) REFERENCES ADDRESS ( ADDRESS_ID ) ;

ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_IMAGE_FK FOREIGN KEY ( DEFAULT_IMAGE_ID ) REFERENCES IMAGE ( IMAGE_ID ) ;

ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_IMAGE_FK FOREIGN KEY ( IMAGE_ID ) REFERENCES IMAGE ( IMAGE_ID ) ;

ALTER TABLE PRODUCT_TO_IMAGE ADD CONSTRAINT PRODUCT_TO_IMAGE_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_ORDER_FK FOREIGN KEY ( ORDER_ID ) REFERENCES UNI_ORDER ( ORDER_ID ) ;

ALTER TABLE PROD_TO_ORDER ADD CONSTRAINT PROD_TO_ORDER_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_PRODUCT_FK FOREIGN KEY ( PRODUCT_ID ) REFERENCES PRODUCT ( PRODUCT_ID ) ;

ALTER TABLE PROD_TO_TAG ADD CONSTRAINT PROD_TO_TAG_TAG_FK FOREIGN KEY ( TAG_ID ) REFERENCES TAG ( TAG_ID ) ;

ALTER TABLE UNI_ORDER ADD CONSTRAINT UNI_ORDER_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE UNI_USER ADD CONSTRAINT UNI_USER_USER_STATUS_FK FOREIGN KEY ( STATUS_ID ) REFERENCES USER_STATUS ( STATUS_ID ) ;

ALTER TABLE USER_ACTIVATION ADD CONSTRAINT USER_ACTIVATION_UNI_USER_FK FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;

ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_FK1 FOREIGN KEY ( PHONE_NUMBER_ID ) REFERENCES PHONE_NUMBER ( PHONE_NUMBER_ID ) ;

ALTER TABLE USER_TO_PHONE_NUMBER ADD CONSTRAINT USER_TO_PHONE_NUMBER_FK2 FOREIGN KEY ( USER_ID ) REFERENCES UNI_USER ( USER_ID ) ;


INSERT INTO USER_STATUS(STATUS_ID, STATUS_NAME) VALUES(-1, 'inactive');
INSERT INTO USER_STATUS(STATUS_ID, STATUS_NAME) VALUES(-2, 'active');
INSERT INTO USER_STATUS(STATUS_ID, STATUS_NAME) VALUES(-3, 'final');

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-1,'admin', 'cveqGRZfe2VtNuO0yDGhYviUTZWxmiIt3aZmzqm80n8=$NaOrIMoClDCyLPGoVsClrEYLGKw7U5uYFJkrhAhC0R4=','admin@gmail.com','admin','2016-04-09', -2);

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-2,'teszt','KIkvsQZnyEk0LQLlYred1uylvnldBomKstriJL95CsE=$rQWuk868O5zFfigoWjnG+Hlmy6bpMnXjslZw+mOzV2Y=','teszt@gmail.com','teszt', '2016-04-09', -2);

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-3,'teszt2','TZpGuKBYR/QjJCViOdvUf+e5WqSJ8gqexk86Np7tJLo=$QplC/APJIN1zPzLF9jbwyJ9j7idJIj9zNkuqLfo+d/c=','teszt2@gmail.com','teszt2', '2015-03-04', -2);

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-4,'teszt3','TZpGuKBYR/QjJCViOdvUf+e5WqSJ8gqexk86Np7tJLo=$QplC/APJIN1zPzLF9jbwyJ9j7idJIj9zNkuqLfo+d/c=','teszt3@gmail.com','teszt3', '2015-03-04', -1);

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-5,'teszt4','TZpGuKBYR/QjJCViOdvUf+e5WqSJ8gqexk86Np7tJLo=$QplC/APJIN1zPzLF9jbwyJ9j7idJIj9zNkuqLfo+d/c=','teszt4@gmail.com','teszt4', '2015-03-04', -3);

INSERT INTO UNI_USER(USER_ID, USERNAME, PASSWORD, E_MAIL, NAME, REGISTRATION_DATE, STATUS_ID)
    VALUES(-6,'admin2','TZpGuKBYR/QjJCViOdvUf+e5WqSJ8gqexk86Np7tJLo=$QplC/APJIN1zPzLF9jbwyJ9j7idJIj9zNkuqLfo+d/c=','admin2@gmail.com','admin2', '2013-03-04', -2);





INSERT INTO ADMINISTRATOR VALUES(-1);
INSERT INTO ADMINISTRATOR VALUES(-6);


INSERT INTO ADDRESS VALUES(-1, 5342, 'Hungary', 'Debrecen', 'Kassai út', 1, 4, 2); 
INSERT INTO ADDRESS VALUES(-2, 3321, 'Hungary', 'Budapest', 'Pesti utca', 12, 10, 32); 
INSERT INTO ADDRESS VALUES(-3, 3300, 'Hungary', 'Eger', 'Dobó utca', 10, 122, 10);
INSERT INTO ADDRESS VALUES(-4, 2034, 'Hungary', 'Budapest', 'Diószegi utca', 12, null, null); 
INSERT INTO ADDRESS VALUES(-5, 4004, 'Hungary', 'Szeged', 'Pesti út', 56, null, null); 
INSERT INTO ADDRESS VALUES(-6, 4027, 'Hungary', 'Sátoraljaújhely', 'Kossuth Lajos utca', 13, 2, 4); 

INSERT INTO ADDRESS_TO_USER VALUES(-1, -1);
INSERT INTO ADDRESS_TO_USER VALUES(-2, -2);
INSERT INTO ADDRESS_TO_USER VALUES(-2, -3);
INSERT INTO ADDRESS_TO_USER VALUES(-3, -3);
INSERT INTO ADDRESS_TO_USER VALUES(-4, -4);
INSERT INTO ADDRESS_TO_USER VALUES(-5, -5);
INSERT INTO ADDRESS_TO_USER VALUES(-6, -6);

INSERT INTO PHONE_NUMBER VALUES(-1, '+3630213334');
INSERT INTO PHONE_NUMBER VALUES(-2, '+3620183420');
INSERT INTO PHONE_NUMBER VALUES(-3, '+3670690664');
INSERT INTO PHONE_NUMBER VALUES(-4, '+3670611910');
INSERT INTO PHONE_NUMBER VALUES(-5, '+3630846244');
INSERT INTO PHONE_NUMBER VALUES(-6, '+3612735067');
INSERT INTO PHONE_NUMBER VALUES(-7, '+3652313648');
INSERT INTO PHONE_NUMBER VALUES(-8, '+3630918465');
INSERT INTO PHONE_NUMBER VALUES(-9, '+3670448372');
INSERT INTO PHONE_NUMBER VALUES(-10, '+3620837492');
INSERT INTO PHONE_NUMBER VALUES(-11, '+3670124217');

INSERT INTO USER_TO_PHONE_NUMBER VALUES(-1, -1);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-1, -11);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-2, -2);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-2, -3);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-3, -4);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-3, -10);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-4, -5);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-5, -6);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-6, -7);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-6, -8);
INSERT INTO USER_TO_PHONE_NUMBER VALUES(-6, -9);



INSERT INTO UNIZON.UNI_ORDER VALUES (-1,-1,-11,'2016-04-15',-1,-1);
INSERT INTO UNIZON.UNI_ORDER VALUES(-2,-1,-1,'2016-04-13',-1,-1);
INSERT INTO UNIZON.UNI_ORDER VALUES(-3,-2,-2,'2016-04-13',-2,-2);
INSERT INTO UNIZON.UNI_ORDER VALUES(-4,-2,-2,'2007-07-02',-3,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-5,-2,-3,'2011-01-23',-2,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-6,-2,-3,'2014-04-13',-3,-2);
INSERT INTO UNIZON.UNI_ORDER VALUES(-7,-3,-10,'2015-05-09',-3,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-8,-3,-4,'2015-05-30',-3,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-9,-3,-10,'2015-09-28',-3,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-10,-3,-4,'2016-02-29',-3,-3);
INSERT INTO UNIZON.UNI_ORDER VALUES(-11,-4,-5,'2002-02-02',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-12,-4,-5,'2002-10-17',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-13,-4,-5,'2004-01-03',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-14,-4,-5,'2005-08-29',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-15,-4,-5,'2010-11-15',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-16,-4,-5,'2010-12-17',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-17,-4,-5,'2011-06-01',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-18,-4,-5,'2011-10-16',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-19,-4,-5,'2013-01-20',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-20,-4,-5,'2013-05-24',-4,-4);
INSERT INTO UNIZON.UNI_ORDER VALUES(-21,-5,-6,'2004-01-11',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-22,-5,-6,'2012-12-23',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-23,-5,-6,'2013-03-22',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-24,-5,-6,'2013-06-10',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-25,-5,-6,'2013-05-06',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-26,-5,-6,'2013-03-12',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-27,-5,-6,'2014-02-05',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-28,-5,-6,'2014-05-01',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-29,-5,-6,'2001-11-19',-5,-5);
INSERT INTO UNIZON.UNI_ORDER VALUES(-30,-6,-7,'2015-12-11',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-31,-6,-9,'2009-04-11',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-32,-6,-8,'2011-12-10',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-33,-6,-7,'2014-05-06',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-34,-6,-8,'2012-02-04',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-35,-6,-7,'2003-11-02',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-36,-6,-9,'2006-09-07',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-37,-6,-8,'2016-01-23',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-38,-6,-7,'2010-03-14',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-39,-6,-7,'2009-10-01',-6,-6);
INSERT INTO UNIZON.UNI_ORDER VALUES(-40,-6,-8,'2003-06-02',-6,-6);




INSERT INTO IMAGE VALUES(-1,"http://www.trusteegaps.com/images/large/nikefreefutcip/Adidas-Cip-Feh-r-K-k-Piros-472ie3860_02_LRG.jpg");
INSERT INTO IMAGE VALUES(-2,"http://playersroom.hu/upload_files/products/AO2891_5.jpg");
INSERT INTO IMAGE VALUES(-3,"http://www.adidascenter.com/img/p/6735-11143-thickbox.jpg");
INSERT INTO IMAGE VALUES(-4,"http://www.intersport.si/wcsstore/Intersport/images/products/a081/887231908882_01_mega.jpg");
INSERT INTO IMAGE VALUES(-5,"http://www.nikecipo-webshop.hu/wp-content/uploads/S.729809_011-1-546x480.jpg");
INSERT INTO IMAGE VALUES(-6,"http://s3emagst.akamaized.net/products/1072/1071426/images/res_43dcd7b9f15c65c4e7cc3ce1427b3eec_350x350c_spnr.jpg?v2");
INSERT INTO IMAGE VALUES(-7,"http://sportwebshop.net/sites/default/files/asics_knit_noi_kapucnis_pulover_2015.jpg");
INSERT INTO IMAGE VALUES(-8,"http://www.eshop-gyorsan.hu/fotky2550/fotos/_vyrn_164Beige-2014-wholesale-GEL-Running-Shoes-for-women-and-Men-girl-Ourdoor-casual-Shoes-brand-Noosa-tri.jpg");
INSERT INTO IMAGE VALUES(-9,"http://ujgsm.hu/itemPictures/pic-b-2515-loesm.jpg");
INSERT INTO IMAGE VALUES(-10,"http://s0.olcsobbat.hu/images/5143394b8a8e6d5c42000143-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-11,"http://s3.olcsobbat.hu/images/53a19c8f8a8e6d2e0a000221-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-12,"http://s2.olcsobbat.hu/images/554b1e1c8e16d52e49001d5d-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-13,"http://s1.olcsobbat.hu/images/554b1df08e16d5b1100004a1-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-14,"http://s3.olcsobbat.hu/images/512b20268a8e6dfe53001391-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-15,"http://s0.olcsobbat.hu/images/5179168b8a8e6d537e00003d-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-16,"http://s3.olcsobbat.hu/images/50ed65368a8e6d683b001282-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-17,"http://s0.olcsobbat.hu/images/5510744f8a8e6dbd77000005-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-18,"http://s0.olcsobbat.hu/images/5441d7658e16d5d63e000f89-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-19,"http://s1.olcsobbat.hu/images/5225c22f8a8e6d9049000020-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-20,"http://s2.olcsobbat.hu/images/502262aac1a99f10350005ca-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-21,"http://s0.olcsobbat.hu/images/563268af8a8e6de2630001c6-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-22,"http://s2.olcsobbat.hu/images/5271d2d18e16d5fc69000241-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-23,"http://s2.olcsobbat.hu/images/5171525b8e16d5701000046c-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-24,"http://s3.olcsobbat.hu/images/542963ed8e16d5044f000b1e-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-25,"http://s3.olcsobbat.hu/images/51f229948e16d54e5e035f15-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-26,"http://s2.olcsobbat.hu/images/4f8c2909c28b795c520292ba-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-27,"http://s3.olcsobbat.hu/images/543f2ae48e16d5e121003b8f-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-28,"http://s1.olcsobbat.hu/images/545ae9f48e16d5075b000019-480x480-resize-transparent.png");
INSERT INTO IMAGE VALUES(-29,"http://i.ebayimg.com/images/g/ArkAAOSwbqpTsYr8/s-l1600.jpg");
INSERT INTO IMAGE VALUES(-30,"http://i.ebayimg.com/images/g/vF0AAOSwl8NVXI1A/s-l1600.jpg");
INSERT INTO IMAGE VALUES(-31,"http://i.ebayimg.com/images/g/FVoAAOSw5dNWhJTn/s-l500.jpg");
INSERT INTO IMAGE VALUES(-32,"http://i.ebayimg.com/images/g/CXwAAOSwgQ9Vncvg/s-l1600.jpg");
INSERT INTO IMAGE VALUES(-33,"http://i.ebayimg.com/images/g/B5gAAOSwzhVWrNGx/s-l1600.jpg");
INSERT INTO IMAGE VALUES(-34,"http://ecx.images-amazon.com/images/I/71TIgfo-9OL._SL1200_.jpg");
INSERT INTO IMAGE VALUES(-35,"http://ecx.images-amazon.com/images/I/71%2B3SPiTosL._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-36,"http://ecx.images-amazon.com/images/I/81itdej9OJL._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-37,"http://ecx.images-amazon.com/images/I/91TPmmUT5UL._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-38,"http://ecx.images-amazon.com/images/I/81r5NKXoxnL._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-39,"http://ecx.images-amazon.com/images/I/81KtrLWwA3L._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-40,"http://ecx.images-amazon.com/images/I/81xFPr7vlhL._SL1500_.jpg");
INSERT INTO IMAGE VALUES(-41,"http://i.movie.as/p/183580.jpg");
INSERT INTO IMAGE VALUES(-42,"https://upload.wikimedia.org/wikipedia/en/6/6b/Kate_and_leopold_ver2.jpg");
INSERT INTO IMAGE VALUES(-43,"https://upload.wikimedia.org/wikipedia/en/a/af/RoadToAvonlea_intertitle_s2.jpg");
INSERT INTO IMAGE VALUES(-44,"http://images.hngn.com/data/thumbs/full/186767/650/0/0/0/friends-cast.png");
INSERT INTO IMAGE VALUES(-45,"http://www.hercampus.com/sites/default/files/2014/03/27/tumblr_static_hiii.jpg");
INSERT INTO IMAGE VALUES(-46,"http://parkthatcar.net/wp-content/uploads/2013/02/himym.jpeg");
INSERT INTO IMAGE VALUES(-47,"http://blogs-images.forbes.com/merrillbarr/files/2014/05/how-i-met-your-mother.jpg");
INSERT INTO IMAGE VALUES(-48,"http://www.hercampus.com/sites/default/files/2014/11/09/Friends-season-10-014.jpg");
INSERT INTO IMAGE VALUES(-49,"http://cdn3.thr.com/sites/default/files/2014/05/friends_h.jpg");
INSERT INTO IMAGE VALUES(-50,"https://i.ytimg.com/vi/dhP6VyV_m2Y/maxresdefault.jpg");


INSERT INTO PRODUCT VALUES(-1,'Adidas cipő', 2990,210,'piros/fekete', -1);
INSERT INTO PRODUCT VALUES(-2,'Adidas pulcsi', 2100,210,'fehér/fekete', -2);
INSERT INTO PRODUCT VALUES(-3,'Adidas nadrág', 3990,210,'piros/kék', -3);
INSERT INTO PRODUCT VALUES(-4,'Nike pulcsi', 12990,210,'piros/fekete', -4);
INSERT INTO PRODUCT VALUES(-5,'Nike cipő', 22990,210,'piros/fekete', -5);
INSERT INTO PRODUCT VALUES(-6,'Nike nadrág', 29490,210,'piros/kék', -6);
INSERT INTO PRODUCT VALUES(-7,'Asics pulcsi', 1290,210,'piros/zöld', -7);
INSERT INTO PRODUCT VALUES(-8,'Asics cipő', 2990,210,'zöld/fekete', -8);
INSERT INTO PRODUCT VALUES(-9,'Samsung GALAXY S4 Mini', 59900,100,'fehér/fekete', -9);
INSERT INTO PRODUCT VALUES(-10,'Samsung GALAXY S4', 79000,210,'fehér/fekete', -10);
INSERT INTO PRODUCT VALUES(-11,'LG G3', 33000,100,'fehér/fekete', -11);
INSERT INTO PRODUCT VALUES(-12,'LG 32LF5610', 59990,50,'Full HD TV', -12);
INSERT INTO PRODUCT VALUES(-13,'Samsung UE32J5500', 79000,60,'Full HD TV', -13);
INSERT INTO PRODUCT VALUES(-14,'NIKON D5200 fényképező', 39000,200,'képméret: 6016 x 4000 (Nagy), 4512 x 3000 (Közepes), 3008 x 2000 (Kicsi)', -14);
INSERT INTO PRODUCT VALUES(-15,'Zanussi ZRT 18100 WA Hűtőgép', 109000,300,'fehér', -15);
INSERT INTO PRODUCT VALUES(-16,'Electrolux EWT1062TDW Mosógép', 89000,100,'fehér', -16);
INSERT INTO PRODUCT VALUES(-17,'Electrolux EKG54151OW Tűzhely', 79000,200,'fekete', -17);
INSERT INTO PRODUCT VALUES(-18,'Bosch BGB45331 Porszívó', 29000,210,'fekete', -18);
INSERT INTO PRODUCT VALUES(-19,'Electrolux EMS28201OW Mikrohullámú sütő', 59000,100,'fehér/fekete', -19);
INSERT INTO PRODUCT VALUES(-20,'Chanel Coco Mademoiselle Női parfüm', 9000,200,'EDP, 100 ml', -20);
INSERT INTO PRODUCT VALUES(-21,'Calvin Klein Eternity Női parfüm', 7000,200,'EDP, 100 ml', -21);
INSERT INTO PRODUCT VALUES(-22,'Giorgio Armani Si Női Parfüm', 12000,100,'EDP, 100 ml', -22);
INSERT INTO PRODUCT VALUES(-23,'Medisana felkaros vérnyomásmérő', 29000, 70,'digitális', -23);
INSERT INTO PRODUCT VALUES(-24,'Beurer GL Vércukorszintmérő', 39000,40,'42 mmol/L', -24);
INSERT INTO PRODUCT VALUES(-25,'Omron Eco Temp Smart lázmérő', 3000,210,'digitális', -25);
INSERT INTO PRODUCT VALUES(-26,'Robust Turbo Speed Bike Szobakerékpár', 79000,20,'pulzusmérővel', -26);
INSERT INTO PRODUCT VALUES(-27,'Robust Marathon Futópad', 129000,10,'pulzusmérővel', -27);
INSERT INTO PRODUCT VALUES(-28,'Robust Magnum Súlyzóspad', 99000,10,'', -28);
INSERT INTO PRODUCT VALUES(-29,'Guess Női táska', 8000,100,'rózsaszín/vörös/barna/fekete', -29);
INSERT INTO PRODUCT VALUES(-30,'Ralph Lauren Koktélruha', 7000,100,'kék/bordó/rózsaszín', -30);
INSERT INTO PRODUCT VALUES(-31,'Karkötő', 8000,100,'aranyszínű', -31);
INSERT INTO PRODUCT VALUES(-32,'Karkötő', 8000,100,'aranyszínű/ezüstszínű', -32);
INSERT INTO PRODUCT VALUES(-33,'Amie Black Faux Suede Csizma', 6000,100,'fekete/barna', -33);
INSERT INTO PRODUCT VALUES(-34,'Williams Legato Zongora',38000,100,'88 billentyűs', -34);
INSERT INTO PRODUCT VALUES(-35,'Alesis Demo Dob', 38000,100,'elektromos', -35);
INSERT INTO PRODUCT VALUES(-36,'Palmer PD21 Gitár', 18000,100,'akusztikus', -36);
INSERT INTO PRODUCT VALUES(-37,'Jenga', 2000,100,'4 év felett', -37);
INSERT INTO PRODUCT VALUES(-38,'Hasbro Connect4', 1500,100,'8 év felett', -38);
INSERT INTO PRODUCT VALUES(-39,'Uno', 2000,100,'8 év felett', -39);
INSERT INTO PRODUCT VALUES(-40,'Rubik kocka', 3000,100,'8 év felett', -40);
INSERT INTO PRODUCT VALUES(-41,'Annie 2014', 3000,100,'musical, vígjáték', -41);
INSERT INTO PRODUCT VALUES(-42,'Kate és Leopold', 3000,100,'romantikus, vígjáték', -42);
INSERT INTO PRODUCT VALUES(-43,'Váratlan utazás', 3000,100,'sorozat, kosztümös', -43);
INSERT INTO PRODUCT VALUES(-44,'Jóbarátok', 3000,100,'sorozat, sitcom', -44);
INSERT INTO PRODUCT VALUES(-45,'Így jártam anyátokkal', 3000,100,'sorozat, sitcom', -45);

INSERT INTO PRODUCT_TO_IMAGE VALUES (-1,-1);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-2,-2);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-3,-3);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-4,-4);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-5,-5);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-6,-6);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-7,-7);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-8,-8);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-9,-9);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-10,-10);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-11,-11);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-12,-12);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-13,-13);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-14,-14);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-15,-15);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-16,-16);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-17,-17);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-18,-18);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-19,-19);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-20,-20);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-21,-21);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-22,-22);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-23,-23);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-24,-24);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-25,-25);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-26,-26);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-27,-27);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-28,-28);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-29,-29);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-30,-30);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-31,-31);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-32,-32);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-33,-33);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-34,-34);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-35,-35);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-36,-36);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-37,-37);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-38,-38);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-39,-39);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-40,-40);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-41,-41);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-42,-42);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-43,-43);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-44,-44);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-45,-45);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-45,-46);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-45,-47);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-44,-48);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-44,-49);
INSERT INTO PRODUCT_TO_IMAGE VALUES (-44,-50);


INSERT INTO UNIZON.PROD_TO_ORDER(`ORDER_ID`,`PRODUCT_ID`,`AMOUNT`) VALUES(-1,-1,5);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-1,-6,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-2,-4,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-3,-8,2);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-4,-24,2);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-4,-44,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-4,-26,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-5,-3,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-5,-17,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-5,-42,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-6,-13,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-7,-11,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-7,-12,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-8,-15,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-9,-22,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-10,-1,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-11,-33,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-12,-36,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-13,-18,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-14,-6,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-15,-39,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-16,-40,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-17,-10,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-18,-18,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-19,-45,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-20,-20,3);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-21,-20,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-22,-16,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-23,-38,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-24,-3,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-25,-2,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-26,-9,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-27,-20,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-28,-16,2);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-29,-43,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-30,-41,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-31,-42,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-32,-29,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-33,-29,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-34,-24,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-35,-23,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-36,-22,2);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-37,-27,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-38,-28,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-38,-20,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-39,-41,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-39,-43,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-39,-42,1);
INSERT INTO UNIZON.PROD_TO_ORDER VALUES(-40,-20,1);



INSERT INTO CATEGORY VALUES(-1,'Ruházat');
INSERT INTO CATEGORY VALUES(-2,'Mobilok');
INSERT INTO CATEGORY VALUES(-3,'TV');
INSERT INTO CATEGORY VALUES(-4,'Konyhai elektronikai cikkek');
INSERT INTO CATEGORY VALUES(-5,'Cipők');
INSERT INTO CATEGORY VALUES(-6,'Parfümök');
INSERT INTO CATEGORY VALUES(-7,'Mosógépek');
INSERT INTO CATEGORY VALUES(-8,'Porszívók');
INSERT INTO CATEGORY VALUES(-9,'Egészség');
INSERT INTO CATEGORY VALUES(-10,'Mozgás');
INSERT INTO CATEGORY VALUES(-11,'Táskák');
INSERT INTO CATEGORY VALUES(-12,'Ékszerek');
INSERT INTO CATEGORY VALUES(-13,'Hangszerek');
INSERT INTO CATEGORY VALUES(-14,'Játékok');
INSERT INTO CATEGORY VALUES(-15,'Filmek,sorozatok');
INSERT INTO CATEGORY VALUES(-16,'Fényképezők');

INSERT INTO CAT_TO_PROD VALUES(-1, -5);
INSERT INTO CAT_TO_PROD VALUES(-2, -1);
INSERT INTO CAT_TO_PROD VALUES(-3, -1);
INSERT INTO CAT_TO_PROD VALUES(-4, -1);
INSERT INTO CAT_TO_PROD VALUES(-5, -5);
INSERT INTO CAT_TO_PROD VALUES(-6, -1);
INSERT INTO CAT_TO_PROD VALUES(-7, -1);
INSERT INTO CAT_TO_PROD VALUES(-8, -5);
INSERT INTO CAT_TO_PROD VALUES(-9, -2);
INSERT INTO CAT_TO_PROD VALUES(-10, -2);
INSERT INTO CAT_TO_PROD VALUES(-11, -2);
INSERT INTO CAT_TO_PROD VALUES(-12, -3);
INSERT INTO CAT_TO_PROD VALUES(-13, -3);
INSERT INTO CAT_TO_PROD VALUES(-14, -16);
INSERT INTO CAT_TO_PROD VALUES(-15, -4);
INSERT INTO CAT_TO_PROD VALUES(-16, -7);
INSERT INTO CAT_TO_PROD VALUES(-17, -4);
INSERT INTO CAT_TO_PROD VALUES(-18, -8);
INSERT INTO CAT_TO_PROD VALUES(-19, -4);
INSERT INTO CAT_TO_PROD VALUES(-20, -6);
INSERT INTO CAT_TO_PROD VALUES(-21, -6);
INSERT INTO CAT_TO_PROD VALUES(-22, -6);
INSERT INTO CAT_TO_PROD VALUES(-23, -9);
INSERT INTO CAT_TO_PROD VALUES(-24, -9);
INSERT INTO CAT_TO_PROD VALUES(-25, -9);
INSERT INTO CAT_TO_PROD VALUES(-26, -10);
INSERT INTO CAT_TO_PROD VALUES(-27, -10);
INSERT INTO CAT_TO_PROD VALUES(-28, -10);
INSERT INTO CAT_TO_PROD VALUES(-29, -11);
INSERT INTO CAT_TO_PROD VALUES(-31, -12);
INSERT INTO CAT_TO_PROD VALUES(-32, -12);
INSERT INTO CAT_TO_PROD VALUES(-33, -5);
INSERT INTO CAT_TO_PROD VALUES(-34, -13);
INSERT INTO CAT_TO_PROD VALUES(-35, -13);
INSERT INTO CAT_TO_PROD VALUES(-36, -13);
INSERT INTO CAT_TO_PROD VALUES(-37, -14);
INSERT INTO CAT_TO_PROD VALUES(-38, -14);
INSERT INTO CAT_TO_PROD VALUES(-39, -14);
INSERT INTO CAT_TO_PROD VALUES(-40, -14);
INSERT INTO CAT_TO_PROD VALUES(-41, -15);
INSERT INTO CAT_TO_PROD VALUES(-42, -15);
INSERT INTO CAT_TO_PROD VALUES(-43, -15);
INSERT INTO CAT_TO_PROD VALUES(-44, -15);
INSERT INTO CAT_TO_PROD VALUES(-45, -15);

INSERT INTO TAG VALUES(-1,'pulóver');
INSERT INTO TAG VALUES(-2,'nadrág');
INSERT INTO TAG VALUES(-3,'csizma');
INSERT INTO TAG VALUES(-4,'edzőcipő');
INSERT INTO TAG VALUES(-5,'karkötő');
INSERT INTO TAG VALUES(-6,'nyaklánc');
INSERT INTO TAG VALUES(-7,'fülbevaló');
INSERT INTO TAG VALUES(-8,'gyűrű');
INSERT INTO TAG VALUES(-9,'mozifilm');
INSERT INTO TAG VALUES(-10,'sorozat');
INSERT INTO TAG VALUES(-11,'vígjáték');
INSERT INTO TAG VALUES(-12,'romantikus');
INSERT INTO TAG VALUES(-13,'sitcom');
INSERT INTO TAG VALUES(-14,'dráma');
INSERT INTO TAG VALUES(-15,'akció');
INSERT INTO TAG VALUES(-16,'sci-fi');
INSERT INTO TAG VALUES(-17,'fantasy');
INSERT INTO TAG VALUES(-18,'kosztümös');

INSERT INTO PROD_TO_TAG VALUES(-2,-1);
INSERT INTO PROD_TO_TAG VALUES(-7,-1);
INSERT INTO PROD_TO_TAG VALUES(-3,-2);
INSERT INTO PROD_TO_TAG VALUES(-33,-3);
INSERT INTO PROD_TO_TAG VALUES(-1,-4);
INSERT INTO PROD_TO_TAG VALUES(-5,-4);
INSERT INTO PROD_TO_TAG VALUES(-8,-4);
INSERT INTO PROD_TO_TAG VALUES(-31,-5);
INSERT INTO PROD_TO_TAG VALUES(-32,-5);
INSERT INTO PROD_TO_TAG VALUES(-41,-9);
INSERT INTO PROD_TO_TAG VALUES(-42,-9);
INSERT INTO PROD_TO_TAG VALUES(-43,-10);
INSERT INTO PROD_TO_TAG VALUES(-44,-10);
INSERT INTO PROD_TO_TAG VALUES(-45,-10);
INSERT INTO PROD_TO_TAG VALUES(-41,-11);
INSERT INTO PROD_TO_TAG VALUES(-42,-11);
INSERT INTO PROD_TO_TAG VALUES(-42,-12);
INSERT INTO PROD_TO_TAG VALUES(-44,-13);
INSERT INTO PROD_TO_TAG VALUES(-45,-13);
INSERT INTO PROD_TO_TAG VALUES(-43,-18);


COMMIT;
