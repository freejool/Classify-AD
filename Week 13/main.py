from genericpath import exists
import numpy as np
from sklearn import svm, tree
from sklearn.decomposition import PCA
from sklearn.naive_bayes import GaussianNB
from sklearn.neural_network import MLPClassifier
import time
import pymongo
import random
import json
import threading
import matplotlib.pyplot as plt


def count_columns(charsToInput, db) -> int:

    num_column = 0
    for char in charsToInput:
        value = db.get_collection(char).find_one()['value']
        if type(value) != list:
            value = [value]
        num_column += len(value)
    return num_column


def retrive_data_from_database(charsToInput) -> np.ndarray:
    with open('code/config.json', 'r') as f:
        config = json.load(f)
    client = pymongo.MongoClient(config['mongodburl'])
    db = client.AD

    num_column = count_columns(charsToInput, db)
    if exists('code/sklearn/data.txt'):
        data = np.loadtxt('code/sklearn/data.txt', delimiter=',')
        if data.shape[1] == num_column+1:
            return data

    # the last column is label
    ret = np.zeros((102, num_column+1), dtype=np.float64)
    columnidx = 0

    for char in charsToInput:
        cursor = db.get_collection(char).find(
            {}).sort('index', pymongo.ASCENDING)
        for rowidx, c in enumerate(cursor):
            value = c['value']
            if type(value) != list:
                value = [value]
            ret[rowidx, columnidx:columnidx + len(value)] = value
        columnidx += len(value)

    cursor = db.get_collection('category').find(
        {}).sort('index', pymongo.ASCENDING)
    cate_map = {'HC': 0, 'LMCI': 1, 'EMCI': 2, 'AD': 3}
    for rowidx, c in enumerate(cursor):
        category = c['category']
        ret[rowidx, -1] = cate_map[category]

    ret = np.array(sorted(ret, key=lambda x: x[-1]))
    np.savetxt('code/sklearn/data.txt', ret, delimiter=',')
    return ret


def dedim(data, re_dim_to):
    pca = PCA(n_components=20)
    dataX = pca.fit_transform(data[:, :-1])
    data = np.column_stack((dataX, data[:, -1]))
    return data


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

    train_data, test_data = split_train_test(data, test_size, cates)

    train_data_x, train_data_y = split_data_label(train_data)
    test_data_x, test_data_y = split_data_label(test_data)

    # clf = svm.SVC()
    # clf.fit(train_data_x, train_data_y)
    clf = MLPClassifier(hidden_layer_sizes=(100, 100, 100))
    clf.fit(train_data_x, train_data_y)

    accuracy = clf.score(test_data_x, test_data_y)
    # print('accuracy: ', clf.score(test_data_x, test_data_y))
    return accuracy


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
    charsToInput = ['page_rank', 'optimalNModules', 'degree', 'charpath', 'eigenvector', 'strength',
                    'global_efficiency', 'betweeness_centrality', 'clustering_coefficient', 'local_efficiency', 'assortativity', 'small_world_index']
    test_size = 0.2
    cates = ['HC', 'AD']
    re_dim_to = 30
    data = retrive_data_from_database(charsToInput)

    accr = []
    clu_threads = []
    for i in range(1):
        clu_threads.append(train(data, repeat, test_size, cates, i))
    for t in clu_threads:
        rets = []
        for tt in t:
            rets.append(tt.get_result())
        accr.append(sum(rets)/repeat)

    # plt.plot(accr)
    # plt.show()
    print(accr)
    # print(len(accr))


if __name__ == '__main__':
    main()
