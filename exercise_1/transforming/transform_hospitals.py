from pyspark import SparkConf, SparkContext
from pyspark.sql import SQLContext
import csv

conf = SparkConf().setAppName("transform hospitals")
sc = SparkContext(conf=conf)

def toCSVLine(data):
  return ','.join(str(d) for d in data)

filename = "/user/w205/hospital_compare/hospitals/hospitals.csv"
rdd = sc.textFile(filename)
csv_rdd = rdd.mapPartitions(lambda x: csv.reader(x))

columns = [0,1,4]

selected_rdd = csv_rdd.map(lambda row: [row[i] for i in columns])

lines = selected_rdd.map(toCSVLine)
lines.saveAsTextFile('/user/w205/hospital_compare/transformed_hospitals')