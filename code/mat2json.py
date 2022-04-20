from email import charset
from numpy import ndarray
from scipy.io import loadmat
import sys
import json
import os
import re
import mysql.connector as MySQLdb


classes = ["0.HC", "1.EMCI", "3.LMCI", "4.AD"]
connPath = '/Users/sxing/Library/CloudStorage/OneDrive-Personal/2021_2/matlab/Connectivity/'
out = []
# db = MySQLdb.connect(host="1.tragichank.asia", user="sxing",
#                      password="1234", database="AD")
# cursor = db.cursor()

for clas in classes:
    for filename in os.listdir(connPath+clas):
        m = re.search('ADNI[^.]+', filename)
        if m:
            # print(m.group(0))
            out.append({'index': m.group(0), 'category': clas[2:]})
            print("INSERT INTO category VALUES (\"{}\", \"{}\"); ".format(m.group(0), clas[2:])
                  )

with open('ass.json', 'w') as f:
    json.dump(out, f)
