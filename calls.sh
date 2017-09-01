
# in predictions
../benchmark.pl ../verified_interactions.csv > ../benchmark.csv

# in CopraRNA_benchmark
# manual curation of specific lines related to additional homologs

# STM1452 tppB // predicted with STM0710 // additional homologs only shown for eco
sed -i 's/GcvB;STM1452;tppB;;;/GcvB;STM1452;tppB;69;67;117/g' benchmark.csv
# STM3564 livK // predicted with STM3567 // additional homologs only shown for eco
sed -i 's/GcvB;STM3564;livK;;;/GcvB;STM3564;livK;14;6;7/g' benchmark.csv
# STM4351 // predicted with STM0890 // additional homologs only shown for eco
sed -i 's/GcvB;STM4351;-;;;/GcvB;STM4351;-;53;39;44/g' benchmark.csv
# STM0999 // predicted with STM1473 // additional homologs only shown for eco
sed -i 's/RybB;STM0999;ompF;;;/RybB;STM0999;ompF;2;3;5/g' benchmark.csv
# STM1530 // predicted with STM1473 // additional homologs only shown for eco
sed -i 's/RybB;STM1530;-;;;/RybB;STM1530;-;2;3;5/g' benchmark.csv
# STM1572 // predicted with STM1473 // additional homologs only shown for eco
sed -i 's/RybB;STM1572;ompD;;;/RybB;STM1572;ompD;2;3;5/g' benchmark.csv
# STM1995 // predicted with STM1473 // additional homologs only shown for eco
sed -i 's/RybB;STM1995;ompS;;;/RybB;STM1995;ompS;2;3;5/g' benchmark.csv
# STM2267 // predicted with STM1473 // additional homologs only shown for eco
sed -i 's/RybB;STM2267;ompC;;;/RybB;STM2267;ompC;2;3;5/g' benchmark.csv
# b0592 // additional homolog of b4290
sed -i 's/RyhB;b0592;fepB;;;/RyhB;b0592;fepB;411;599;1409/g' benchmark.csv
# b1531 // additional homolog of b4062
sed -i 's/RyhB;b1531;marA;;;/RyhB;b1531;marA;470;86;44/g' benchmark.csv
# b1588 // additional homolog of b0894
sed -i 's/RyhB;b1588;ynfF;;;/RyhB;b1588;ynfF;188;4;6/g' benchmark.csv
# b1612 // additional homolog of b4122
sed -i 's/RyhB;b1612;fumA;;;/RyhB;b1612;fumA;88;74;135/g' benchmark.csv

# plot ROC-like
R --slave -f plot_performance.R


