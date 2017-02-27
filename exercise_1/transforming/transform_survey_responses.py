from pyspark import SparkConf, SparkContext
from pyspark.sql import SQLContext
import csv

conf = SparkConf().setAppName("transform survey responses")
sc = SparkContext(conf=conf)


def toCSVLine(data):
  return ','.join(str(d) for d in data)

def noNotAvailable(x):
    for elem in x:
        if elem == "Not Available": 
            return False
    return True

filename = "/user/w205/hospital_compare/survey_responses/survey_responses.csv"
rdd = sc.textFile(filename)
csv_rdd = rdd.mapPartitions(lambda x: csv.reader(x))

filtered_rdd = csv_rdd.filter(noNotAvailable)

summed_rdd = filtered_rdd.map(lambda x : (x[0], int(x[31]) + int(x[32])) )

lines = summed_rdd.map(toCSVLine)
lines.saveAsTextFile('/user/w205/hospital_compare/transform_survey_responses')
