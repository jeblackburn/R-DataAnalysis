myfunction <- function() {
  x <- rnorm(100)
  mean(x)
}

mf2 <- function() {
  x + rnorm(length(x))
}