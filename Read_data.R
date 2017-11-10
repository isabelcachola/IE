library(ggplot2)
data <- read.csv("noswearingclean.csv", quote = "", 
                 row.names = NULL, 
                 stringsAsFactors = FALSE,
                 encoding = 'uft-8')
attach(data)
sum(data$Type == 'slur') / 267
ggplot(data = data, mapping = aes(Gender)) + 
  geom_bar() +
  facet_wrap(~ Type.AF8.slur, ncol = 1) +
  theme(axis.text.x=element_text(angle = -45, hjust = 0)) +
  theme(axis.title.x = element_blank())


data$Type.AF8.slur <- factor(data$Type.AF8.slur,
                             labels = c('r',
                                        'gs',
                                        'a',
                                        'na'))
data$Gender <- factor(data$Gender,
                      labels = c('f',
                                 'm',
                                 'n'))

makeRivPlot <- function(data, var1, var2, ...) {
  
  require(plyr)
  require(riverplot)
  require(RColorBrewer)
  
  names1 <- levels(data[, var1])
  names2 <- levels(data[, var2])
  
  var1 <- as.numeric(data[, var1])
  var2 <- as.numeric(data[, var2])
  
  edges <- data.frame(var1, var2 + max(var1, na.rm = T))
  edges <- count(edges)
  
  colnames(edges) <- c("N1", "N2", "Value")
  
  nodes <- data.frame(ID     = c(1:(max(var1, na.rm = T) +
                                      max(var2, na.rm = T))),
                      x      = c(rep(1, times = max(var1, na.rm = T)),
                                 rep(2, times = max(var2, na.rm = T))),
                      labels = c(names1, names2) ,
                      col    = c(brewer.pal(max(var1, na.rm = T), "Set1"),
                                 brewer.pal(max(var2, na.rm = T), "Set1")),
                      stringsAsFactors = FALSE)
  
  nodes$col <- paste(nodes$col, 95, sep = "")
  
  return(makeRiver(nodes, edges))
  
}
a <- makeRivPlot(data, data$Gender, data$Type.AF8.slur)

riverplot(a, srt = 45)
