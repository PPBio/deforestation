######################################################################
## Code to build graphic Brazil exportation data from 1997 - 2022
## Author : Tainá Rocha
## R verison 4.2.2
## Rstudio version RStudio 2022.12.0+353 "Elsbeth Geranium" Release 
## Date: 08 February 2023
## Last update: -
######################################################################

## Pcks

library(dplyr)
library(ggplot2)
library(readr)

## Read the data 

export = readr::read_csv("data/exportBR_97_22.csv")

# Filter the data for the desired years
export_filtered <- export %>%
  filter(coAno >= 1997 & coAno <= 2022)

# Group the data by year and product
df_grouped <- export_filtered %>%
  group_by(Year = coAno, noSh4pt) %>%
  summarize(Exportation_USD = sum(vlFob))

# Select the top 5 most exported products
df_top_5 <- df_grouped %>%
  top_n(5, Exportation_USD)

# Plot the data
ggplot(df_top_5, aes(x = Year, y = Exportation_USD, color = noSh4pt, group = noSh4pt)) +
  geom_line() +
  labs(x = "Year", y = "Exportation USD", color = "Product", title = "Temporal Series of Most Exported Products") +
  theme_minimal()


