
############################################################
##########                                        ##########
##########  This is the library file used         ##########
##########  to download and load the libraries    ##########
##########                                        ##########
############################################################

#####################
### Download      ###
#####################
#Function to download the libraries
Fun_install_libraries <- function(){
  cat("Attempting to check for and download the various libraries.\n")
  
  if (!require("rmarkdown", quietly = TRUE))
    install.packages("rmarkdown")
  if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  if (!require("dplyr", quietly = TRUE))
    install.packages("dplyr")
  if (!require("affy", quietly = TRUE))
    BiocManager::install("affy")
  if (!require("oligo", quietly = TRUE))
    BiocManager::install("oligo")
  if (!require("ggplot2", quietly = TRUE))
    install.packages("ggplot2")
  if (!require("ggtext", quietly = TRUE))
    install.packages("ggtext")
  if (!require("naniar", quietly = TRUE))
    install.packages("naniar")
  if (!require("pcaMethods", quietly = TRUE))
    BiocManager::install("pcaMethods")
  if (!require("dplyr", quietly = TRUE))
    BiocManager::install("dplyr")  
  if (!require("tibble", quietly = TRUE))
    BiocManager::install("tibble")  
  if (!requireNamespace("RCy3", quietly = TRUE)) {
    BiocManager::install("RCy3")}

  
  if (!requireNamespace("randomForest", quietly = TRUE)) {
    BiocManager::install("randomForest")}
  if (!requireNamespace("factoextra", quietly = TRUE)) {
    install.packages("factoextra")}
  
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

  #library(pcadapt)
  #library(hugene10stv1cdf)
  
  #From Agi's functions:
  library(randomForest)
  library(factoextra)
  
  cat("Ran through the Fun_load_libraries function.\n")
}


#####################
### Feedback      ###
#####################

cat("libraries.R loaded.\n")

