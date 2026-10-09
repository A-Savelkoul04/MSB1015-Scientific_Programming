############################################################
##########                                        ##########
##########  This is the functions file            ##########
##########  containing custom functions           ##########
##########                                        ##########
############################################################

#####################
### NA values     ###
#####################

Fun_NA_check <- function(object, object_name){
  if (!(NA %in% object)){
    cat(paste0("There are no \"NA\" values in ", object_name,".\n"))
  } else if (NA %in% object){
    warning(paste0("There are \"NA\" values in ", object_name,".\n"))
  } else {
    warning("Something unknown went wrong\n")
  }
}

#####################
### zero values   ###
#####################

Fun_zero_check <- function(object, object_name){
  cat(paste0("There are ", sum(object == 0), " zero values in ",object_name, ".\n",
             "That is ", 
             round((sum(object == 0)/(ncol(object) * nrow(object)))*100, 2), 
             "% of the data.\n"))
}

#####################
### smallest value###
#####################

Fun_smallest_value <- function(object, object_name){
  cat(paste0("The smallest value in ",object_name," (ignorming zeros) is ", min(object[object != 0]),"."))
}

#####################
### Missingness   ###
#####################

#Custom function to visualize the missingness plot in a single line
Fun_missingness <- function(data, color_groups = NULL, title = NULL){
  
  #If the color_groups are not given, set them back to black
  if (is.null(color_groups)){
    color_groups <- rep("black", ncol(data))
  }
  
  #Set the zeros in the data to NA for visualization in the missingness plot
  data <- data
  data[data == 0] <- NA
  
  #Plot the missingness
  vis_miss(data, warn_large_data=TRUE, sort_miss = FALSE) +
    theme(axis.text.x = element_text(size = 5, angle = 90, colour = color_groups)) +
    ggtitle(title)
}

#####################
### Imputation    ###
#####################

#Custom loop to impute data of GSE270199
Fun_impute_data <- function(data.imputation, 
                            allow_zeros_EDS = allow_zeros_EDS, 
                            allow_zeros_healthy = allow_zeros_healthy,
                            IMPUTE_TO_ZERO = FALSE,
                            zeros_for_imputation_EDS = NULL,
                            zeros_for_imputation_healthy = NULL
){
  if (is.null(zeros_for_imputation_EDS)){
    zeros_for_imputation_EDS <- length(EDS_group) - allow_zeros_EDS
  }
  
  if (is.null(zeros_for_imputation_healthy)){
    zeros_for_imputation_healthy <- length(healthy_group) - allow_zeros_healthy
  }
  
  #Loop over data.imputation to find the ones that have too many zeros
  keep_either <- NULL
  keep_both <- NULL
  
  for (i in 1:nrow(data.imputation)){
    
    #Is there something that needs imputation (are there 1 or more zeros)?
    impute_EDS          <- sum(data.imputation[i,EDS_group] == 0) >= 1
    #Does it pass the threshold to impute values to zero?
    #Ex: Set to 8 means that if 8 out of 10 values are zero, the remaining 2 get set to zero as well. 
    impute_zero_EDS     <- sum(data.imputation[i,EDS_group] == 0) >= zeros_for_imputation_EDS
    #Does it pass the threshold to impute values with the average?
    keep_EDS            <- sum(data.imputation[i,EDS_group] == 0) <= allow_zeros_EDS
    
    #Is there something that needs imputation (are there 1 or more zeros)?
    impute_healthy      <- sum(data.imputation[i,healthy_group] == 0) >= 1
    #Does it pass the threshold to impute values to zero?
    #Ex: Set to 3 means that if 3 out of 4 values are zero, the remaining 1 gets set to zero as well. 
    impute_zero_healthy <- sum(data.imputation[i,healthy_group] == 0) >= zeros_for_imputation_healthy
    #Does it pass the threshold to impute values with the average?
    keep_healthy        <- sum(data.imputation[i,healthy_group] == 0) <= allow_zeros_healthy
    
    
    if (impute_healthy & keep_healthy)   {
      #If the data is tagged to be kept and has points to be imputed, impute the points.
      #Calculate the average from the remaining values within the group
      avr_healthy <- rowSums(data.imputation[i,healthy_group]) / sum(data.imputation[i,healthy_group] != 0)
      #Get the identifiers of the within-group zeros
      data.imputation[i, healthy_group[data.imputation[i,healthy_group] == 0]] <- as.numeric(avr_healthy)*0.8
    } else if (IMPUTE_TO_ZERO & impute_healthy & impute_zero_healthy){
      #IMPUTE_TO_ZERO --> Does the function call say to impute to zeros
      #impute_healthy --> Is there something that needs imputation (is there a zero in the data).
      #impute_zero_healthy --> Are there the amount of zeros that imputing everything to zero makes sense.
      data.imputation[i, healthy_group] <- 0
    }
    
    if (impute_EDS & keep_EDS)   {
      #If the data is tagged to be kept and has points to be imputed, impute the points.
      #Calculate the average from the remaining values within the group
      avr_EDS <- rowSums(data.imputation[i,EDS_group]) / sum(data.imputation[i,EDS_group] != 0)
      #Get the identifiers of the within-group zeros
      data.imputation[i, EDS_group[data.imputation[i,EDS_group] == 0]] <- as.numeric(avr_EDS)*0.8
    } else if (IMPUTE_TO_ZERO & impute_EDS & impute_zero_EDS){
      #IMPUTE_TO_ZERO --> Does the function call say to impute to zeros
      #impute_EDS --> Is there something that needs imputation (is there a zero in the data).
      #impute_zero_EDS --> Are there the amount of zeros that imputing everything to zero makes sense.
      data.imputation[i, EDS_group] <- 0
    }
    
  }
  return(data.imputation)
}

#####################
### Plot PCA      ###
### scores        ###
#####################
Fun_plot_PCA_scores <- function(PCA, metadata = GSE270199.redmeta, firstPC = "PC1", secondPC = "PC2", title = NULL){
  PCA.scores <- PCA@scores
  PCA.scores <- as.data.frame(PCA.scores)
  PCA.scores <- merge(x = PCA.scores, y = metadata, by = 'row.names')
  
  ggplot(PCA.scores, aes(x=eval(parse(text=firstPC)), y=eval(parse(text=secondPC)), color = disease_state, fill = inferred_sex, label=Row.names)) +
    geom_point(shape = 21) + 
    scale_color_manual(values=c("#F8766D", "#00BFC4")) +
    scale_fill_manual(values=c("red", "black")) +
    geom_text(hjust=0, vjust=0) +
    labs(x = paste0(firstPC,": ", as.numeric(PCA@R2[firstPC])*100,"%"), 
         y = paste0(secondPC,": ", as.numeric(PCA@R2[secondPC])*100,"%"),
         title = title)
}

#####################
### Plot PCA      ###
### loadings      ###
#####################
Fun_plot_PCA_loadings <- function(PCA, firstPC = "PC1", secondPC = "PC2", title = NULL){
  PCA.loadings <- PCA@loadings
  PCA.loadings <- as.data.frame(PCA.loadings)
  
  ggplot(PCA.loadings, aes(x=eval(parse(text=firstPC)), y=eval(parse(text=secondPC)))) +
    geom_point() +
    labs(x = paste0(firstPC,": ", as.numeric(PCA@R2[firstPC])*100,"%"), 
         y = paste0(secondPC,": ", as.numeric(PCA@R2[secondPC])*100,"%"),
         title = title)
}


#####################
### Plot PCA      ###
### biplot        ###
#####################

Fun_plot_biplot <- function(PCA, 
                            metadata = GSE270199.redmeta, 
                            firstPC = "PC1", 
                            secondPC = "PC2", 
                            top = 20,
                            title = NULL){
  #I declare that I made use of ChatGPT to help make some of this code and then manually modified it to my liking. 
  
  #Get the scores
  PCA.scores <- PCA@scores
  PCA.scores <- as.data.frame(PCA.scores)
  #Add sample information
  PCA.scores <- merge(x = PCA.scores, y = metadata, by = 'row.names')
  
  #Get the loadings
  PCA.loadings <- PCA@loadings
  PCA.loadings <- as.data.frame(PCA.loadings)
  
  # Keep gene names explicitly 
  PCA.loadings$gene <- rownames(PCA.loadings)
  
  # Select genes based on combined contribution to PC1 and PC2
  top_loadings <- PCA.loadings %>%
    mutate(
      contribution = sqrt(eval(parse(text=firstPC))^2 + eval(parse(text=secondPC))^2)
    ) %>%
    arrange(desc(contribution)) %>%
    head(top)
  
  # Scale loadings to match the score plot
  loading_scale <- max(
    abs(PCA.scores[[firstPC]]),
    abs(PCA.scores[[secondPC]])
  ) / max(
    abs(top_loadings[[firstPC]]),
    abs(top_loadings[[secondPC]])
  )
  
  top_loadings <- top_loadings %>%
    mutate(
      firstPC_scaled = eval(parse(text=firstPC)) * loading_scale,
      secondPC_scaled = eval(parse(text=secondPC)) * loading_scale
    )
  
  
  ggplot(PCA.scores, aes(eval(parse(text=firstPC)), eval(parse(text=secondPC)))) +
    geom_point(shape = 21, aes(color = disease_state, fill = inferred_sex)) +
    scale_color_manual(values=c("#F8766D", "#00BFC4")) +
    scale_fill_manual(values=c("red", "black")) +
    labs(x = paste0(firstPC,": ", as.numeric(PCA@R2["PC1"])*100,"%"), 
         y = paste0(secondPC,": ", as.numeric(PCA@R2["PC2"])*100,"%"),
         title = title) +
    geom_segment(
      data = top_loadings,
      aes(x = 0, y = 0, xend = firstPC_scaled, yend = secondPC_scaled),
      arrow = arrow(length = unit(0.25, "cm"), type = "open"),
      color = "red", alpha = 0.5) +
    
    # Gene labels 
    geom_text(data = top_loadings, 
              aes( x = firstPC_scaled, y = secondPC_scaled, label = gene ), 
              inherit.aes = TRUE, 
              hjust = 0, vjust = 0, size = 2 ) + 
    # Reference lines 
    geom_hline( yintercept = 0, linetype = "dashed", alpha = 0.5 ) + 
    geom_vline( xintercept = 0, linetype = "dashed", alpha = 0.5 )
  
}

#####################
### Feedback      ###
#####################

cat("custom_functions.R loaded.\n")