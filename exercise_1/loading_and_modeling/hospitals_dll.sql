DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE hospitals(
        provider_id STRING, 
        hosp_name STRING,
        address STRING,
        city STRING,
        state STRING, 
        zip STRING,
        county STRING,
        phone STRING,
        type STRING,
        ownership STRING,
        emerg_serv STRING)
COMMENT 'from /user/w205/hospital_compare/hospitals/hospitals.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
 "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';