from pyparsing import nums
from sklearn.cluster import KMeans
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D

# Importing the dataset
dataset = pd.read_csv('test.csv')
data = dataset.iloc[:, 2:5].values
numSamples = len(data)
corrctnum = []

# 假如我要构造一个聚类数为3的聚类器
estimator = KMeans(n_clusters=3)  # 构造聚类器
estimator.fit(data)  # 聚类
label_pred = estimator.labels_  # 获取聚类标签
centroids = estimator.cluster_centers_  # 获取聚类中心
inertia = estimator.inertia_  # 获取聚类准则的总和

mark = ['or', 'ob', 'og']
figure = plt.figure()
ax = Axes3D(figure)
for i in range(numSamples):
    if dataset.iloc[i, :]['category'] == 'AD':
        ax.scatter(data[i][0], data[i][1], data[i][2], c='r',)
    else:
        ax.scatter(data[i][0], data[i][1], data[i][2], c='b',)
ax.legend(loc='best')
mark = ['Dr', 'Db', 'Dg']
for i in range(2):
    plt.plot(centroids[i][0], centroids[i][1],
             centroids[i][2], mark[i], markersize=12)
plt.show()
for i in range(2):
    corrctnum.append(0)
    for j in range(numSamples):
        if estimator.labels_[j] == i and dataset.iloc[j, :]['category'] == 'AD':
            corrctnum[-1] += 1
        elif estimator.labels_[j] == 1-i and dataset.iloc[j, :]['category'] != 'AD':
            corrctnum[-1] += 1
print(max(corrctnum)/numSamples)
pass
