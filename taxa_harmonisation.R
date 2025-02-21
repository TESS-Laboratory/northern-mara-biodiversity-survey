# This script was used for harmonising floral species names against the WorldFlora database updated taxonomic names.
library(WorldFlora)
library(readxl)

species_data <- read_excel("data/species_checklist.xlsx")
#head(species_data) # check the data 
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

duplicated_rows <- harmonized_results[duplicated(harmonized_results$Species), ]
# Remove duplicates
harmonized_results <- harmonized_results[!duplicated(harmonized_results$Species), ]

write.csv(harmonized_results, "data/harmonized_species_list.csv", row.names = FALSE)
