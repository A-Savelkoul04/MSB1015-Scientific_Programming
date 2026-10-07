
############################################################
##########                                        ##########
##########  This is the checks file containing    ##########
##########  the checks functions to prevent       ##########
##########  bloating the main file                ##########
##########                                        ##########
############################################################
#This file has various checks in it that make the main script look bloated while just adding some feedback, so they have been placed in this seperate R script.

#####################
### Does the in/  ###
### output exist  ###
#####################
Fun_in_out_check <- function(){
  #Input
  if (dir.exists(INPUT_FILE_LOCATION)){
    #The input location exists
    cat("The input location exists\n")
  } else if (!dir.exists(INPUT_FILE_LOCATION)) {
    warning("The input location cannot be found\n")
  } else {
    warning("Something unknown went wrong\n")
  }
  
  #Output
  if (dir.exists(OUTPUT_FILE_LOCATION)){
    #The output location exists
    cat("The output location exists\n")
  } else if (!dir.exists(OUTPUT_FILE_LOCATION)) {
    dir.create(OUTPUT_FILE_LOCATION)
    cat("The output location has been created\n")
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### Are the       ###
### settings      ###
### allowed       ###
#####################
Fun_settings_check <- function(){
  #-----#
  #In section: remove_missing
  #allow_zeros_in_healthy_percent needs to be a number and be between (inclusive) 0 and 100.
  if (is.numeric(allow_zeros_in_healthy_percent) & 0 <= allow_zeros_in_healthy_percent & allow_zeros_in_healthy_percent <= 100){
    cat("allow_zeros_in_healthy_percent has a valid value.\n")
  } else {
    warning("allow_zeros_in_healthy_percent does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #allow_zeros_in_EDS_percent needs to be a number and be between (inclusive) 0 and 100.
  if (is.numeric(allow_zeros_in_EDS_percent) & 0 <= allow_zeros_in_EDS_percent & allow_zeros_in_EDS_percent <= 100){
    cat("allow_zeros_in_EDS_percent has a valid value.\n")
  } else {
    warning("allow_zeros_in_EDS_percent does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #FILTERSETTING needs to be one of the 3 allowed options
  if (FILTERSETTING == "either" | FILTERSETTING == "both" | FILTERSETTING == "difference" ){
    cat("FILTERSETTING has a valid value.\n")
  } else {
    warning("FILTERSETTING does NOT have a valid value.\nUse one of the three available options: \"either\", \"both\", or \"difference\".\nStopping code.\n")
    stop()
  }
  
  #-----#
}

#####################
### Can the data  ###
### be found      ###
#####################
#TAG: Modify this check if time allows so it can be reused for the other data if it gets used.
Fun_GSE270199_findability_check <- function(){
  #Check that the required inputs can be found, otherwise stop the code from running
  if (!file.exists(paste0(INPUT_FILE_LOCATION,"/GSE270199_COL3A1_normalizedCounts.txt"))){
    warning("GSE270199_COL3A1_normalizedCounts.txt not found, stopping code.\n")
    cat("Download GSE270199_COL3A1_normalizedCounts.txt.gz from https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE270199. Unzip it and place it into the INPUT_FILE_LOCATION you specify in File locations.\nMakes sure that is is not renamed, if it is, modify the name back to the default or modify the code in this section.\n")
    stop()
  } else if (file.exists(paste0(INPUT_FILE_LOCATION,"/GSE270199_COL3A1_normalizedCounts.txt"))){
    cat("GSE270199_COL3A1_normalizedCounts.txt found \n")
  } else {
    warning("Something unknown went wrong\n")
  }
  
  if (!file.exists(paste0(INPUT_FILE_LOCATION,"/GSE270199_SraRunTable.csv"))){
    warning("GSE270199_SraRunTable.csv not found, stopping code. \n")
    cat("Download the Metadata of GSE270199_COL3A1_normalizedCounts.txt.gz from https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA1125404&o=acc_s%3Aa. Unzip it and place it into the INPUT_FILE_LOCATION you specify in File locations. \nRENAME IT TO \"GSE270199_SraRunTable.csv\" instead of \"SraRunTable.csv\" to prevent multiple files being named \"SraRunTable.csv\". \n")
    stop()
  } else if (file.exists(paste0(INPUT_FILE_LOCATION,"/GSE270199_SraRunTable.csv"))){
    cat("GSE270199_SraRunTable.csv found \n")
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### Can metadata  ###
### be found      ###
#####################
#TAG: Modify this check if time allows so it can be reused for the other data if it gets used.
Fun_GSE270199_meta_check <- function(){
  if (sum(colnames(GSE270199) %in% rownames(GSE270199.meta)) == ncol(GSE270199)){
    cat("All the colnames of GSE270199 are in the rownames of GSE270199.meta. \n")
  } else if (!sum(colnames(GSE270199) %in% rownames(GSE270199.meta)) == ncol(GSE270199)){
    waning("The the colnames of GSE270199 are NOT in the rownames of GSE270199.meta. \n ")
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### Can the data  ###
### be found      ###
#####################
#TAG: Modify this check if time allows so it can be reused for the other data if it gets used.
Fun_GEOD77758_findability_check <- function(){
  if (length(cels.HuGene) == 11) {
    cat("The expected amount of files were found for HuGenes (11 files found).\n")
  } else if (length(cels.HuGene) < 11){
    warning(paste0("Less than the expected amount of files were found for HuGenes (", length(cels.HuGene)," files found).\n"))
  } else {
    warning("Something unknown went wrong\n")
  }
  
  if (length(cels.miRNA) == 11) {
    cat("The expected amount of files were found for miRNA (11 files found).\n")
  } else if (length(cels.miRNA) < 11){
    warning(paste0("Less than the expected amount of files were found for miRNA (", length(cels.miRNA)," files found).\n"))
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### Can metadata  ###
### be found      ###
#####################
#TAG: Modify this check if time allows so it can be reused for the other data if it gets used.
Fun_GEOD77758_meta_check <- function(){
  #Check that the people in GEOD77758 are also in GEOD77758.meta
  if (sum(colnames(GEOD77758.HuGene) %in% rownames(GEOD77758.HuGene.meta)) == ncol(GEOD77758.HuGene)){
    cat("All the colnames of GEOD77758.HuGene are in the rownames of GEOD77758.HuGene.meta \n")
  } else if (!sum(colnames(GEOD77758.HuGene) %in% rownames(GEOD77758.HuGene.meta)) == ncol(GEOD77758.HuGene)){
    waning("The the colnames of GEOD77758.HuGene are NOT in the rownames of GEOD77758.HuGene.meta \n ")
  } else {
    warning("Something unknown went wrong\n")
  }
  
  #Check that the people in GEOD77758 are also in GEOD77758.meta
  if (sum(colnames(GEOD77758.miRNA) %in% rownames(GEOD77758.miRNA.meta)) == ncol(GEOD77758.miRNA)){
    cat("All the colnames of GEOD77758.miRNA are in the rownames of GEOD77758.miRNA.meta \n")
  } else if (!sum(colnames(GEOD77758.miRNA) %in% rownames(GEOD77758.miRNA.meta)) == ncol(GEOD77758.miRNA)){
    warning("The the colnames of GEOD77758.miRNA are NOT in the rownames of GEOD77758.miRNA.meta \n ")
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### Feedback      ###
#####################
cat("checks.R loaded.\n")