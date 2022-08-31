plot.lag.acc <- function(df, resp.form){
  
  df <- filter(df, format == resp.form)
  
  p <- ggplot(df, aes(x = x.val, y = accuracy, color = language, fill = language)) +
    geom_ribbon(aes(ymin = accuracy-se, ymax = accuracy+se), alpha = .25, color = NA) +
    geom_line() +
    geom_point() +
    scale_x_continuous(name = 'Delay', limits = c(0, 5), breaks = 0:5, labels = unique(df$lag_cat)) +
    scale_y_continuous(name = 'Accuracy (%)', limits = c(.6, 1), breaks = c(.6, .7, .8, .9, 1), labels = scales::percent) +
    ggtitle(resp.form) +
    scale_color_brewer(palette = 'Set1') +
    scale_fill_brewer(palette = 'Set1') +
    theme_bw() +
    theme(axis.text    = element_text(family = 'Arial', size = 10),
          plot.title   = element_text(family = 'Arial', size = 10, hjust = 0.5),
          legend.title = element_blank(),
          legend.text  = element_text(family = 'Arial', size = 10),
          legend.position = 'bottom')
  
  if (resp.form != 'Translate'){
    p <- p + theme(axis.title.x = element_blank(),
                   axis.text.x  = element_blank(),
                   axis.ticks.x = element_blank())
  }
  p
  
}

plot.rep.acc <- function(df, resp.form){
  
  df <- filter(df, format == resp.form)
  
  p <- ggplot(df, aes(x = repetition, y = accuracy, color = language, fill = language)) +
    geom_ribbon(aes(ymin = accuracy-se, ymax = accuracy+se), alpha = .25, color = NA) +
    geom_line() +
    geom_point() +
    scale_x_continuous(name = 'Repetition', limits = c(0, 20), breaks = c(0, 5, 10, 15, 20), labels = c('0', '5', '10', '15', '20+')) +
    scale_y_continuous(name = 'Accuracy (%)', limits = c(.6, 1), breaks = c(.6, .7, .8, .9, 1.0), labels = scales::percent) +
    ggtitle(resp.form) +
    scale_color_brewer(palette = 'Set1') +
    scale_fill_brewer(palette = 'Set1') +
    theme_bw() +
    theme(axis.text    = element_text(family = 'Arial', size = 10),
          plot.title   = element_text(family = 'Arial', size = 10, hjust = 0.5),
          legend.title = element_blank(),
          legend.text  = element_text(family = 'Arial', size = 10),
          legend.position = 'bottom')
  
  if (resp.form != 'Translate'){
    p <- p + theme(axis.title.x = element_blank(),
                   axis.text.x  = element_blank(),
                   axis.ticks.x = element_blank())
  }
  p
  
}

plot.reg <- function(glm_fixed){
  
  # Point estimates and 95% CIs on odds ratio scale
  glm_fixed_or <- data.frame(OR = exp(coef(glm_fixed)),
                             CI = exp(confint.default(glm_fixed))) 
  
  glm_fixed_or$var <- row.names(glm_fixed_or)
  glm_fixed_or <- glm_fixed_or[-1, ] # drop intercept
  var_levels <- glm_fixed_or$var[order(glm_fixed_or$OR)]
  ggplot(glm_fixed_or, aes(x = OR, y = factor(var, levels = var_levels))) +
    geom_vline(xintercept = 1, col = "red") + 
    geom_pointrange(aes(x = OR, xmin = CI.2.5.., xmax = CI.97.5..)) +
    scale_x_continuous(name = 'Odds Ratio') +
    scale_y_discrete(name = 'Coefficient') +
    theme_bw()
}