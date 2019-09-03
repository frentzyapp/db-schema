-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;

-- ************************************** "province"
CREATE TABLE "province"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "province" varchar(2) NOT NULL
);

CREATE UNIQUE INDEX "PK_Province" ON "province"
(
 "id"
);


-- ************************************** "address"

CREATE TABLE "address"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "address1"   varchar(50) NOT NULL,
 "address2"   varchar(50) NULL,
 "city"       varchar(50) NOT NULL,
 "provinceid" int NOT NULL,
 "postalcode" varchar(7) NOT NULL,
 CONSTRAINT "FK_43" FOREIGN KEY ( "provinceid" ) REFERENCES "province" ( "id" )
);

CREATE UNIQUE INDEX "PK_Address" ON "address"
(
 "id"
);

CREATE INDEX "fkIdx_43" ON "address"
(
 "provinceid"
);

-- ************************************** "activeStatus"

CREATE TABLE "activeStatus"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "status"   varchar(50)

);

CREATE UNIQUE INDEX "PK_activeStatus" ON "activeStatus"
(
 "id"
);


-- ************************************** "userProfile"

CREATE TABLE "userProfile"
(
 "id"          int GENERATED ALWAYS AS IDENTITY,
 "description" text NOT NULL,
 "profilepic"  varchar(50)

);

CREATE UNIQUE INDEX "PK_userDescription" ON "userProfile"
(
 "id"
);


-- ************************************** "category"

CREATE TABLE "category"
(
 "id"   int GENERATED ALWAYS AS IDENTITY,
 "name" varchar(50) NOT NULL

);

CREATE UNIQUE INDEX "PK_category" ON "category"
(
 "id"
);


-- ************************************** "subcategory"

CREATE TABLE "subcategory"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "name"       varchar(50) NOT NULL,
 "categoryid" int NOT NULL,
 CONSTRAINT "FK_141" FOREIGN KEY ( "categoryid" ) REFERENCES "category" ( "id" )
);

CREATE UNIQUE INDEX "PK_Subcategory" ON "subcategory"
(
 "id"
);

CREATE INDEX "fkIdx_141" ON "subcategory"
(
 "categoryid"
);


-- ************************************** "item"

CREATE TABLE "item"
(
 "id"           int GENERATED ALWAYS AS IDENTITY,
 "name"         varchar(50) NOT NULL,
 "description"  text NOT NULL,
 "dailyrate"    decimal NOT NULL,
 "availability" boolean NOT NULL,
 "categoryid"   int NOT NULL,
 "imgurl"       text NULL,
 CONSTRAINT "FK_134" FOREIGN KEY ( "categoryid" ) REFERENCES "category" ( "id" )
);

CREATE UNIQUE INDEX "PK_Item" ON "item"
(
 "id"
);

CREATE INDEX "fkIdx_134" ON "item"
(
 "categoryid"
);


-- ************************************** "login"

CREATE TABLE "login"
(
  "id"       int GENERATED ALWAYS AS IDENTITY,
  "password" varchar(50) NOT NULL
);

CREATE UNIQUE INDEX "PK_Login" ON "login"
(
 "id"
);


-- ************************************** "user"

CREATE TABLE "user"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "addressid"  int NOT NULL,
 "email"      varchar(50) UNIQUE NOT NULL,
 "firstname"  varchar(50) NOT NULL,
 "lastname"   varchar(50) NOT NULL,
 "verified"   boolean NOT NULL,
 "lastactive" date NOT NULL DEFAULT now(),
 "createdate" date NOT NULL DEFAULT now(),
 "profileid"  int NOT NULL,
 "loginid"    int NOT NULL,
 "activestatusid"   int NOT NULL DEFAULT 1,
 CONSTRAINT "FK_153" FOREIGN KEY ( "activestatusid" ) REFERENCES "activeStatus" ( "id" ),
 CONSTRAINT "FK_35" FOREIGN KEY ( "addressid" ) REFERENCES "address" ( "id" ),
 CONSTRAINT "FK_67" FOREIGN KEY ( "profileid" ) REFERENCES "userProfile" ( "id" ),
 CONSTRAINT "FK_70" FOREIGN KEY ( "loginid" ) REFERENCES "login" ( "id" )
);

CREATE UNIQUE INDEX "PK_User" ON "user"
(
 "id"
);

CREATE INDEX "fkIdx_153" ON "user"
(
 "activestatusid"
);

CREATE INDEX "fkIdx_35" ON "user"
(
 "addressid"
);

CREATE INDEX "fkIdx_67" ON "user"
(
 "profileid"
);

CREATE INDEX "fkIdx_70" ON "user"
(
 "loginid"
);


-- ************************************** "inventory"

CREATE TABLE "inventory"
(
 "id"       int GENERATED ALWAYS AS IDENTITY,
 "userid"   int NOT NULL,
 "itemid"   int NOT NULL,
 "quantity" int NOT NULL,
 CONSTRAINT "FK_89" FOREIGN KEY ( "userid" ) REFERENCES "user" ( "id" ),
 CONSTRAINT "FK_97" FOREIGN KEY ( "itemid" ) REFERENCES "item" ( "id" )
);

CREATE UNIQUE INDEX "PK_Inventory" ON "inventory"
(
 "id"
);

CREATE INDEX "fkIdx_89" ON "inventory"
(
 "userid"
);

CREATE INDEX "fkIdx_97" ON "inventory"
(
 "itemid"
);


-- ************************************** "rental"

CREATE TABLE "rental"
(
 "id"                 int GENERATED ALWAYS AS IDENTITY,
 "userid"             int NOT NULL,
 "itemid"             int NOT NULL,
 "checkoutdate"       date NOT NULL,
 "expectedreturndate" date NOT NULL,
 "returndate"         date NULL,
 CONSTRAINT "FK_103" FOREIGN KEY ( "itemid" ) REFERENCES "item" ( "id" ),
 CONSTRAINT "FK_106" FOREIGN KEY ( "userid" ) REFERENCES "user" ( "id" )
);

CREATE UNIQUE INDEX "PK_Rental" ON "rental"
(
 "id"
);

CREATE INDEX "fkIdx_103" ON "rental"
(
 "itemid"
);

CREATE INDEX "fkIdx_106" ON "rental"
(
 "userid"
);


-- ************************************** "userRating"

CREATE TABLE "userRating"
(
 "id"         int GENERATED ALWAYS AS IDENTITY,
 "rating"     int NOT NULL,
 "review"     text NULL,
 "userid"     int NOT NULL,
 "rentalid"   int NOT NULL,
 "reviewdate" date NOT NULL,
 CONSTRAINT "FK_121" FOREIGN KEY ( "userid" ) REFERENCES "user" ( "id" ),
 CONSTRAINT "FK_125" FOREIGN KEY ( "rentalid" ) REFERENCES "rental" ( "id" )
);

CREATE UNIQUE INDEX "PK_UserRating" ON "userRating"
(
 "id"
);

CREATE INDEX "fkIdx_121" ON "userRating"
(
 "userid"
);

CREATE INDEX "fkIdx_125" ON "userRating"
(
 "rentalid"
);


--****
--DATA
--****

-- ********************************* "province Data"

INSERT INTO public."province" (province) VALUES('AB'),
('BC'),
('SK'),
('MB'),
('NB'),
('NL'),
('NS'),
('NT'),
('NU'),
('ON'),
('PE'),
('QC'),
('YT');


-- ********************************* "activeStatus Data"

INSERT INTO "activeStatus" ("status") VALUES ('Active'), ('Locked'), ('Banned');