#' Get model time component for PPE
#'
#' @param times A list of times when an item was rehearsed
#' @param x A parameter for weighting more recent repetitions
#' @return The time-based component resulting from applying the parameter \code{x} to the list of times \code{times}
#' @examples
#' get_model_time(c(1, 2, 3, 4, 5), x = .6)


get_model_time <- function(times, x = .6) {
  
  ### INPUT CHECKING. Time must be increasing
  # Check that time stamps are increasing
  if (min(diff(times)) <= 0)
    stop("Timestamps must be monotonically increasing")
  
  sapply(seq_along(times), function(i) {
    if(i == 1) return(1) # For first instance, model time should be 1
    diff_prev <- times[i] - times[1:i-1]
    sum( (diff_prev^-x / sum( diff_prev^-x )) * diff_prev ) 
  }) 
}