-- create RPAD table that is run through Geoclient
DROP TABLE IF EXISTS pluto_rpad_geo;
CREATE TABLE pluto_rpad_geo AS (
SELECT a.*,
	(CASE
		WHEN a.boro = '1' THEN 'Manhattan'
		WHEN a.boro = '2' THEN 'Bronx'
		WHEN a.boro = '3' THEN 'Brooklyn'
		WHEN a.boro = '4' THEN 'Queens'
		WHEN a.boro = '5' THEN 'Staten Island'
		ELSE NULL
	END) AS borough
FROM pluto_rpad a
);

ALTER TABLE pluto_rpad_geo
ADD COLUMN bbl text,
ADD COLUMN billingbbl text,
ADD COLUMN giHighHouseNumber1 text,
ADD COLUMN giStreetName1 text,
ADD COLUMN boePreferredStreetName text,
ADD COLUMN buildingIdentificationNumber text,
ADD COLUMN numberOfExistingStructuresOnLot text,
ADD COLUMN cd text,
ADD COLUMN ct2010 text,
ADD COLUMN cb2010 text,
ADD COLUMN schooldist text,
ADD COLUMN council text,
ADD COLUMN zipcode text,
ADD COLUMN firecomp text,
ADD COLUMN policeprct text,
ADD COLUMN healthcenterdistrict text,
ADD COLUMN healtharea text,	
ADD COLUMN sanitboro text,
ADD COLUMN sanitdistrict text,
ADD COLUMN sanitsub text,
ADD COLUMN billingblock text,
ADD COLUMN billinglot text,
ADD COLUMN primebbl text,
ADD COLUMN ap_datef text,
ADD COLUMN geom geometry;

UPDATE pluto_rpad_geo
SET housenum_lo = NULL
WHERE housenum_lo = ' ';

UPDATE pluto_rpad_geo
SET street_name = NULL
WHERE street_name = ' ';

-- using seprate pluto_input_geocodes from mainframe processing as input
DROP TABLE IF EXISTS pluto_rpad_geo;
CREATE TABLE pluto_rpad_geo AS (
SELECT a.*, b.*
FROM pluto_rpad a
LEFT JOIN pluto_input_geocodes b
ON a.boro||a.tb||a.tl=b.borough||lpad(b.block,5,'0')||lpad(b.lot,4,'0')
);


ALTER TABLE pluto_rpad_geo 
RENAME communitydistrict TO cd;
ALTER TABLE pluto_rpad_geo 
RENAME censustract2010 TO ct2010;
ALTER TABLE pluto_rpad_geo 
RENAME censusblock2010 TO cb2010;
ALTER TABLE pluto_rpad_geo 
RENAME communityschooldistrict TO schooldist;
ALTER TABLE pluto_rpad_geo 
RENAME citycouncildistrict TO council;
ALTER TABLE pluto_rpad_geo 
RENAME firecompanynumber TO firecomp;
ALTER TABLE pluto_rpad_geo 
RENAME policeprecinct TO policeprct;
ALTER TABLE pluto_rpad_geo 
RENAME sanitationdistrict TO sanitdistrict;
ALTER TABLE pluto_rpad_geo 
RENAME numberofexistingstructures TO numberOfExistingStructuresOnLot;
ALTER TABLE pluto_rpad_geo 
RENAME sanitationcollectionscheduling TO sanitsub;
ALTER TABLE pluto_rpad_geo 
ADD bbl text;
ALTER TABLE pluto_rpad_geo 
ADD primebbl text;
ALTER TABLE pluto_rpad_geo 
ADD ap_datef text;
UPDATE pluto_rpad_geo
SET bbl = borough||lpad(block,5,'0')||lpad(lot,4,'0');
