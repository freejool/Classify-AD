---
# try also 'default' to start simple
theme: seriph
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://source.unsplash.com/collection/94734566/1920x1080
# apply any windi css classes to the current slide
class: "text-center"
# https://sli.dev/custom/highlighters.html
highlighter: shiki
# show line numbers in code blocks
lineNumbers: false
# some information about the slides, markdown enabled
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# persist drawings in exports and build
drawings:
  persist: false
---

# Week 11

---

# TARGET

- find implemention of BP and more ML techniques in python.
- calculate more characteristics of the brains.
- store them in a decent way.

---

# ML methods

##### Found a repo of some ML techniques implemented in python including BP, SVM, K-Means, etc.

https://github.com/lawlite19/MachineLearning_Python

I tried BP. The accuracy is pretty low. Just a little bit better than guessing.![](img/iShot2022-05-04_23.27.01.png)

Thats what reminds me that "K_Means is not funtional in the project" is not true. Because the earlier demos are limited to 3 dimensions in which no ML method can perform corrcetly.

**The urgent need is acquire more characteristics but bot blame ML methods**


---

# More characteristics

## chars that have been calculated:

- assortativity
- charpath
- small_world_index
- mean clustering_coefficient

## Done this week

- clustering_coefficient (360 vector)
- maximized modularity: 将所有点分组，使得组内节点连接最大化，组间最小化。output: [Ci, Q]. Q is the maximized modularity.
- mean clustering coefficient: clustering coefficient 的平均值。
- sthength (360 vector)
- local efficiency (360 vector)
- betweenness centrality (360 vector)

---

# manage the data

1. store matlab varables in json. ![](img/iShot2022-05-04_23.38.51.png)

---

2. write the json files into mongoDB. ![](img/iShot2022-05-04_23.40.13.png)


---

3. combine characteristics into one csv file in Python.![](img/iShot2022-05-04_23.41.35.png)

---

4. perform ML methods on these csv files. ![](img/iShot2022-05-05_11.57.19.png)

---

# One more thing

After calculating a little, I've got **1445** characteristics. input them to the BP network.

![](img/iShot2022-05-05_11.23.07.png)

---

## BP network 4 classes

![](img/iShot2022-05-05_11.13.36.png)

---

## K-Means 2 classes

![](img/iShot2022-05-05_11.12.16.png)

---

Note that raw data is not divided into training set and testing set (TODO). But the Correct Rate is still better than last week.
