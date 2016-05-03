
/* Script to set-up an addressbase gazetteer, index appropriately and create a single-line address view in sqlite. */

/*START ADDRESSBASE TABLE*/
-- main data table for addressbase to be imported into.

CREATE TABLE addressbase (
UPRN bigint NOT NULL,
OS_ADDRESS_TOID varchar,
UDPRN bigint,
ORGANISATION_NAME varchar,
DEPARTMENT_NAME varchar,
PO_BOX_NUMBER varchar,
SUB_BUILDING_NAME varchar,
BUILDING_NAME varchar,
BUILDING_NUMBER varchar,
DEPENDENT_THOROUGHFARE varchar,
THOROUGHFARE varchar,
POST_TOWN varchar,
DOUBLE_DEPENDENT_LOCALITY varchar,
DEPENDENT_LOCALITY varchar,
POSTCODE varchar,
POSTCODE_TYPE varchar,
X_COORDINATE numeric,
Y_COORDINATE numeric,
LATITUDE numeric,
LONGITUDE numeric,
RPC integer,
COUNTRY varchar,
CHANGE_TYPE varchar,
LA_START_DATE Date,
RM_START_DATE Date,
LAST_UPDATE_DATE Date,
CLASS varchar);

/* END ADDRESSBASE TABLE */

/*START ADDRESSBASE INDICES */
-- index of all relevant columns on the addressbase table in preperation for creating the lookup view.

CREATE  INDEX "main"."addressbase_single_address" ON "addressbase" (
"UPRN" ASC,
"ORGANISATION_NAME" ASC,
"DEPARTMENT_NAME" ASC,
"PO_BOX_NUMBER" ASC,
"SUB_BUILDING_NAME" ASC,
"BUILDING_NAME" ASC,
"BUILDING_NUMBER" ASC,
"DEPENDENT_THOROUGHFARE" ASC,
"THOROUGHFARE" ASC,
"POST_TOWN" ASC,
"DOUBLE_DEPENDENT_LOCALITY" ASC,
"DEPENDENT_LOCALITY" ASC,
"POSTCODE" ASC,
"LATITUDE" ASC,
"LONGITUDE" ASC
);

/*END ADDRESSBASE INDICES */


/* CREATE SINGLE ADDRESS LOOKUP VIEW */
-- creates a view comprising UPRN, LAT, LONG, and a single line address field.

CREATE VIEW "vlookup" AS SELECT uprn, latitude, longitude,
(
CASE WHEN department_name <> '' THEN department_name || ', ' ELSE '' END
|| CASE WHEN organisation_name <> '' THEN organisation_name || ', ' ELSE '' END
|| CASE WHEN sub_building_name <> '' THEN sub_building_name || ', ' ELSE '' END
|| CASE WHEN building_name <> '' THEN building_name || ', ' ELSE '' END
|| CASE WHEN building_number IS NOT NULL THEN building_number || ' ' ELSE '' END
|| CASE WHEN po_box_number <> '' THEN 'PO BOX ' || po_box_number || ', ' ELSE '' END
|| CASE WHEN dependent_thoroughfare <> '' THEN dependent_thoroughfare || ', ' ELSE '' END || CASE WHEN thoroughfare <> '' THEN thoroughfare || ', ' ELSE '' END
|| CASE WHEN double_dependent_locality <> '' THEN double_dependent_locality || ', ' ELSE '' END
|| CASE WHEN dependent_locality <> '' THEN dependent_locality || ', ' ELSE '' END
|| CASE WHEN post_town <> '' THEN post_town || ', ' ELSE '' END
|| postcode
) AS address_label
FROM addressbase;

/* END SINGLE ADDRESS LOOKUP VIEW */
