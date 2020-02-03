
# function to make a word count table from clean data

getWordCount <- function(data, var) {
  data %>%
    select({{var}}) %>%
    filter(!is.na({{var}})) %>%
    unnest_tokens(word, {{var}}) %>%
    count(word) %>%
    anti_join(stop_words) %>%
    # filter out words we expect to see
    filter(!word %in% c("microbiome", "flora", "gut", "microbiota", "human", "bacteria",
                        "bacterial", "cell", "cells", "microbial")) %>%
    # filter out generic article words
    filter(!word %in% c("fig", "figure", "table", "section", "data", "analysis",
                        "method", "study", "studies", "research", "effect",
                        "background", "sample", "samples", "conclusion")) %>%
    # filter out anything that is just a number
    filter(!grepl("[[:digit:]]", word)) %>%
    mutate(word = iconv(word, to = "ASCII")) %>%
    arrange(desc(n))
}

# function to make a word cloud from a word count table

makeWordCloud <- function(words) {
  wordcloud(words = words$word,
            freq = words$n,
            scale = c(4,1),
            min.freq = 20,
            max.words=200, random.order=FALSE,
            random.color = FALSE, rot.per = 0,
            colors=brewer.pal(7, "Greens"))
}

# function to return part of speech tagging for a given column in a given dataset

getPOS <- function(data, var) {
  
  # make column into a list to pass to python function
  
  itemlist <- data %>%
    select({{var}}) %>%
    filter(!is.na({{var}})) %>%
    as.list() %>%
    pluck(1) %>%
    str_replace_all(., "[^A-z ]", " ")
  
  # these will be the names of the table that is created
  
  newnames <- c("text","lemma","pos","tag","dep","shape","alpha","stop")
  
  # get attributes for each title
  
  get_token_attributes(itemlist) %>%
    map(., ~set_names(., newnames)) %>%
    bind_rows() 
}


