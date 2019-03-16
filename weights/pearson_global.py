## Global P-val, per feature
## echo "base_addr,cache_line,page_addr,confidence^page_addr,curr_sig^sig_delta,ip_1^ip_2^ip_3,ip^depth,ip^sig_delta,confidence," > perc_weights_0.csv
## cat ../perc_weights_0.csv | grep -v cache >> perc_weights_0.csv 
## module load  Python/3.5.2-intel-2017A
## python ./pearson_global.py | sort -n -k2

import pandas as pd
import numpy as np
import csv
import glob,os
from subprocess import call

call(["rm", "pval_feat_global.csv"])
with open('pval_feat_global.csv','w',newline='') as f2:
	thewriter = csv.writer(f2)
	df = pd.read_csv("perc_weights_0.csv")
	corr_array = []
	for col in df.columns[0:9]:
		##print(df[col].sum())
		hist, bin_edges = np.histogram(np.array(df[col]), bins=32, range=(-16,16))
		x=np.array(range(-16,16))
		corr = np.corrcoef(x,hist)
		print('{:<20s}{:>12.4f}'.format(col,corr[1,0]))
		corr_array.append(corr[1,0])
	thewriter.writerow(corr_array)
