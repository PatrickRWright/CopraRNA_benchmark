#!/usr/local/perl/bin/perl

use strict;
use warnings;

# retrieves ranks in sRNA target predictions

my $verified_interactions = $ARGV[0]; # verified_interactions_no_stm.csv

my @dirs = <*>; # files here

open (MYDATA, $verified_interactions) or die("\nError: cannot open $verified_interactions at benchmark.pl\n\n"); 
    my @confirmed_hybrids = <MYDATA>;
close MYDATA;

# header
print "srna_name;target_ltag;target_name;c1_rank;c2_ooi;c2_ooi_cons;c2_ooi_ooicons;c2_bal;c2_bal_cons;c2_evo;intarna;interactome\n";

foreach (@confirmed_hybrids) {

    my @split = split(/;/, $_);
    my $srna_name = $split[0];
    my $target_ltag = $split[1]; 
    my $target_name = $split[2];

    foreach (@dirs) { # every sRNA only matches one dir
        if ($_ =~ m/$srna_name/) { # find the appropriate dir
            
            # grep explained
            # search for the locus_tag followed by (. Then only the first hit because there may be many and then awk to only return the rank and not the match

            # grep CopraRNA1_final_all.csv
            my $c1_rank = `grep -Poni '$target_ltag\\(' $_/CopraRNA1_result.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $c1_rank;

            # grep CopraRNA2 ooi
            my $ooi_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_ooi.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $ooi_c2;

            # grep CopraRNA2 ooi cons
            my $ooi_cons_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_ooi_consensus.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $ooi_cons_c2;

            # grep CopraRNA2 ooi ooicons
            my $ooi_ooicons_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_ooi_ooiconsensus.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $ooi_ooicons_c2;

            # grep CopraRNA2 balanced
            my $bal_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_balanced.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $bal_c2;

            # grep CopraRNA2 balanced cons
            my $bal_cons_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_balanced_consensus.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $bal_c2;

            # grep CopraRNA2 evo
            my $evo_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_all_evo.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $evo_c2;

            my $intarna_rank = "";
            # intarna
            if ($target_ltag =~ m/STM/) {
            } else { # eco
               $intarna_rank = `grep -Poni '$target_ltag' $_/NC_000913_upfromstartpos_200_down_100_opt.intarna.sorted.csv | head -n1 |  awk -F':' '{ print \$1 }'`; 
            }

            # remove 1 because of header line
            $c1_rank-- if($c1_rank);
            $ooi_c2-- if($ooi_c2);
            $ooi_cons_c2-- if($ooi_cons_c2);
            $ooi_ooicons_c2-- if($ooi_ooicons_c2);
            $bal_c2-- if($bal_c2);
            $bal_cons_c2-- if($bal_cons_c2);
            $evo_c2-- if($evo_c2);
            $intarna_rank-- if($intarna_rank);

            # interactome
            my $interactome_rank = `grep -Poni '$target_name' $_/*sorted.csv | head -n1 | awk -F':' '{ print \$2 }'`;
            chomp $interactome_rank;
  
            # print bench line
            print "$srna_name;$target_ltag;$target_name;$c1_rank;$ooi_c2;$ooi_cons_c2;$ooi_ooicons_c2;$bal_c2;$bal_cons_c2;$evo_c2;$intarna_rank;$interactome_rank\n";

        }
    }
}


