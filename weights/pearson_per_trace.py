## Per feature P-val, separate for each trace
## split -d -l 4097 ../perc_weights_0.csv perc_a_
## [TODO] Need to work on the pre-processing here
## module load  Python/3.5.2-intel-2017A
## python ./pearson_per_trace.py | sort -n -k2

import pandas as pd
import numpy as np
import csv
import glob,os
from subprocess import call

call(["rm", "pval_per_trace.csv"])
with open('pval_per_trace.csv','w',newline='') as f1:
	thewriter = csv.writer(f1)
	string=("base_addr","cache_line","page_addr","confidence^page_addr","curr_sig^sig_delta","ip_1^ip_2^ip_3","ip^depth","ip^sig_delta","confidence")
	thewriter.writerow(string)
	os.chdir("./")
	for filename in glob.glob("perc_a*"):
		df = pd.read_csv(filename)
		corr_array = []
		for col in df.columns[0:9]:
			### print(df[col].sum()) 	print(df[col].mean())
			hist, bin_edges = np.histogram(np.array(df[col]), bins=32, range=(-16,16))
			x=np.array(range(-16,16))
			corr = np.corrcoef(x,hist)
			##print('{:<20s}{:>12.4f}'.format(col,corr[1,0]))
			corr_array.append(corr[1,0])
		thewriter.writerow(corr_array)
