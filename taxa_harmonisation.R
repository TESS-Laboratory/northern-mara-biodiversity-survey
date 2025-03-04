# This script was used for harmonising floral species names against the WorldFlora database updated taxonomic names.
library(WorldFlora)
library(readxl)

file_path<- "data/plant_data_NM_2024.xlsx"
#head(species_data) # check the data 
species_data <- read_excel(file_path, sheet = 1)
species_data <- species_data[-2, ]
species_data <- as.data.frame(species_data) # convert data from tibble to dataframe 

# Load the WFO Backbone after manually downloading and extracting into the wd
# https://www.worldfloraonline.org/ #website to the onlide WorldFlora database
WFO.remember(WFO.file = "../classification.csv") 
#head(WFO.data)

# Matches the species list against the WFO database taxonomic names using the best matches.
harmonized_results <- WFO.match(
  spec.data = species_data,
  spec.name = "Species",
  WFO.file = "../classification.csv")


head(harmonized_results)

write.csv(harmonized_results, "data/harmonized_species_list.csv", row.names = FALSE)
