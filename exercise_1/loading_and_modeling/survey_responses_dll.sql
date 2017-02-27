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
