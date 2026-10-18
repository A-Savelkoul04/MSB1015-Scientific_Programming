
############################################################
##########                                        ##########
##########  This is the library file used         ##########
##########  to download and load the libraries    ##########
##########                                        ##########
############################################################

#To reduce bloat in the setup section of the two files the library installations
# and loading are done using two functions loaded in using this file.
#This also means that all the libraries are found in a single location. Especially
# in the Fun_load_libraries function below it is easily seen what libraries are loaded 
# into the environment all in one place.

#####################
### Download      ###
#####################
#Function to download the libraries
Fun_install_libraries <- function(){
  cat("Attempting to check for and download the various libraries.\n")
  
  if (!require("rmarkdown", quietly = TRUE)){
    install.packages("rmarkdown")}
  if (!require("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")}
  if (!require("dplyr", quietly = TRUE)){
    install.packages("dplyr")}
  if (!require("affy", quietly = TRUE)){
    BiocManager::install("affy")}
  if (!require("oligo", quietly = TRUE)){
    BiocManager::install("oligo")}
  if (!require("ggplot2", quietly = TRUE)){
    install.packages("ggplot2")}
  if (!require("ggtext", quietly = TRUE)){
    install.packages("ggtext")}
  if (!require("naniar", quietly = TRUE)){
    install.packages("naniar")}
  if (!require("pcaMethods", quietly = TRUE)){
    BiocManager::install("pcaMethods")}
  if (!require("dplyr", quietly = TRUE)){
    BiocManager::install("dplyr")  }
  if (!require("tibble", quietly = TRUE)){
    BiocManager::install("tibble")  }
  if (!requireNamespace("RCy3", quietly = TRUE)) {
    BiocManager::install("RCy3")}
  if (!requireNamespace("biomaRt", quietly = TRUE)) {
    BiocManager::install("biomaRt")}
  if (!requireNamespace("org.Hs.eg.db", quietly = TRUE)) {
    BiocManager::install("org.Hs.eg.db")}
  if (!requireNamespace("AnnotationDbi", quietly = TRUE)) {
    BiocManager::install("AnnotationDbi")}
  if (!require("proxy", quietly = TRUE)){
    install.packages("proxy")}
  if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
    BiocManager::install("EnhancedVolcano")}
  if (!require("gprofiler2", quietly = TRUE)){
    install.packages("gprofiler2")}
  if (!require("httr", quietly = TRUE)){
    install.packages("httr")}
  if (!require("jsonlite", quietly = TRUE)){
    install.packages("jsonlite")}
  
  cat("Ran through the Fun_install_libraries function.\n")
}

#####################
### Load          ###
#####################
#Function to load the libraries
Fun_load_libraries <- function(){
  cat("Attempting to load the various libraries.\n")
  
  #To load in .CELL files
  library(affy)
  library(oligo) #Specifically for oligonucleotide
  
  library(dplyr)
  library(ggplot2)
  library(ggtext)
  library(naniar)
  library(pcaMethods)
  library(dplyr)
  library(tibble)
  library(RCy3)
  library(biomaRt)
  library(org.Hs.eg.db)
  library(AnnotationDbi)
  library(proxy)
  library(EnhancedVolcano)
  library(gprofiler2)
  library(httr)
  library(jsonlite)
  
  cat("Ran through the Fun_load_libraries function.\n")
}


#####################
### Feedback      ###
#####################

cat("libraries.R loaded.\n")

