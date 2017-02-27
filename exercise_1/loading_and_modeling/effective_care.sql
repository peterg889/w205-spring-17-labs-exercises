DROP TABLE IF EXISTS effective_care;
CREATE EXTERNAL TABLE effective_care(
        provider_id STRING, 
        hosp_name STRING,
        address STRING,
        city STRING,
        state STRING, 
        zip STRING,
        county STRING,
        phone STRING,
        condition STRING,
        measure_id STRING,
        measure_name STRING,
        score STRING,
        sample STRING,
        footnote STRING,
        start_date DATE,
        end_date DATE)
COMMENT 'from /user/w205/hospital_compare/effective_care/effective_care.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
 "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';