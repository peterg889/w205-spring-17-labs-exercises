from pyspark import SparkConf, SparkContext
from pyspark.sql import SQLContext
import csv

conf = SparkConf().setAppName("transform procedures")
sc = SparkContext(conf=conf)


def toCSVLine(data):
  return ','.join(str(d) for d in data)

def noForbiddenValues(x, forbidden_values):
    for elem in x:
        if elem in forbidden_values: 
            return False
    return True


## effective care
filename = "/user/w205/hospital_compare/effective_care/effective_care.csv"
effective_care_rdd = sc.textFile(filename)
effective_care_csv = effective_care_rdd.mapPartitions(lambda x: csv.reader(x))

forbidden_values = ["Not Available"]

filtered_effective_care = effective_care_csv.filter(lambda x : noForbiddenValues(x, forbidden_values))

columns = [0,9,11, 10]

sampled_effective_care = filtered_effective_care.map(lambda row: [row[i] for i in columns])


## readmissions 
filename = "/user/w205/hospital_compare/readmissions/readmissions.csv"
readmissions_rdd = sc.textFile(filename)
readmissions_csv = readmissions_rdd.mapPartitions(lambda x: csv.reader(x))

forbidden_values = ["Not Available"]

filtered_readmissions = readmissions_csv.filter(lambda x : noForbiddenValues(x, forbidden_values))

columns = [0,9,12, 8]
sampled_readmissions = filtered_readmissions.map(lambda row: [row[i] for i in columns])

union_rdd = sampled_effective_care.union(sampled_readmissions).map(lambda x : (x[1], x[0], x[3], x[2]))

lines = union_rdd.map(toCSVLine)
lines.saveAsTextFile('/user/w205/hospital_compare/transform_procedures/')


