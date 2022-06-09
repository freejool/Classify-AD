from genericpath import exists
import numpy as np
from sklearn import neighbors, svm, tree
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier
from sklearn import preprocessing
from sklearn import pipeline
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from ReliefF import ReliefF as relief
import time
import pymongo
import random
import json
import threading
import matplotlib.pyplot as plt


def count_columns(charsToInput, re_dim_to) -> int:
    return len(charsToInput['global']) + re_dim_to


def retrive_data_from_database(charsToInput, re_dim_to) -> np.ndarray:
    with open('code/config.json', 'r') as f:
        config = json.load(f)
        client = pymongo.MongoClient(config['mongodburl'])
        db = client.AD

    # num_column = count_columns(charsToInput, re_dim_to)
    # if exists('code/sklearn/data.txt'):
    #     data = np.loadtxt('code/sklearn/data.txt', delimiter=',')
    #     if data.shape[1] == num_column+1:
    #         return data

    global_data = np.zeros(
        (102, len(charsToInput['global'])), dtype=np.float64)
    local_data = np.zeros(
        (102, len(charsToInput['local'])*360), dtype=np.float64)
    label = np.zeros((102, 1), dtype=np.float64)

    colidx = 0
    for char in charsToInput['global']:
        cursor = db.get_collection(char).find(
            {}).sort('index', pymongo.ASCENDING)
        rowidx = 0
        for c in cursor:
            global_data[rowidx, colidx] = c['value']
            rowidx += 1
        colidx += 1

    colidx = 0
    for char in charsToInput['local']:
        cursor = db.get_collection(char).find(
            {}).sort('index', pymongo.ASCENDING)
        value = []
        for c in cursor:
            value.append(c['value'])
        value = np.array(value)
        local_data[:, colidx:colidx+value.shape[1]] = value
        colidx += value.shape[1]
    # local_data = preprocessing.StandardScaler().fit_transform(local_data)
    # local_data = PCA(n_components=0.9).fit_transform(local_data)

    cursor = db.get_collection('category').find(
        {}).sort('index', pymongo.ASCENDING)
    cate_map = {'HC': 0, 'LMCI': 1, 'EMCI': 2, 'AD': 3}
    rowidx = 0
    for c in cursor:
        category = c['category']
        label[rowidx] = cate_map[category]
        rowidx += 1

    pipe = pipeline.Pipeline(
        [('scaler', preprocessing.StandardScaler()), ('norm', preprocessing.Normalizer())])

    # t = np.column_stack((local_data, label))
    # r = relief(n_features_to_keep=re_dim_to)
    # local_data = r.fit_transform(t[:, :-1], t[:, -1])

    ret = np.column_stack((global_data, local_data[:, :colidx], label))

    ret = np.array(sorted(ret, key=lambda x: x[-1]))

    # ret[:, :-1] = pipe.fit_transform(ret[:, :-1])
    np.savetxt('code/sklearn/data.txt', ret, delimiter=',')
    return ret


def split_train_test(data, test_size=0.2, cates=['HC', 'AD']):
    cate_map = {'HC': 0, 'LMCI': 1, 'EMCI': 2, 'AD': 3}
    cates = [cate_map[cate] for cate in cates]
    len_cates = len(cates)
    num_each_cate = [0 for _ in range(4)]
    rowidxs = [set() for _ in range(4)]
    choices = [set() for _ in range(4)]

    for row in data:
        if row[-1] in cates:
            num_each_cate[int(row[-1])] += 1

    selected_data = np.zeros(
        (sum(num_each_cate), data.shape[1]), dtype=np.float64)

    row_cnt = 0
    for row in data:
        if row[-1] in cates:
            selected_data[row_cnt] = row
            rowidxs[int(row[-1])].add(row_cnt)
            row_cnt += 1

    train_data = []
    test_data = []
    for idx, i in enumerate(num_each_cate):
        if i != 0:
            choices[idx] = set(random.sample(
                rowidxs[idx], int(i*(1-test_size))))
            for c in choices[idx]:
                train_data.append(selected_data[c])
            for c in rowidxs[idx]-choices[idx]:
                test_data.append(selected_data[c])

    # print('train len: ', len(train_data), '\ntest len:  ', len(test_data))
    return np.array(train_data), np.array(test_data)


def split_data_label(data):
    return data[:, :-1], data[:, -1]


def predict(data, test_size, cates) -> float:

    data_x, data_y = split_data_label(data)

    # standardize and normalize data

    train_data, test_data = split_train_test(data, test_size, cates)

    train_data_x, train_data_y = split_data_label(train_data)
    test_data_x, test_data_y = split_data_label(test_data)

    clf = svm.SVC(C=1, gamma=0.1)
    clf.fit(train_data_x, train_data_y)

    print(np.column_stack((clf.predict(test_data_x), test_data_y)))
    return clf.score(test_data_x, test_data_y)


class MyThread(threading.Thread):
    def __init__(self, func, args=()):
        super(MyThread, self).__init__()
        self.func = func
        self.args = args

    def run(self):
        self.result = self.func(*self.args)

    def get_result(self):
        threading.Thread.join(self)
        try:
            return self.result
        except Exception:
            return None


def train(data, repeat, test_size, cates, re_dim_to) -> list:
    # data = dedim(data, re_dim_to)

    threads = []
    res = []
    for i in range(repeat):
        threads.append(MyThread(predict, args=(data, test_size, cates)))
        threads[-1].start()
    # for i in range(repeat):
    #     res.append(threads[i].get_result())
    # print('\naverage accuracy: ', sum(res)/repeat)

    return threads


def main():
    repeat = 1

    charsToInput = {
        'global': [
            'small_world_index',
            'assortativity',
            'assortativity_bin',
            'charpath',
            'charpath_bin',
            'global_efficiency',
            'global_efficiency_bin',
            'optimalNModules',
            'optimal_n_modules_bin',
            'density'],
        'local': ['local_efficiency',
                  'local_efficiency_bin',
                  'page_rank',
                  'degree',
                  'eigenvector',
                  'betweeness_centrality',
                  'betweeness_centrality_bin',
                  'clustering_coefficient']}
    test_size = 0.2
    cates = ['HC', 'AD']
    re_dim_to = 10
    data = retrive_data_from_database(charsToInput, re_dim_to)

    accr = []
    clu_threads = []
    for i in range(1):
        clu_threads.append(train(data, repeat, test_size, cates, re_dim_to))
    for t in clu_threads:
        rets = []
        for tt in t:
            rets.append(tt.get_result())
        accr.append(sum(rets)/repeat)

    plt.plot(rets)
    # plt.show()
    print(accr)
    print(sum(accr)/len(accr))
    # print(len(accr))


if __name__ == '__main__':
    main()
