
# in predictions
../no_stm/benchmark_no_stm.pl ../no_stm/verified_interactions_no_stm.csv > ../no_stm/benchmark_no_stm.csv

# in CopraRNA_benchmark
# manual curation of specific lines related to additional homologs

# b0592 // additional homolog of b4290
sed -i 's/RyhB;b0592;fepB;;;/RyhB;b0592;fepB;411;599;1409/g' benchmark_no_stm.csv
# b1531 // additional homolog of b4062
sed -i 's/RyhB;b1531;marA;;;/RyhB;b1531;marA;470;86;44/g' benchmark_no_stm.csv
# b1588 // additional homolog of b0894
sed -i 's/RyhB;b1588;ynfF;;;/RyhB;b1588;ynfF;188;4;6/g' benchmark_no_stm.csv
# b1612 // additional homolog of b4122
sed -i 's/RyhB;b1612;fumA;;;/RyhB;b1612;fumA;88;74;135/g' benchmark_no_stm.csv

# plot ROC-like // in no_stm
R --slave -f plot_performance_no_stm.R

