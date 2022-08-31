#' Get stability component for PPE
#'
#' @param times A list of times when an item was rehearsed
#' @return The stability component resulting from the list of times \code{times}
#' @examples
#' get_model_time(c(1, 2, 3, 4, 5))


get_stability <- function(time) {
  
  repetition <- seq_along(time)
  lag        <- c(Inf, diff(time))  # `lag` is Inf on first encounter
  stability  <- ifelse( repetition == 1, 0, cumsum( 1/(log(lag + exp(1))) ) / seq_along(lag) )
  stability  <- c(0, stability[-length(stability)]) # stability is a lagged variable
  
  return(stability)
}
