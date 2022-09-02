# Plot model learning curves
plot.learning <- function(x, df){
  
  df     <- filter(df, format == x) %>% arrange(desc(Outcome), language)
  df$int <- paste(df$language, ' (', df$Outcome, ')', sep = "")
  df$int <- factor(df$int, levels = unique(df$int))
  
  cols <- brewer.pal(3, 'Set1')
  
  p <- ggplot(df, aes(x = repetition, y = Accuracy, color = int, linetype = int)) +
    geom_line() +
    scale_colour_discrete("") +
    scale_linetype_manual("", values=c(1, 1, 1, 2, 2, 2)) +
    scale_color_manual("", values = c(cols[1], cols[2], cols[3], cols[1], cols[2], cols[3])) +
    scale_x_continuous(name = 'Repetition', limits = c(0, 20), breaks = c(0, 5, 10, 15, 20), labels = c('0', '5', '10', '15', '20+')) +
    scale_y_continuous(name = 'Accuracy (%)', limits = c(.5, 1), breaks = c(.5, .6, .7, .8, .9, 1.0), labels = scales::percent) +
    guides(linetype = guide_legend(ncol=2)) +
    ggtitle(x) +
    theme_bw() +
    theme(axis.text = element_text(family = 'Arial', size = 10),
          axis.title = element_text(family = 'Arial', size = 10),
          plot.title = element_text(family = 'Arial', size = 10, hjust = 0.5),
          legend.title = element_blank(),
          legend.text = element_text(family = 'Arial', size = 10),
          legend.position = 'bottom')
  
  if (x != 'Translate'){
    p <- p + theme(axis.title.x = element_blank(),
                   axis.text.x  = element_blank(),
                   axis.ticks.x = element_blank())
  }
  
  p
}

## Plot model decay curves
plot.retention <- function(x, df){
  
  df     <- filter(df, format == x) %>% arrange(desc(Outcome), language)
  df$int <- paste(df$language, ' (', df$Outcome, ')', sep = "")
  df$int <- factor(df$int, levels = unique(df$int))
  
  cols <- brewer.pal(3, 'Set1')
  
  p <- ggplot(df, aes(x = x.val, y = Accuracy, color = int, linetype = int)) +
    geom_line() +
    scale_colour_discrete("") +
    scale_linetype_manual("", values =c(1, 1, 1, 2, 2, 2)) +
    scale_color_manual("", values = c(cols[1], cols[2], cols[3], cols[1], cols[2], cols[3])) +
    scale_x_continuous(name = 'Elapsed Time Since Last Exposure to Word', limits = c(1, 6), breaks = 1:6, labels = unique(ret_avg$lags_cat)) +
    scale_y_continuous(name = 'Accuracy (%)', limits = c(.5, 1), breaks = c(.5, .6, .7, .8, .9, 1), labels = scales::percent) +
    guides(linetype = guide_legend(ncol=2)) +
    ggtitle(x) +
    theme_bw() +
    theme(axis.text = element_text(family = 'Arial', size = 10),
          axis.title = element_text(family = 'Arial', size = 10),
          plot.title = element_text(family = 'Arial', size = 10, hjust = 0.5),
          legend.title = element_blank(),
          legend.text = element_text(family = 'Arial', size = 10),
          legend.position = 'bottom')
  
  if (x != 'Translate'){
    p <- p + theme(axis.title.x=element_blank(),
                   axis.text.x=element_blank(),
                   axis.ticks.x=element_blank())
  }
  
  p
}