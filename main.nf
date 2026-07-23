// Nextflow workflow for
// (1) ClustalOmega MSA generation
// (2) Reconstruction of evolutionary tree with iqtree
// (3) Tree visualization using R/ggtree

include { CLUSTALOMEGA } from './modules/clustalomega'
include { IQTREE } from './modules/iqtree'
include { VISUALIZETREE } from './modules/visualizetree'


workflow {
   CLUSTALOMEGA(params.inputfile) | IQTREE
   VISUALIZETREE(CLUSTALOMEGA.out,IQTREE.out)

// Completion mail handler
workflow.onComplete = {

    def msg = """\
        Workflow execution summary
        ---------------------------
	ScriptName     : ${workflow.scriptName}
	Repository     : ${workflow.repository}
        Run            : ${workflow.runName}
        Commandline    : ${workflow.commandLine}
	Start time     : ${workflow.start}
        Completed at   : ${workflow.complete}
        Duration       : ${workflow.duration}
        Success        : ${workflow.success ? 'OK' : 'failed' }
        workDir        : ${workflow.workDir}
        exit status    : ${workflow.exitStatus}
        Error message  : ${workflow.errorMessage}
	Error report   : ${workflow.errorReport}
        ContainerEngine: ${workflow.containerEngine}
	Container(s)   : ${workflow.container}
	Nextflow ver.  : ${nextflow.version}
        Nextflow build : ${nextflow.build}	
        """
        .stripIndent()
	if (params.email?.trim()) {
          sendMail(to: "${params.email}", from: "${params.mailfrom}", subject: 'MegaTree workflow execution report', body: msg)
        }
	else {
          // no Email adress set (params.email == empty or null)
        }
}
}
