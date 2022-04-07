# 综述

阿尔兹海默症（AD）是当今能导致痴呆症的最常见的疾病之一。2018年有大约5千万人为之所困扰。而据预测，到了2030年，这个数字将会变成1亿5千万。

尽管AD必须在60岁之后才能被诊断出，但是对于某些拥有特定基因突变的个体，AD的症状也有可能出现的非常早（30-50岁）。也就是说，AD的发展是一个漫长的过程：首先是轻度认知障碍（MCI），随着时间慢慢发展成AD。然而，并非所有患有MCI的患者最终都会患上AD。所以当下的研究多着重于找到如何预测MCI能否发展成AD的方法。当前观测的指标主要有[神经成像](https://doi.org/10.1016/j.neuroimage.2017.03.057)和血液检查。

包括[ADNI](adni.loni.usc.edu)、[AIBL](aibl.csiro.au)、[OASIS](www.oasis-brains.org)、[J-ADNI](http://doi.org/10.3233/JAD-160621)在内的多个开源数据库和SPM、VBM、Freesurfer等工具被用来训练和评估分类方法的准确性。

在过去的十年内，机器学习是最受欢迎和卓有成效的诊断AD的方法。最常用的是支持向量机技术（SVM）、人工神经网络（ANN）和深度学习。SVM和ANN的最大区别是SVM是全局最优而ANN是局部最优。对于图像数据，深度学习非常有用。

不同的分类问题有着不同的准确率，CN和AD的准确率最高，CN和MCI的准确率次之，MCI和AD的准确率最低。更进一步，MCIc、MCInc、aMCI、naMCI的分类的准确率也很难提高。另外，由于三维的MRI信息拥有较大的数据量，所以在大量的数据中进行高效的特征提取也是必不可少的。

## 支持向量机（SVM）[^1]

假如数据点在$p$维空间内，且数据点线性可分，那么就可以用$p-1$维的超平面来分开这些点

![](https://gitee.com/xy-shen/my-image-beg/raw/master/imgs//20220313114043.png)

能将不同的样本分开的超平面很多，图中$H_2\;H_3$都可以分开。但是显然$H_3$的效果更好，因为它能容忍数据的一些噪声而正确分类。

划分数据的超平面可以用以下线性方程来描述：

$$
f(x)=sign(w^Tx+b)
$$ 

其中$w$为超平面的法向量，$b$为超平面与原点之间的距离。

![](https://gitee.com/xy-shen/my-image-beg/raw/master/imgs//20220313114954.png)

为了找到最佳的平面，我们需要使$\frac{2}{||w||}$最大化。

### 核函数

为了分类非线性关系的数据，用核函数[^2]将二维信息映射到更高维度。

![](https://gitee.com/xy-shen/my-image-beg/raw/master/imgs//20220313124522.png)

核函数将样本从原始空间映射到一个更高维的特征空间，使得样本在这个特征空间内线性可分。

## 人工神经网络（ANN）

![](https://gitee.com/xy-shen/my-image-beg/raw/master/imgs/20220315123617.png)

激活函数

误差逆传播算法

## 深度学习（DL）



Fan等人[41]提出正电子发射断层扫描（PET）为sMRI扫描提供了补充信息，从而提高了使用SVM对CN与MCI的分类准确性。Dukart等人[40]支持这一事实，即氟脱氧葡萄糖-PET（FDG-PET）特征与sMRI相比更具有鉴别力。此外，与单光子发射计算机断层扫描（SPECT）图像（97.5%）相比，PET图像（100%）对CN与AD[7]的准确性更好。类似的发现也出现在CN对AD[150]中，与SPECT图像（94.5%）相比，PET图像（96.67%）的准确性更好。Kamathe等人[75]使用T1、T2和质子密度（PD）扫描的组合对CN与AD进行分类。Hojjati等人[58]使用静止状态功能磁共振（rs-fMRI）来寻找大脑中的连接性变化，以对MCIc与MCInc进行分类，而Sheng等人[152]使用fMRI数据的连接性信息。图2显示了我们调查中SVM的图像模式的使用情况。

弥散张量成像（DTI）也被不同的研究者探索用于阿尔茨海默病[91, 119, 194]。Haller等人[53]发现，基于SVM的白质DTI参数分析有助于对不同类型的MCI患者进行分类。







基于SVM的模型已被广泛用于阿尔茨海默病，显示出其稳健性。这是因为ANN等技术存在局部最小值的缺点，而SVM则不然。然而，当涉及到增量学习[110]、连续数据建模[130]和高维空间量化[121]时，ANN的用途更广，更稳健。因此，ANN的新变体可以在未来用于阿尔茨海默病。深度学习和集合学习技术通过对高度复杂的数据进行高精度的建模，给出了很好的结果。SVM的大量使用也源于这样一个事实：与作为黑箱模型的深度神经网络相比，它更容易解释。这个问题应该在未来通过关注深度学习模型的临床可解释性来解决。此外，在适当整合特征选择技术和机器学习模型方面还需要做更多的工作，以适应特定模式的数据。

[^1]:[Support vector machine. Machine learning 20, 3 (1995), 273–297.](https://mlab.cb.k.u-tokyo.ac.jp/~moris/lecture/cb-mining/4-svm.pdf)
[^2]:[Nello Cristianini and Bernhard Scholkopf. 2002. Support vector machines and kernel methods: the new generation of learning machines. Ai Magazine 23, 3 (2002), 31–31.](https://ojs.aaai.org/index.php/aimagazine/article/view/1655)
