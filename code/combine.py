import collections
import json
from nis import match
from pprint import pprint
import pymongo
import numpy as np

with open('code/config.json', 'r') as f:
    config = json.load(f)

client = pymongo.MongoClient(config['mongodburl'])
db = client.AD
clusters = db.list_collection_names()
clusters.remove('test')
clusters.remove('category')
mg = {}
for clu in clusters:
    mg[clu] = db.get_collection(clu).find()
cursorIdx = db.category.find({})
docs = []
i = 0
cates = {'HC': 0, 'EMCI': 1, 'LMCI': 2, 'AD': 3}
for c in cursorIdx:
    idx = c['index']
    # doc = {'index': idx}
    doc = []
    for clu in clusters:
        data = db.get_collection(clu).find_one({'index': idx})
        value = data['value']
        if type(value) == list:
            doc.extend(value)
        else:
            doc.append(value)
    data = db.get_collection('category').find_one({'index': idx})
    doc.append(cates[data['category']])

    docs.append(doc)

d = np.array(docs)
np.savetxt("code/chars.csv", d, delimiter=",")
# db.test.insert_many(docs)
