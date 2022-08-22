CREATE TABLE "org" (
	"object_id" INT NOT NULL,
	"inn" VARCHAR2(12) NOT NULL,
	"phone" NUMBER(10, 0) NOT NULL,
	"org_name" VARCHAR2(150) NOT NULL,
	"status_id" INT NOT NULL,
	"tarif_id" INT NOT NULL,
	"big" CHAR(1) CHECK ("big" IN ('N','Y')) NOT NULL,
	"business_id" INT NOT NULL,
	"place_id" INT NOT NULL,
	constraint ORG_PK PRIMARY KEY ("object_id"));

CREATE sequence "ORG_OBJECT_ID_SEQ";

CREATE trigger "BI_ORG_OBJECT_ID"
  before insert on "org"
  for each row
begin
  select "ORG_OBJECT_ID_SEQ".nextval into :NEW."object_id" from dual;
end;
CREATE sequence "ORG_PHONE_SEQ";

CREATE trigger "BI_ORG_PHONE"
  before insert on "org"
  for each row
begin
  select "ORG_PHONE_SEQ".nextval into :NEW."phone" from dual;
end;

/
CREATE TABLE "representative" (
	"object_id" INT NOT NULL,
	"email" VARCHAR2(50) NOT NULL,
	"confirmed" CHAR(1) CHECK ("confirmed" IN ('N','Y')) NOT NULL,
	"password" VARCHAR2(200) NOT NULL,
	"name" VARCHAR2(50) NOT NULL,
	"middleName" VARCHAR2(50) NOT NULL,
	"surname" VARCHAR2(50) NOT NULL,
	"org_id" INT NOT NULL,
	constraint REPRESENTATIVE_PK PRIMARY KEY ("object_id"));

CREATE sequence "REPRESENTATIVE_OBJECT_ID_SEQ";

CREATE trigger "BI_REPRESENTATIVE_OBJECT_ID"
  before insert on "representative"
  for each row
begin
  select "REPRESENTATIVE_OBJECT_ID_SEQ".nextval into :NEW."object_id" from dual;
end;

/
CREATE TABLE "place" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(150) NOT NULL,
	"sity_id" INT NOT NULL,
	"street_id" INT NOT NULL,
	"house_id" INT NOT NULL,
	"id_keeper" VARCHAR2(36) NOT NULL,
	"image" VARCHAR2(500) NOT NULL,
	"rating" INT NOT NULL,
	"table_id" INT NOT NULL,
	"status" INT NOT NULL,
	"kitchen_id" INT NOT NULL,
	"work_shedule_id" INT NOT NULL);


/
CREATE TABLE "city" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	constraint CITY_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "streets" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	constraint STREETS_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "house" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	constraint HOUSE_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "table" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"id_keeper" VARCHAR2(38) NOT NULL,
	"date_time" TIMESTAMP NOT NULL,
	"is_avalable" CHAR(1) CHECK ("is_avalable" IN ('N','Y')) NOT NULL DEFAULT "Y",
	"zal_id" INT NOT NULL,
	constraint TABLE_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "zal" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	constraint ZAL_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "tarif" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"comission" DECIMAL NOT NULL,
	"standart" CHAR(1) CHECK ("standart" IN ('N','Y')) NOT NULL,
	"standart_id" INT NOT NULL,
	"discount_id" INT NOT NULL,
	constraint TARIF_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "tarif_standart" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"oborot_ot" DECIMAL NOT NULL,
	"oborot_do" DECIMAL NOT NULL,
	constraint TARIF_STANDART_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "tarif_individual" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"discount" INT NOT NULL,
	constraint TARIF_INDIVIDUAL_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "guest" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"email" VARCHAR2(50) NOT NULL,
	"confirmed_m" CHAR(1) CHECK ("confirmed_m" IN ('N','Y')) NOT NULL,
	"confirmed_t" CHAR(1) CHECK ("confirmed_t" IN ('N','Y')) NOT NULL,
	"phone" NUMBER(10, 0) NOT NULL,
	"booking_id" INT NOT NULL,
	constraint GUEST_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "booking" (
	"object_id" INT NOT NULL,
	"place_id" INT NOT NULL,
	"table_id" INT NOT NULL,
	"guest_id" INT NOT NULL,
	"date_time" TIMESTAMP NOT NULL,
	"guest_guantity" INT NOT NULL,
	"state" INT NOT NULL,
	constraint BOOKING_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "kitchen" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	constraint KITCHEN_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "work_day" (
	"object_id" INT NOT NULL,
	"week_day" INT NOT NULL,
	"begin_time" TIMESTAMP NOT NULL,
	"clouse_time" TIMESTAMP NOT NULL,
	constraint WORK_DAY_PK PRIMARY KEY ("object_id"));


/
CREATE TABLE "work_shedule" (
	"object_id" INT NOT NULL,
	"name" VARCHAR2(100) NOT NULL,
	"work_day_id" INT NOT NULL,
	constraint WORK_SHEDULE_PK PRIMARY KEY ("object_id"));


/
ALTER TABLE "org" ADD CONSTRAINT "org_fk0" FOREIGN KEY ("tarif_id") REFERENCES "tarif"("object_id");
ALTER TABLE "org" ADD CONSTRAINT "org_fk1" FOREIGN KEY ("place_id") REFERENCES "place"("object_id");

ALTER TABLE "representative" ADD CONSTRAINT "representative_fk0" FOREIGN KEY ("org_id") REFERENCES "org"("object_id");

ALTER TABLE "place" ADD CONSTRAINT "place_fk0" FOREIGN KEY ("sity_id") REFERENCES "city"("object_id");
ALTER TABLE "place" ADD CONSTRAINT "place_fk1" FOREIGN KEY ("street_id") REFERENCES "streets"("object_id");
ALTER TABLE "place" ADD CONSTRAINT "place_fk2" FOREIGN KEY ("house_id") REFERENCES "house"("object_id");
ALTER TABLE "place" ADD CONSTRAINT "place_fk3" FOREIGN KEY ("table_id") REFERENCES "table"("object_id");
ALTER TABLE "place" ADD CONSTRAINT "place_fk4" FOREIGN KEY ("kitchen_id") REFERENCES "kitchen"("object_id");
ALTER TABLE "place" ADD CONSTRAINT "place_fk5" FOREIGN KEY ("work_shedule_id") REFERENCES "work_shedule"("object_id");




ALTER TABLE "table" ADD CONSTRAINT "table_fk0" FOREIGN KEY ("zal_id") REFERENCES "zal"("object_id");


ALTER TABLE "tarif" ADD CONSTRAINT "tarif_fk0" FOREIGN KEY ("standart_id") REFERENCES "tarif_standart"("object_id");
ALTER TABLE "tarif" ADD CONSTRAINT "tarif_fk1" FOREIGN KEY ("discount_id") REFERENCES "tarif_individual"("object_id");




ALTER TABLE "booking" ADD CONSTRAINT "booking_fk0" FOREIGN KEY ("place_id") REFERENCES "place"("object_id");
ALTER TABLE "booking" ADD CONSTRAINT "booking_fk1" FOREIGN KEY ("table_id") REFERENCES "table"("object_id");
ALTER TABLE "booking" ADD CONSTRAINT "booking_fk2" FOREIGN KEY ("guest_id") REFERENCES "guest"("object_id");



ALTER TABLE "work_shedule" ADD CONSTRAINT "work_shedule_fk0" FOREIGN KEY ("work_day_id") REFERENCES "work_day"("object_id");

