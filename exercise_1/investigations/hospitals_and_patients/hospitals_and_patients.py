from pyspark import SparkConf, SparkContext
from pyspark.sql import SQLContext
import csv
import types
from math import sqrt

conf = SparkConf().setAppName("hospitals and patients")
sc = SparkContext(conf=conf)
sqlContext = SQLContext(sc)


def toCSVLine(data):
  return ','.join(str(d) for d in data)

def noForbiddenValues(x, forbidden_values):
    for elem in x:
        if elem in forbidden_values: 
            return False
    return True

def standard_deviation(num_list, population=True):
    num_items = len(num_list)
    mean = sum(num_list) / num_items
    differences = [x - mean for x in num_list]
    sq_differences = [d ** 2 for d in differences]
    ssd = sum(sq_differences)
 
    if population is True:
        variance = ssd / num_items
    else:
        variance = ssd / (num_items - 1)
    sd = sqrt(variance)
    return sd, mean

def calc_z_score(x, measure_id):
    sd = sds[measure_id]
    avg = avgs[measure_id]
    try:
        return (float(x) - avg) / sd
    except:
        return 0

## effective care
filename = "/user/w205/hospital_compare/effective_care/effective_care.csv"
effective_care_rdd = sc.textFile(filename)
effective_care_csv = effective_care_rdd.mapPartitions(lambda x: csv.reader(x))

forbidden_values = ["Not Available"]
columns = [0,9,11, 10]

sampled_effective_care = effective_care_csv.filter(lambda x : noForbiddenValues(x, forbidden_values)).map(lambda row: [row[i] for i in columns])


## readmissions 
filename = "/user/w205/hospital_compare/readmissions/readmissions.csv"
readmissions_rdd = sc.textFile(filename)
readmissions_csv = readmissions_rdd.mapPartitions(lambda x: csv.reader(x))

forbidden_values = ["Not Available"]
columns = [0,9,12, 8]

sampled_readmissions = readmissions_csv.filter(lambda x : noForbiddenValues(x, forbidden_values)).map(lambda row: [row[i] for i in columns])

union_rdd = sampled_effective_care.union(sampled_readmissions)

# group all measures together
samples = union_rdd.keyBy(lambda x: x[1]).groupByKey().mapValues(list).collect()

sds = {}
avgs = {}

# calculate sd and avg of each measure
for sample in samples:
    isNumber = True
    measure_id = sample[0]
    scores = [(col[2]) for col in sample[1]]
    try:
        num_list = [float(elem) for elem in scores]
    except:
        isNumber = False
    if isNumber:
        sd, avg = standard_deviation(num_list)
    else:
        sd, avg = 0, 0
    sds[measure_id] = sd
    avgs[measure_id] = avg

# add in the z score
procedures_with_z = union_rdd.map(lambda x: (x[0], x[1], x[3], calc_z_score(x[2], x[1])))

# sum the z scores for each hospital
summed_zs = procedures_with_z.map(lambda x: (x[0], x[3])).reduceByKey(lambda x,y:x+y)

keyed_zs = summed_zs.keyBy(lambda x : x[0])

# load survey response data
filename = "/user/w205/hospital_compare/survey_responses/survey_responses.csv"
rdd = sc.textFile(filename)

csv_rdd = rdd.mapPartitions(lambda x: csv.reader(x))

forbidden_values = ["Not Available"]

survey_rdd = csv_rdd.filter(lambda x : noForbiddenValues(x, forbidden_values)).map(lambda x : (x[0], int(x[31]) + int(x[32])))

keyed_survey = survey_rdd.keyBy(lambda x : x[0])

# calculate survey correlation
survey_corr = keyed_zs.join(keyed_survey).map(lambda x : (x[1][0][1], x[1][1][1]))
corr = survey_corr.toDF(["quality","score"]).stat.corr("quality","score")

print corr