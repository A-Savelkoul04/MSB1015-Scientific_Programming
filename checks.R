
############################################################
##########                                        ##########
##########  This is the checks file containing    ##########
##########  the checks functions to prevent       ##########
##########  bloating the main file                ##########
##########                                        ##########
############################################################
#This file has various checks in it that make the main script 
# look bloated while just adding some feedback, so they have 
# been placed in this seperate R script.

#TAG: If time allows split this into two files to have the
# global environment cleaner per file instead of loading all
# the checks even when they are not needed.
#NOTE: Did not have time

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
#Settings check for the first file
Fun_settings_check1 <- function(){
  #In section: All
  #RUN_PLOTS needs to be TRUE or FALSE
  if (RUN_PLOTS == TRUE | RUN_PLOTS == FALSE){
    cat("RUN_PLOTS has a valid value.\n")
  } else {
    warning("RUN_PLOTS does NOT have a valid value.\nStopping code.\n")
    stop()
  }
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
  #In section: imputation
  #IMPUTE_MISSING needs to be TRUE or FALSE
  if (IMPUTE_MISSING == TRUE | IMPUTE_MISSING == FALSE){
    cat("IMPUTE_MISSING has a valid value.\n")
  } else {
    warning("IMPUTE_MISSING does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #IMPUTE_ZEROS needs to be TRUE or FALSE
  if (IMPUTE_ZEROS == TRUE | IMPUTE_ZEROS == FALSE){
    cat("IMPUTE_ZEROS has a valid value.\n")
  } else {
    warning("IMPUTE_ZEROS does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #zeros_for_imputation_EDS needs to be a number and be between (inclusive) 0 and 10.
  #TAG: Update this check and the code that handles this to a percentage instead (allows it to act more dynamic) if time allows.
  #NOTE: Did not have time
  if (is.numeric(zeros_for_imputation_EDS) & 0 <= zeros_for_imputation_EDS & zeros_for_imputation_EDS <= 10){
    cat("zeros_for_imputation_EDS has a valid value.\n")
  } else {
    warning("zeros_for_imputation_EDS does NOT have a valid value.\nStopping code.\n")
    stop()
  }  
  #zeros_for_imputation_healthy needs to be a number and be between (inclusive) 0 and 4.
  #TAG: Update this check and the code that handles this to a percentage instead (allows it to act more dynamic) if time allows.
  #NOTE: Did not have time
  if (is.numeric(zeros_for_imputation_healthy) & 0 <= zeros_for_imputation_healthy & zeros_for_imputation_healthy <= 4){
    cat("zeros_for_imputation_healthy has a valid value.\n")
  } else {
    warning("zeros_for_imputation_healthy does NOT have a valid value.\nStopping code.\n")
    stop()
  }   
  #-----#
  #In section: inferred_sex
  #QUERY_ENSEMBL needs to be TRUE or FALSE
  if (QUERY_ENSEMBL == TRUE | QUERY_ENSEMBL == FALSE){
    cat("QUERY_ENSEMBL has a valid value.\n")
  } else {
    warning("QUERY_ENSEMBL does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #OVERRIDE_Y_CHRO_SAVED_FILE needs to be TRUE or FALSE
  if (OVERRIDE_Y_CHRO_SAVED_FILE == TRUE | OVERRIDE_Y_CHRO_SAVED_FILE == FALSE){
    cat("OVERRIDE_Y_CHRO_SAVED_FILE has a valid value.\n")
  } else {
    warning("OVERRIDE_Y_CHRO_SAVED_FILE does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  
}
#Settings check for the second file
Fun_settings_check2 <- function(){
  #In section: All
  #RUN_PLOTS needs to be TRUE or FALSE
  if (RUN_PLOTS == TRUE | RUN_PLOTS == FALSE){
    cat("RUN_PLOTS has a valid value.\n")
  } else {
    warning("RUN_PLOTS does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #In section: pca_on_disease
  #USE_CUMULATIVE_VARIANCE needs to be TRUE or FALSE
  if (USE_CUMULATIVE_VARIANCE == TRUE | USE_CUMULATIVE_VARIANCE == FALSE){
    cat("USE_CUMULATIVE_VARIANCE has a valid value.\n")
  } else {
    warning("USE_CUMULATIVE_VARIANCE does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #In section: cytoscape_selected_network
  #VISUALIZE_SELECTED_NETWORK needs to be TRUE or FALSE
  if (VISUALIZE_SELECTED_NETWORK == TRUE | VISUALIZE_SELECTED_NETWORK == FALSE){
    cat("VISUALIZE_SELECTED_NETWORK has a valid value.\n")
  } else {
    warning("VISUALIZE_SELECTED_NETWORK does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  #In section: remove_singletons
  #REMOVE_ALL_SINGLETONS needs to be TRUE or FALSE
  if (REMOVE_ALL_SINGLETONS == TRUE | REMOVE_ALL_SINGLETONS == FALSE){
    cat("REMOVE_ALL_SINGLETONS has a valid value.\n")
  } else {
    warning("REMOVE_ALL_SINGLETONS does NOT have a valid value.\nStopping code.\n")
    stop()
  }
  
  #similarity_merge_value needs to be double or NULL
  if (is.null(similarity_merge_value) | is.double(similarity_merge_value)){
    cat("similarity_merge_value has a valid value.\n")
  } else {
    warning("similarity_merge_value does NOT have a valid value.\nPlease provide a double or NULL as input.\nStopping code.\n")
    stop()
  }
  
  
}

#####################
### Can the data  ###
### be found      ###
#####################
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
### Feedback      ###
#####################
cat("checks.R loaded.\n")