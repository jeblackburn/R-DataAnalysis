corr <- function(directory, threshold = 0L) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  source('complete.R')
  filenames = list.files(directory)
  fullfilenames = list.files(directory, full.names=TRUE)
  ##str(fullfilenames)
  monitors <- sapply(filenames, function(fn) {simplify2array(strsplit(fn, '.', fixed=TRUE))[1]})
  namesandnumbers <- complete(directory, monitors)
  abovethreshold <- namesandnumbers$nobs > threshold

  correlate <- function(fz) {
    data <- read.csv(fz)
    cor(data$sulfate, y=data$nitrate, use="na.or.complete")
  }
  
  correlations <- simplify2array(lapply(fullfilenames, correlate))
#  print(correlations)
#  str(correlations)
#  correlations
  goodCorrelations <- split(correlations, abovethreshold)
  goodCorrelations[['TRUE']]
  
}