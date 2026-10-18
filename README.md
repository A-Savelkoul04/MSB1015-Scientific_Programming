# MSB1015-Scientific_Programming
Repository containing code written for the Scientific Programming course. 

# Software requirements
Code developed on Windows 11 using the software:

  R programming (version: 4.6.1)

  RStudio (version: 2026.08.2+200)

  Cytoscape (version: 3.10.3)

  stringApp extension to Cytoscape (version: 2.2.0)


# Files to run in order: 
MSB1015-GSE270199_LoadingAndCleaning.Rmd

MSB1015-GSE270199_Processing.Rmd


# Required files: 
checks.R

libraries.R

custom_functions.R

GSE270199_COL3A1_normalizedCounts.txt.gz

GSE270199_SraRunTable.csv


# Additional files (do not run)
MSB1015-GEOD77758_LoadingAndCleaning.Rmd <-- Other dataset

MSB1015-OldCode.Rmd <-- Fragements of discarded code, not cleaned


# Default input and output location
The working directory is set inside the code to the location of the file. All other files are assumed to be stored in reference to this. 

File paths use Windows-style navigation.

By default the code searches the working directory for maps called *INPUTS* and *OUTPUTS*. If OUTPUTS is not available it creates it in the working directory. 

# Download of files and location:
    # Download instructions also found in MSB1015-GSE270199_LoadingAndCleaning.Rmd
Download *GSE270199_COL3A1_normalizedCounts.txt.gz* from https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE270199. Unzip it and place it into the INPUT_FILE_LOCATION you specify in File locations. 

Download the Metadata of GSE270199_COL3A1_normalizedCounts.txt.gz from https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA1125404&o=acc_s%3Aa. Unzip it and place it into the INPUT_FILE_LOCATION you specify in File locations. 
*RENAME IT TO "GSE270199_SraRunTable.csv"* instead of "SraRunTable.csv" to prevent multiple files being names "SraRunTable.csv". (This was done with the assumption that I would be working with multiple datasets down the line)

*Unless specified otherwise, the code attempts to load in the above specified default names and locations of the files. If the names are changed in other ways then adjust the code in Load data.*

# General pipeline description in MSB1015-GSE270199_Processing.Rmd
    # Explanation also found inside the file
* Get a *similarity network* for the patients
* *Cluster* the patients using the similarity network
* Perform *Wilcoxon rank-sum test* on each feature

  --> p-value
  * Correct using *FDR*
* Get *log2FC* of each cluster vs the other using the median to better deal with outliers

  --> log2FC
  * Two ways:
      - *Compare the cluster to each other directly* 

        --> Up- / Downregulated in one group over the other

        --> Presumably gives less overlap as the nodes used for diffusion cannot overlap to begin with (either up- or downregulated)

      - (Not implemented) Compare the clusters to the controls and then to each other

        --> (Not implemented) Up- / Downregulated in reference to the controls, can then compare those to each other

        --> (Not implemented) Presumably finds more shared areas as a node can be up- / downregulated in both of the comparisons before the diffusion comparison between the groups
* Get a *selection of genes* to use for the network diffusion using filters
  * Get protein codes to give to STRING instead of ENSG codes
* Use *PCA* on only the EDS samples to build a *background network* that the selected nodes are diffused over
  * Get protein codes to give to STRING instead of ENSG codes
* *Diffuse* over the network and compare the clusters to each other

  --> Unique nodes for one cluster?

  --> Nodes that both clusters diffused to?

    * *INTERPRET*:

      --> (Not implemented) Unique nodes (only up or only down) could imply a different area of origin for some of the effects

      --> Shared diffused-to nodes could show that despite originating from different nodes, the same area of the PPI may be affected

# System the code was developed on
The system that the code was developed on was Windows 11 Pro version 25H2 

The R version used was 4.6.1

The RStudio version used was 2026.08.2+200

The Cytoscape version used was:

  Version: 3.10.3 

  Java: 17.0.5 by Eclipse Adoptium 

  OS: Windows 11 10.0 - amd64

The stringApp extension version used was v2.2.0


For R's sessionInfo information, please see the DevelopedOnSessionInfo.txt file available on the GitHub. 

# AI Transparency Statement
AI was used in the production of the code. Code was manually checked and adjusted to suit the needs of the project. 
AI was not used to comment the code or write the README. 
