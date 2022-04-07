【网络的统计描述和结构】
assortativity_bin: 二元网络(binary network,即无权网络)的同配系数
assortativity_wei: 有权网络的同配系数
betweenness_bin: 无权网络的介数(betweenness)
betweenness_wei: 有权网络的介数
edge_betweenness_wei: 有权网络的边介数
edge_betweenness_bin: 无权网络的边介数
breadthdist: 返回无权(有向/无向)网络的可达性矩阵, 以及两点的最短距离
breadth: breadthdist的子函数
clustering_coef_wd: 有权有向网络的聚类系数(cluster coefficient)
clustering_coef_wu: 有权无向网络的聚类系数(权应介于0-1之间)
clustering_coef_bd: 有向无权网络的聚类系数
clustering_coef_bu: 无向无权网络的聚类系数
clustering_coef_wu_sign: 有权无向网络的聚类系数(包括3中不同定义)
charpath: 计算特征路径长度(平均路径长度), 网络效率, 离心率, 半径, 直径
consensus_und: 一致性系数(Consensus clustering). Ref: Lancichinetti & Fortunato (2012). Consensus clustering in complex networks. Scientific Reports 2, Article number: 336. 
core_periphery_dir: 网络核心/边缘识别. Ref1: Borgatti and Everett (2000) Soc Networks 21:375鈥�95.; Ref2: Newman (2006) Phys Rev E 74:036104, PNAS 23:8577-8582.; Ref3: Rubinov, Ypma et al. (2015) PNAS 112:10032-7
cycprob: Cycle probability 
degrees_dir: 出/入度
degrees_und: 度
density_dir: 有向网络密度
density_und: 无向网络密度
jdegree: 联合度分布(有向网络)
kcore_bd: k-核分解(有向)
kcore_bu: k-核分解(无向)
kcoreness_centrality_bu: 核数
kcoreness_centrality_bd: 核数
diffusion_efficiency: 传播效率(定义为ij之间首次到达时间的倒数)
efficiency_bin: 无权网络的效率(定义为最短距离的倒数的平均)
efficiency_wei: 有权网络的效率
distance_bin: 无权网络的点间距离
distance_wei: 点间距离(Dijkstra's algorithm)
distance_wei_floyd: 点间距离(Floyd-Warshall algorithm)
edge_nei_overlap_bd: 邻接节点的重合邻居数量(有向网络). Ref: Easley and Kleinberg (2010) Networks, Crowds, and Markets. Cambridge University Press, Chapter 3
edge_nei_overlap_bu: 邻接节点的重合邻居数量(无向网络).
eigenvector_centrality_und: 无向网络的特征向量中心性
erange: 无权网络的捷径(定义为显著减少平均路径长度的边)
findwalks: 给定距离后, 找到两点间路径数量
flow_coef_bd: 无权有向网络flow coefficient(定义类似介数) Ref: Honey et al. (2007) PNAS
get_components: 找到无向网络的所有连通子图



[网络模型]
generative_model: 产生一个人工网络. Ref: Reference: Betzel et al (2016) Neuroimage 124:1054-64.
evaluate_generative_model: 对比两个网络的差异性.
generate_fc: Generation of synthetic functional connectivity matrices

[社区发现]
clique_communities: 重叠社区发现clique percolation算法. Ref: Palla et al. (2005) Nature 435, 814-818.
community_louvain: 基于优化的社区发现算法. (Ref1: Blondel et al. (2008) J. Stat. Mech. P10008.; Ref2: Reichardt and Bornholdt (2006) Phys. Rev. E 74, 016110.; Ref3: Ronhovde and Nussinov (2008) Phys. Rev. E 80, 016109; Ref4: Sun et al. (2008) Europhysics Lett 86, 28004.; Ref5: Rubinov and Sporns (2011) Neuroimage 56:2068-79.)
diversity_coef_sign: 基于香农熵的多样性系数. Ref: Rubinov and Sporns (2011) NeuroImage.
gateway_coef_sign: Gateway coefficient
gtom: Generalized topological overlap measure(相似的m步邻居). Ref1: Yip & Horvath (2007) BMC Bioinformatics 2007, 8:22; Ref2: Ravasz et al (2002) Science 297 (5586), 1551.

[网络可视化]
adjacency_plot_und: 快速的可视化工具
backbone_wu: 提取网络的骨架(基于最小生成树)
grid_communities: 社区

agreement: Agreement matrix from clusters
agreement_weighted: Weights agreement matrix
align_matrices: Alignment of two matrices
