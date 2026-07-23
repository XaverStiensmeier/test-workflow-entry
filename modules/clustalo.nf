// Process for multiple sequence alignment generation using clustalomega.
process CLUSTALOMEGA{
   label 'highmem_large'
   container "biocontainers/clustal-omega:v1.2.1_cv5"
//   publishDir params.outdir, mode: 'copy'
   shell '/bin/bash', '-euo', 'pipefail'
   debug false

   input: 
     path(InputFastaFile)

   output:
     path "${InputFastaFile}.msa"
 
  script: 
  """
    clustalo -i $InputFastaFile -o ${InputFastaFile}.msa --outfmt=fa
  """
}
