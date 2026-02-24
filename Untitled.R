library(tidyverse)


d <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/collins-scrabble-words-2019.txt"
s <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/google-10000-english-usa-no-swears.txt"




load_dictionary <- function(filename) {
 table <- read.table(filename, header=TRUE)
  as.vector(table[,1])}

solution_list <- load_dictionary(s)
valid_list <- load_dictionary(d)

str(valid_list)
str(solution_list)

intersect(solution_list, valid_list)




