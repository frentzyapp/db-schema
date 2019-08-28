-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;

-- ************************************** "Province"
CREATE TABLE "Province"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "province" varchar(30) NOT NULL
);

CREATE UNIQUE INDEX "PK_Province" ON "Province"
(
 "id"
);

-- ************************************** "Address"

CREATE TABLE "Address"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "address1"   varchar(50) NOT NULL,
 "addres2"    varchar(50) NULL,
 "city"       varchar(50) NOT NULL,
 "provinceid" int NOT NULL,
 "postalcode" varchar(7) NOT NULL,
 CONSTRAINT "FK_43" FOREIGN KEY ( "provinceid" ) REFERENCES "Province" ( "id" )
);

CREATE UNIQUE INDEX "PK_Address" ON "Address"
(
 "id"
);

CREATE INDEX "fkIdx_43" ON "Address"
(
 "provinceid"
);

-- ************************************** "UserActive"

CREATE TABLE "UserActive"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "islocked" boolean NOT NULL

);

CREATE UNIQUE INDEX "PK_UserActive" ON "UserActive"
(
 "id"
);


-- ************************************** "UserProfile"

CREATE TABLE "UserProfile"
(
 "id"          int GENERATED ALWAYS AS IDENTITY,
 "description" text NOT NULL,
 "profilepic"  varchar(50) NOT NULL

);

CREATE UNIQUE INDEX "PK_UserDescription" ON "UserProfile"
(
 "id"
);


-- ************************************** "Category"

CREATE TABLE "Category"
(
 "id"   int GENERATED ALWAYS AS IDENTITY,
 "name" varchar(50) NOT NULL

);

CREATE UNIQUE INDEX "PK_Category" ON "Category"
(
 "id"
);


-- ************************************** "Subcategory"

CREATE TABLE "Subcategory"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "name"       varchar(50) NOT NULL,
 "categoryid" int NOT NULL,
 CONSTRAINT "FK_141" FOREIGN KEY ( "categoryid" ) REFERENCES "Category" ( "id" )
);

CREATE UNIQUE INDEX "PK_Subcategory" ON "Subcategory"
(
 "id"
);

CREATE INDEX "fkIdx_141" ON "Subcategory"
(
 "categoryid"
);


-- ************************************** "Item"

CREATE TABLE "Item"
(
 "id"           int GENERATED ALWAYS AS IDENTITY,
 "name"         varchar(50) NOT NULL,
 "description"  text NOT NULL,
 "inventoryid"  int NOT NULL,
 "rate"         decimal NOT NULL,
 "availability" boolean NOT NULL,
 "categoryid"   int NOT NULL,
 "imgurl"       text NULL,
 CONSTRAINT "FK_134" FOREIGN KEY ( "categoryid" ) REFERENCES "Category" ( "id" )
);

CREATE UNIQUE INDEX "PK_Item" ON "Item"
(
 "id"
);

CREATE INDEX "fkIdx_134" ON "Item"
(
 "categoryid"
);


-- ************************************** "Login"

CREATE TABLE "Login"
(
 "password" varchar(50) NOT NULL,
 "id"       int GENERATED ALWAYS AS IDENTITY

);

CREATE UNIQUE INDEX "PK_Login" ON "Login"
(
 "id"
);


-- ************************************** "User"

CREATE TABLE "User"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "addressid"  int NOT NULL,
 "email"      varchar(50) UNIQUE NOT NULL,
 "firstname"  varchar(50) NOT NULL,
 "lastname"   varchar(50) NOT NULL,
 "verified"   boolean NOT NULL,
 "lastactive" date NOT NULL,
 "createdate" date NOT NULL,
 "profileid"  int NOT NULL,
 "loginid"    int NOT NULL,
 "activeid"   int NOT NULL,
 CONSTRAINT "FK_153" FOREIGN KEY ( "activeid" ) REFERENCES "UserActive" ( "id" ),
 CONSTRAINT "FK_35" FOREIGN KEY ( "addressid" ) REFERENCES "Address" ( "id" ),
 CONSTRAINT "FK_67" FOREIGN KEY ( "profileid" ) REFERENCES "UserProfile" ( "id" ),
 CONSTRAINT "FK_70" FOREIGN KEY ( "loginid" ) REFERENCES "Login" ( "id" )
);

CREATE UNIQUE INDEX "PK_User" ON "User"
(
 "id"
);

CREATE INDEX "fkIdx_153" ON "User"
(
 "activeid"
);

CREATE INDEX "fkIdx_35" ON "User"
(
 "addressid"
);

CREATE INDEX "fkIdx_67" ON "User"
(
 "profileid"
);

CREATE INDEX "fkIdx_70" ON "User"
(
 "loginid"
);


-- ************************************** "Inventory"

CREATE TABLE "Inventory"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "userid"   int NOT NULL,
 "itemid"   int NOT NULL,
 "quantity" int NOT NULL,
 CONSTRAINT "FK_89" FOREIGN KEY ( "userid" ) REFERENCES "User" ( "id" ),
 CONSTRAINT "FK_97" FOREIGN KEY ( "itemid" ) REFERENCES "Item" ( "id" )
);

CREATE UNIQUE INDEX "PK_Inventory" ON "Inventory"
(
 "id"
);

CREATE INDEX "fkIdx_89" ON "Inventory"
(
 "userid"
);

CREATE INDEX "fkIdx_97" ON "Inventory"
(
 "itemid"
);


-- ************************************** "Rental"

CREATE TABLE "Rental"
(
 "id"                 int GENERATED ALWAYS AS IDENTITY,
 "userid"             int NOT NULL,
 "itemid"             int NOT NULL,
 "checkoutdate"       date NOT NULL,
 "expectedreturndate" date NOT NULL,
 "returndate"         date NULL,
 CONSTRAINT "FK_103" FOREIGN KEY ( "itemid" ) REFERENCES "Item" ( "id" ),
 CONSTRAINT "FK_106" FOREIGN KEY ( "userid" ) REFERENCES "User" ( "id" )
);

CREATE UNIQUE INDEX "PK_Rental" ON "Rental"
(
 "id"
);

CREATE INDEX "fkIdx_103" ON "Rental"
(
 "itemid"
);

CREATE INDEX "fkIdx_106" ON "Rental"
(
 "userid"
);


-- ************************************** "UserRating"

CREATE TABLE "UserRating"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "rating"     int NOT NULL,
 "review"     text NULL,
 "userid"     int NOT NULL,
 "rentalid"   int NOT NULL,
 "reviewdate" date NOT NULL,
 CONSTRAINT "FK_121" FOREIGN KEY ( "userid" ) REFERENCES "User" ( "id" ),
 CONSTRAINT "FK_125" FOREIGN KEY ( "rentalid" ) REFERENCES "Rental" ( "id" )
);

CREATE UNIQUE INDEX "PK_UserRating" ON "UserRating"
(
 "id"
);

CREATE INDEX "fkIdx_121" ON "UserRating"
(
 "userid"
);

CREATE INDEX "fkIdx_125" ON "UserRating"
(
 "rentalid"
);
