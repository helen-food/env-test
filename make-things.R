
library(dplyr)
library(tidytext)
library(wordcloud)
library(purrr)
library(stringr)
library(reticulate)

# load data

articledata <- readRDS("data/articledata.rds")

# source R functions

source("R-functions.R")

# make the word cloud for titles

makeWordCloud(getWordCount(articledata, title))



# source python functions

source_python('python-functions.py')

# get parts of speech tagging for titles

getPOS(articledata, title)


