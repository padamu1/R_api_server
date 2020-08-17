library(plumber)
r <- plumb("./api_test.R")
r$run(port=8000)
