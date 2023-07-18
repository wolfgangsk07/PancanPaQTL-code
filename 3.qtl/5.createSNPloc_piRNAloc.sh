
mkdir gene_snp_loc -p


echo start creating gene locs
pigz -cd gene_snp_loc/shrinked_pro_anno.gz|awk 'BEGIN{
		OFS="\t"
		print "geneid\tchr\tleft\tright"
	}
	{

		print $4,"chr"$1,$2,$3

		
	}'|pigz>gene_snp_loc/geneloc.gz

echo start creating snp locs
pigz -cd gene_snp_loc/shrinked_SNP_anno.gz|awk 'BEGIN{
		OFS="\t"
		print "snpid\tchr\tpos"
	}
	{
		print $5,$2,$4
	}'|pigz>gene_snp_loc/snploc.gz


