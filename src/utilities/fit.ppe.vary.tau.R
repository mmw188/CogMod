#' Fit PPE using MLE
#'
#' @param dat A data frame that includes PPE inputs (repeition, stability, and model time) and performance (score)
#' @param params A list of starting parameter values (c, m, tau, and S) for converting PPE inputs to probability of retrieval
#' @param error_function A named error function
#' @param lower_bounds Lower bounds for parameter values (c, m, tau, and S)
#' @param upper_bounds Upper bounds for parameter values (c, m, tau, and S)
#' @return parameter values to minimize the user-specified error function \code{error_function} given model inputs and observations in \code{dat}
#' @examples
#' fit_ppe_vary_tau(df, error_function = 'sum_sq_error')

fit_ppe_vary_tau <- function(data, params = NULL, error_function = NULL, warn_me = FALSE, lower_bounds = NULL, upper_bounds = NULL) { 
  
  ### DATAFRAME CHECKING
  # Check that there is a column called `repetition`.
  if(!"repetition" %in% colnames(data)) 
    stop("The input `data` needs to contain a column called `repetition`!")
  
  # Check that there is a column called `model.time`.
  if(!"model.time" %in% colnames(data)) 
    stop("The input `data` needs to contain a column called `model.time`!")
  
  # Check that there is a column called `score`.
  if(!"score" %in% colnames(data)) 
    stop("The input `data` needs to contain a column called `score`!")
  
  ### ERROR FUNCTION CHECKING
  # Test whether the specified error function exists:
  if(! error_function %in% c('log_likelihood', 'sum_sq_error')) {
    stop(paste('Error function', error_function, 'not recognizied', sep = ' '))
  }
  
  # Must be in order: b, m, tau1, tau2, tau3, s...
  free_pars <- c(params$b, params$m, params$tau.1, params$tau.2, params$tau.3, params$s)
  
  if(is.null(lower_bounds)) {
    # Bounds not supplied, use defaults:
    lower_bounds <- rep(2^-52, 6)
  }
  
  if(is.null(upper_bounds)) {
    # Bounds not supplied, use defaults:
    upper_bounds <- c(0.50, 0.50, .999, .999, .999, .3) # b, m, tau, s
  }
  
  opti <- optim(
    par = params,                    # Pass the start values
    fn = loss_function_tau,          # convert string of name of function to an R expression:
    data = data,                     # Pass the dataframe
    error_function = error_function, # Pass error function
    lower = lower_bounds,            # Pass lower bounds
    upper = upper_bounds,            # Pass upper bounds
    gr = NULL,
    method = "L-BFGS-B",
    control = list(factr = 1e7)
  )
  
  # Make sure convergence is okay, see ?optim for details
  if(opti$convergence != 0 & warn_me) {
    message(paste("Warning from optim:", opti$message))
  }
  
  o <- matrix(c(opti$par, opti$value), 
              ncol = length(opti$par) + 1, 
              dimnames = list(NULL, c("b", "m", "tau.1", "tau.2", "tau.3", "s", "error")))
  
  return( as_tibble(o) )
}