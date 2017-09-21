d <- read.table("benchmark_no_stm.csv", sep=";", header=T)
d_t2 <- read.table("benchmark_targetrna2_no_stm.csv", sep=";", header=T)

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

# interactome
interactome_ranks <- d$interactome
interactome_ranks_cumulated <- c()

# TargetRNA2
targetrna_ranks <- d_t2$targetrna2
targetrna_ranks_cumulated <- c()

for (i in 1:200) {
    # CopraRNA 1
    c1_ranks_cumulated <- c(c1_ranks_cumulated, length(which(c1_ranks<=i)))
    # CopraRNA 2 ooi
    c2_ooi_rank_cumulated <- c(c2_ooi_rank_cumulated, length(which(c2_ooi_rank<=i)))    
    # CopraRNA 2 evo 
    c2_evo_rank_cumulated <- c(c2_evo_rank_cumulated, length(which(c2_evo_rank<=i)))    
    # IntaRNA
    intarna_ranks_cumulated <- c(intarna_ranks_cumulated, length(which(intarna_ranks<=i)))
    # interactome
    interactome_ranks_cumulated <- c(interactome_ranks_cumulated, length(which(interactome_ranks<=i)))
    # TargetRNA2
    targetrna_ranks_cumulated <- c(targetrna_ranks_cumulated, length(which(targetrna_ranks<=i)))
}

pdf("CopraRNA2_benchmark_no_stm.pdf")
    # CopraRNA 1
    plot(c1_ranks_cumulated, type="l", main="", ylab="# True Positives", xlab="# Target predictions per sRNA", ylim=c(0,70), lwd=2, col="coral")
    # IntaRNA
    lines(intarna_ranks_cumulated, col="gray48", lwd=2)
    # CopraRNA 2 ooi
    lines(c2_ooi_rank_cumulated, col="cornflowerblue", lwd=2)
    # CopraRNA 2 evo
    lines(c2_evo_rank_cumulated, col="cornflowerblue", lwd=2, lty=2)
    # interactome
    lines(interactome_ranks_cumulated, col="darkkhaki", lwd=2)
    # TargetRNA 2
    lines(targetrna_ranks_cumulated, col="black", lwd=2)

    legend(120, 25, c("CopraRNA 2 ooi", "CopraRNA 2 evo", "CopraRNA 1", "IntaRNA", "interactome", "TargetRNA2"), col=c("cornflowerblue","cornflowerblue","coral","gray48","darkkhaki", "black"), lty=c(1,2,1,1,1,1), lwd=2)
dev.off()

