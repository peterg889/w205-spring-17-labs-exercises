DROP TABLE IF EXISTS measures;
CREATE EXTERNAL TABLE measures(
        measure_name STRING,
        measure_id STRING,
        start_quarter STRING,
        start_date DATE,
        endquarter STRING,
        end_date DATE)
COMMENT 'from /user/w205/hospital_compare/measures/measures.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
 "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';