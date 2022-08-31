#' Get predicted accuracy for PPE
#'
#' @param data A data frame that includes PPE inputs (repeition, stability, and model time)
#' @param x A list of parameter values (b, m, s, tau.1, tau.2, tau.3) for converting PPE inputs to probability of retrieval
#' @return The probability of retrieval from applying the parameter values \code{params} to the PPE inputs contained in \code{input}
#' @examples
#' get_model_prob_tau(df, params)


get_model_prob_tau <- function(data, params, c = .1) {
  
  data <- data %>%
    mutate(c = .1,
           b = params$b,
           m = params$m,
           s = params$s,
           tau = case_when(format == 'Listen'    ~ params$tau.1,
                           format == 'Select'    ~ params$tau.2,
                           format == 'Translate' ~ params$tau.3))
  
  with(data,
       1/(1 + exp((tau - (((repetition-1)^c) * (model.time^(-(b + m*stability)))))/s)))
  
}