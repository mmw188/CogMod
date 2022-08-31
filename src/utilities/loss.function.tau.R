#' Compute loss function while varying tau
#'
#' @param data A data frame that includes PPE inputs (repetition, stability, and model time) and outcome (score)
#' @param params A list of parameter values (b, m, tau.1, tau.2, tau.3, and S) for converting PPE inputs to probability of retrieval
#' @return Evaluation of the loss function given the parameter values contained in \code{param} and model inputs contained in \code{data}
#' @examples
#' loss_function_tau(df, params, error_function, eps)


loss_function_tau <- function(data, par, error_function = NULL, eps = 2^-52) {
  
  params = list(b = par[1], m = par[2], tau.1 = par[3], tau.2 = par[4], tau.3 = par[5], s = par[6])
  output <- get_model_prob_tau(data, params)
  
  if (error_function == 'log_likelihood'){
    
    le <- dbinom(data$score, 1, output)
    le[le < eps] <- eps
    le[le > 1-eps] <- 1-eps
    eval.loss <- -sum( log(le), na.rm = TRUE ) ## Negative log-likelihood
    
  } else if (error_function == 'sum_sq_error'){
    eval.loss <- sum( (data$score - output)^2, na.rm = TRUE ) ## Sum of squared errors
    
  } else {
    stop(paste('Error function', error_function, 'not recognizied', sep = ' '))
  }
}