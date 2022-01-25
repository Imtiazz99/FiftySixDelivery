--------------------------------------------------------
--  File created - Saturday-February-06-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table MENU
--------------------------------------------------------

  CREATE TABLE "HENSHIN"."MENU" 
   (	"MENU_ID" NUMBER, 
	"MENU_NAME" VARCHAR2(30 BYTE), 
	"MENU_PRICE" FLOAT(126), 
	"MENU_DESCRIPTION" VARCHAR2(150 BYTE), 
	"MENU_QUANTITY" NUMBER, 
	"MENU_IMAGE" VARCHAR2(20 BYTE), 
	"CATEGORY_ID" NUMBER, 
	"IMAGE" BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 LOB ("IMAGE") STORE AS BASICFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
REM INSERTING into HENSHIN.MENU
SET DEFINE OFF;
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (1,'Chocolate Cake',150,'Chocolate cake topped with chocolate ganache, strawberries and pomegranate.',5,'cake1.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (2,'Chocolate Lemon Cake',45,'A great combination of chocolate and lemon that will shock whonever eat it, a verry tasty cake.',5,'cake2.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (3,'Pandan Gula Melaka',45,'Pandan and Gula Melaka origin from Melaka with a delicious taste.',5,'cake3.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (4,'Nepolitan Cake',45,'with a bit of our own touch! - homemade strawberry compote.',5,'cake5.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (5,'Victoria Sandwich Cake',45,'with our homemade strawberry compote.',5,'cake6.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (6,'Sirap Bandung Cake',45,'with a high grade of sirap with greate taste.',5,'sirap.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (7,'Cupcake',45,'Rich, creamy bite sized dessert. Small, cute and fancy at the same time.',20,'cupcake.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (8,'Red Velvet Cupcake',45,'Vibrant, sof and topped with cream cheese frosting.',20,'cupcake1.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (9,'Pavlova Cupcake',45,'Crisp crust and soft, light inside, topped with fruit and whipped cream.',20,'cupcake2.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (10,'Chocolate Cupcake',45,'Super moist chocolate cupcake with chocolate buttercream frosting.',20,'cupcake3.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (11,'Cream Puff',45,'Light and delicate cream puff filling with custard, garnished with chocolate sauce and powdered sugar.',50,'dessert.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (12,'Macaron Tower',45,'A delicate meringue-based cookies sandwich in tower.',5,'dessert1.JPG',2);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (13,'Biscoff',45,'A creamy cheesecake with a airy, mousse-like texture that screams Lotus in every bite.',15,'dessert2.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (14,'Churros With Chocolate',45,'Fried dough dip with chocolate sauce.',50,'dessert3.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (15,'Cheese Tart With Berries',45,'Combination of cream cheese, whipping cream and evaporated milk topped with fresh berries.',20,'dessert4.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (16,'Biscoff Cream Puff',45,'Our signature cream puff with Biscoff icing.',20,'dessert5.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (17,'Chocolate Cookies',45,'Crispy on the outside, soft and chewy inside, baked with premium chocolate chips. ',20,'cookies.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (18,'Red Velvet Cookies',45,'Mix with white chocolate chips.',20,'cookies1.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (19,'Coffee Cookies',45,'Classic chewy cookies but laced with a hint of rich coffee flavor from freshly brewed coffee.',15,'cookies2.JPG',1);
Insert into HENSHIN.MENU (MENU_ID,MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID) values (20,'White Chocolate Cookies',45,'Soft, chewy and packed full of white chocolate chips.',15,'cookies3.JPG',1);
--------------------------------------------------------
--  DDL for Index MENU_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HENSHIN"."MENU_PK" ON "HENSHIN"."MENU" ("MENU_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MENU
--------------------------------------------------------

  ALTER TABLE "HENSHIN"."MENU" MODIFY ("MENU_NAME" NOT NULL ENABLE);
  ALTER TABLE "HENSHIN"."MENU" MODIFY ("MENU_ID" NOT NULL ENABLE);
  ALTER TABLE "HENSHIN"."MENU" ADD CONSTRAINT "MENU_PK" PRIMARY KEY ("MENU_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
