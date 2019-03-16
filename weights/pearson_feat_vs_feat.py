## Feature by feature correlation of perc weights
## module load  Python/3.5.2-intel-2017A
## python ./pearson_feat_vs_feat.py

import pandas as pd
import numpy as np
import csv
import glob,os
from subprocess import call

call(["rm", "pval_feat_vs_feat.csv"])
with open('pval_feat_vs_feat.csv','w',newline='') as f3:
	thewriter = csv.writer(f3)
	string=("base_addr","cache_line","page_addr","confidence^page_addr","curr_sig^sig_delta","ip_1^ip_2^ip_3","ip^depth","ip^sig_delta","confidence")
	thewriter.writerow(string)
	hist = [None] * 9
	df = pd.read_csv("perc_weights_0.csv")
	i = 0
	for col in df.columns[0:9]:
		hist[i], bin_edges = np.histogram(np.array(df[col]), bins=32, range=(-16,16))
		i += 1
	for i in range(0,9):
		x=np.array(hist[i])
		corr_array = []
		for j in range(0,9):
			y=np.array(hist[j])
			corr = np.corrcoef(x,y)
			corr_array.append(corr[1,0])
		thewriter.writerow(corr_array)
