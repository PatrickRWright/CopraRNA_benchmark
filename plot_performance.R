d <- read.table("benchmark.csv", sep=";", header=T)

# CopraRNA 1
c1_ranks <- d$c1_rank
c1_ranks_cumulated <- c()

# CopraRNA 2 ooi
c2_ooi_rank <- d$c2_ooi
c2_ooi_rank_cumulated <- c()

# CopraRNA 2 evo
c2_evo_rank <- d$c2_evo
c2_evo_rank_cumulated <- c()

# IntaRNA
intarna_ranks <- d$intarna
intarna_ranks_cumulated <- c()

for (i in 1:200) {
    # CopraRNA 1
    c1_ranks_cumulated <- c(c1_ranks_cumulated, length(which(c1_ranks<=i)))
    # CopraRNA 2 ooi
    c2_ooi_rank_cumulated <- c(c2_ooi_rank_cumulated, length(which(c2_ooi_rank<=i)))    
    # CopraRNA 2 evo 
    c2_evo_rank_cumulated <- c(c2_evo_rank_cumulated, length(which(c2_evo_rank<=i)))    
    # IntaRNA
    intarna_ranks_cumulated <- c(intarna_ranks_cumulated, length(which(intarna_ranks<=i)))
}

pdf("CopraRNA2_benchmark.pdf")
    # CopraRNA 1
    plot(c1_ranks_cumulated, type="l", main="", ylab="# True Positives", xlab="# Target predictions per sRNA", ylim=c(0,120), lwd=2, col="coral")
    # IntaRNA
    lines(intarna_ranks_cumulated, col="gray48", lwd=2)
    # CopraRNA 2 ooi
    lines(c2_ooi_rank_cumulated, col="cornflowerblue", lwd=2)
    # CopraRNA 2 evo
    lines(c2_evo_rank_cumulated, col="cornflowerblue", lwd=2, lty=2)

    legend(120, 40, c("CopraRNA 1", "CopraRNA 2 ooi", "CopraRNA 2 evo", "IntaRNA"), col=c("coral","cornflowerblue","cornflowerblue","gray48"), lty=c(1,1,2,1), lwd=2)
dev.off()

