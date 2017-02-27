#! /bin/bash
# download files
mkdir hospdata
cd hospdata

wget "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip" -O hospdata.zip

unzip hospdata.zip

# make hdfs dir
hdfs dfs -mkdir /user/w205/hospital_compare


# rename files
mv "Hospital General Information.csv" "hospitals.tmp"
mv "Timely and Effective Care - Hospital.csv" "effective_care.tmp"
mv "Readmissions and Deaths - Hospital.csv" "readmissions.tmp"
mv "Measure Dates.csv" "measures.tmp"
mv "hvbp_hcahps_05_28_2015.csv" "survey_responses.tmp"

declare -a arr=("hospitals.tmp" "effective_care.tmp" "readmissions.tmp" "measures.tmp" "survey_responses.tmp")

## now loop through the above array
for i in "${arr[@]}"
do
   filename=`echo "$i" | cut -d'.' -f1`
   oldfile="$filename"".tmp"
   newfile="$filename"".csv"
   echo "$oldfile"
   echo "$newfile"
   tail -n +2 $oldfile > $newfile
   hadoop fs -mkdir /user/w205/hospital_compare/$filename
   hadoop fs -put $newfile /user/w205/hospital_compare/$filename/$newfile
done

# TODO -- make ERD 