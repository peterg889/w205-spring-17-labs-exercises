DROP TABLE IF EXISTS readmissions;
CREATE EXTERNAL TABLE readmissions(
        provider_id STRING, 
        hosp_name STRING,
        address STRING,
        city STRING,
        state STRING, 
        zip STRING,
        county STRING,
        phone STRING,
        measure_name STRING,
        measure_id STRING,
        comp_to_natl STRING,
        denom DOUBLE,
        score DOUBLE,
        low_est DOUBLE,
        high_est DOUBLE,
        footnote STRING,
        start_date DATE,
        end_date DATE)
COMMENT 'from /user/w205/hospital_compare/readmissions/readmissions.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
 "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';