// Phylogenetic analysis and reconstruction of evolutionary tree
process IQTREE {
  label 'highmem_medium'
  container "staphb/iqtree:latest"
//  publishDir params.outdir, mode: 'copy'
  shell '/bin/bash', '-euo', 'pipefail'
  debug false
	 
  input:
    path(InputMSA)

  output:
    path "${InputMSA}.*"

  script:
  """
   iqtree -nt ${params.threads} -s $InputMSA  -m LG 
  """
}
