#' Get predicted accuracy for PPE
#'
#' @param tau Value of tau parameter
#' @param repetition Vector of number of item repetitions
#' @param model.time Vector of model times
#' @param b Value of b parameter
#' @param m Value of m parameter
#' @param stability Value of stability parameter
#' @param s Value of s parameter
#' @return The probability of retrieval from applying the parameter values to model inputs
#' @examples
#' get_model_prob(tau, repetition, model.time, b, m, stability, s)

pred.ppe.tau <- function(tau, repetition, model.time, b, m, stability, s){
  1/(1 + exp((tau - (((repetition-1)^.1) * (model.time^(-(b + m*stability)))))/s))
}
