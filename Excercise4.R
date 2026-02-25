```{r}
#| eval: false

#data sets called in 
d <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/collins-scrabble-words-2019.txt"
s <- "https://raw.githubusercontent.com/difiore/ada-datasets/refs/heads/main/google-10000-english-usa-no-swears.txt"

#reading data sets (word lists)
load_dictionary <- function(filename) {
  table <- read.table(filename, header=TRUE)
  as.vector(table[,1])}

# ... [Keep your data loading code, but add toupper] ...
valid_list <- toupper(load_dictionary(d))
solution_list <- toupper(load_dictionary(s))
valid_solution_list <- intersect(solution_list, valid_list)

# Pick a 5-letter word and keep it as a string for comparison
pick_solution <- Filter(function(x) nchar(x) == 5, valid_solution_list)
solution <- sample(pick_solution, 1) 

play_wordle <- function(solution, valid_list, num_guesses = 6) {
  letters_left <- LETTERS
  sol_split <- strsplit(solution, "")[[1]] # Split for comparison
  
  for (i in 1:num_guesses) {
    cat("\nAttempt", i, "of", num_guesses, "| Letters left:", letters_left, "\n")
    guess <- toupper(readline(prompt="Enter a 5-letter word: "))
    
    if (nchar(guess) != 5 | !(guess %in% valid_list)) {
      cat("Invalid word. Try again.\n")
      next
    }
    
    guess_split <- strsplit(guess, "")[[1]]
    feedback <- rep("-", 5)
    
    # Logic for Green and Yellow
    for (j in 1:5) {
      if (guess_split[j] == sol_split[j]) {
        feedback[j] <- "*" # Green (Right place)
      } else if (guess_split[j] %in% sol_split) {
        feedback[j] <- "+" # Yellow (Wrong place)
      }
    }
    
    cat("Feedback: ", feedback, "\n")
    letters_left <- setdiff(letters_left, guess_split)
    
    if (guess == solution) {
      cat("✨ Correct! You won! ✨\n")
      return(TRUE)
    }
  }
  cat("Game Over. The word was:", solution, "\n")
}

play_wordle(solution, valid_list)
```