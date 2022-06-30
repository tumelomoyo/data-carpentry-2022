# TODO - cool stuff!

## Author: Your name here
## Date: 2022-06-30

## The aim of this script is to produce a table of species observation counts, and a bar plot
## showing the species counts for the most diverse genera in the survey



# Load libraries (make sure they are installed first!)

library(tidyverse)



# Get the data (load into R directly from the web)

surveys <- read_csv("https://ndownloader.figshare.com/files/2292169")


# Have a look at the structure of the data

str(surveys)



# Count number of observations of each species

species_counts <- surveys %>% 
  
  group_by(genus, species, species_id) %>% 
  
  count() %>% 
  
  arrange(genus, species)



# In the species present, count representative species of each genus

genus_counts <- species_counts %>% 
  
  group_by(genus) %>% 
  
  count(sort = TRUE)


# Chaetodipus, Dipodomys, and Reithrodontomys each had 4 species present



# Get counts of species in the 3 most-diverse genera

diverse_genus <- species_counts %>% 
  
  filter(genus %in% c('Chaetodipus', 'Dipodomys', 'Reithrodontomys')) %>% 
  
  arrange(desc(n))


# Save the table to file

write_csv(diverse_genus, 'output_species_count/species_counts_table.csv')


# Plot counts of observations for 3 most-diverse genera

ggplot(data = diverse_genus, mapping = aes(x = species_id, y = n, fill = genus)) +
  
  geom_bar(stat = 'identity') + 
  scale_fill_grey()


ggsave('output_species_count/species_counts_barplot.png')







