
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

DROP TABLE IF EXISTS survey_responses;
CREATE EXTERNAL TABLE survey_responses(
        provider_id STRING, 
        hosp_name STRING,
        address STRING,
        city STRING,
        state STRING, 
        zip STRING,
        county STRING,
        com_with_nurses_ach STRING,
        com_with_nurses_imp STRING,
        com_with_nurses_dim STRING,
        com_with_doc_ach STRING,
        com_with_doc_imp STRING,
        com_with_doc_dim STRING,
        resp_of_staff_ach STRING,
        resp_of_staff_imp STRING,
        resp_of_staff_dim STRING,
        pain_mgmt_ach STRING,
        pain_mgmt_imp STRING,
        pain_mgmt_dim STRING,
        com_abt_med_ach STRING,
        com_abt_med_imp STRING,
        com_abt_med_dim STRING,
        clean_and_quiet_ach STRING,
        clean_and_quiet_imp STRING,
        clean_and_quiet_dim STRING,
        discharge_info_ach STRING,
        discharge_info_imp STRING,
        discharge_info_dim STRING,
        overall_ach STRING,
        overall_imp STRING,
        overall_dim STRING,
        hcahps_base DOUBLE,
        hcahps_consistency DOUBLE)
COMMENT 'from /user/w205/hospital_compare/survey_responses/survey_responses.csv'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" = '"',
 "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';

