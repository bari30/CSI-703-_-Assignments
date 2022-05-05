


library(anytime)
library(plyr)
library(ggplot2)
library(scales)
library(dplyr)


p <- read.csv("final.csv")
p
mydate <- as.Date(p$date)



# Q1: This plot shows the various points of the history of recession in the USA.
p2 <- data.frame(year = as.Date(c(p$date)),
                 cycle = as.numeric(c(p$pt)))

ggplot(p2, 
       aes(x = year, 
           y = cycle, 
           fill = cycle < 0)) + 
  
  geom_bar(stat = "identity") + 
  scale_fill_manual(values = c("red", "blue"),name = "Economic Cycle: (Growth vs Decline) ", labels = c("Expansion", "Contraction"))+
  geom_text(aes(label = cycle),color = "purple", size = 3,vjust = 1.5, position = position_dodge(.9))+
  geom_smooth(formula = y ~ x, method = "lm")+
  scale_x_date(date_breaks = '15 years', breaks = NULL, labels = date_format("%b-%Y"))+
  labs(title = "History of US Recession", subtitle = "from 1850 to 2021", x ="Year", y="Lenght of Contractiona & Expansion (Month)")+
  
  theme_minimal()
