#!/usr/local/perl/bin/perl

use strict;
use warnings;

# retrieves ranks in sRNA target predictions

my $verified_interactions = $ARGV[0]; # verified_interactions.csv

my @dirs = <*>; # files here

open (MYDATA, $verified_interactions) or die("\nError: cannot open $verified_interactions at benchmark.pl\n\n"); 
    my @confirmed_hybrids = <MYDATA>;
close MYDATA;

# header
print "srna_name;target_ltag;target_name;c1_rank;c2_ooi;c2_evo;intarna\n";

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
            my $c1_rank = `grep -Poni '$target_ltag\\(' $_/CopraRNA1_final_all.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $c1_rank;

            # grep CopraRNA2 ooi
            my $ooi_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_all_ooi.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $ooi_c2;

            # grep CopraRNA2 evo
            my $evo_c2 = `grep -Poni '$target_ltag\\(' $_/CopraRNA2_final_all_evo.csv | head -n1 |  awk -F':' '{ print \$1 }'`;
            chomp $evo_c2;

            my $intarna_rank = "";
            # intarna
            if ($target_ltag =~ m/STM/) {
               $intarna_rank = `grep -Poni '$target_ltag' $_/NC_003197_upfromstartpos_200_down_100_opt.intarna.csv | head -n1 |  awk -F':' '{ print \$1 }'`; 
            } else { # eco
               $intarna_rank = `grep -Poni '$target_ltag' $_/NC_000913_upfromstartpos_200_down_100_opt.intarna.csv | head -n1 |  awk -F':' '{ print \$1 }'`; 
            }

            # remove 1 because of header line
            $c1_rank-- if($c1_rank);
            $ooi_c2-- if($ooi_c2);
            $evo_c2-- if($evo_c2);
            $intarna_rank-- if($intarna_rank);

            # print bench line
            print "$srna_name;$target_ltag;$target_name;$c1_rank;$ooi_c2;$evo_c2;$intarna_rank\n";
            
        }
    }
}


