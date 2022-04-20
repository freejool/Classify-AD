import collections
import json
from pprint import pprint
import pymongo

with open('code/config.json', 'r') as f:
    config = json.load(f)

client = pymongo.MongoClient(config['mongodburl'])
db = client.AD
clusters = db.list_collection_names()
clusters.remove('test')
clusters.remove('category')
cursorIdx = db.category.find({})
docs = []
for c in cursorIdx:
    idx = c['index']
    doc = {'index': idx}
    for clu in clusters:
        data = db.get_collection(clu).find_one({'index': idx})
        doc[clu] = data['value']
    data = db.get_collection('category').find_one({'index': idx})
    doc['category'] = data['category']
    docs.append(doc)
db.test.insert_many(docs)
