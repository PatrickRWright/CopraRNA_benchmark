
# in predictions
../no_stm/benchmark_no_stm.pl ../no_stm/verified_interactions_no_stm.csv > ../no_stm/benchmark_no_stm.csv

# in CopraRNA_benchmark
# manual curation of specific lines related to additional homologs

# b0592 // additional homolog of b4290
sed -i 's/RyhB;b0592;fepB;;;;;;;;;/RyhB;b0592;fepB;;;272;284;;;;;/' benchmark_no_stm.csv
# b1531 // additional homolog of b4062
sed -i 's/RyhB;b1531;marA;;;;;;;;;/RyhB;b1531;marA;207;77;;277;46;21;38;;/' benchmark_no_stm.csv
# b1588 // additional homolog of b0894
sed -i 's/RyhB;b1588;ynfF;;;;;;;;;/RyhB;b1588;ynfF;230;4;5;83;6;9;9;;/' benchmark_no_stm.csv
# b1612 // additional homolog of b4122
sed -i 's/RyhB;b1612;fumA;;;;;;;;;31/RyhB;b1612;fumA;;71;27;22;138;52;83;;31/' benchmark_no_stm.csv

# plot ROC-like // in no_stm
R --slave -f plot_performance_no_stm.R

