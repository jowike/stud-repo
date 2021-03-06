df <- read.csv("/home/elzbieta/twd/pracaDomowa1/file.csv")
head(df)

library(ggplot2)
library(dplyr)
library(plyr)
library(viridis)

events <- unique(df$schedule)
tmp <- events[1] # zabieg wykonany w celu zachowania relacji kolorów
events[1] <- events[2]
events[2] <- tmp


df["value"] <- NA

for (j in 1:length(events)){
  for (i in 1:nrow(df)){
    if (df[i, "schedule"] == events[j]){
      df[i, "value"] = -j**2
    }
  }
}

df$date <- as.Date(df$date, format = "%Y/%m/%d")

weekdays(df$date[7] + 0:6) # ---> weekdays in proper order, but in Polish!, 
# to use it we should use Sys.setlocale("LC_TIME","English United States"),
# in response I got: 
# Warning message:
#   In Sys.setlocale("LC_TIME", "English United States") :
#   OS reports request to set locale to "English United States" cannot be honored
# so I decidec to write levels manually

proper_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
head(df)
special_events <- df[df$special_label != "None", ]
description <- ""
for (i in 1:nrow(special_events)){
  x <- paste(substr(special_events[i, "date"], 9, 10), "Oct", sep = " ")
  y <- paste(x, special_events[i, "special_label"], sep = "-")
  description <- paste(description, y, sep = "\n")
}

ggplot(data = df, aes(x = factor(week_day, levels = proper_order), y =-month_week, fill = value)) + 
  geom_tile(colour = "white", aes(fill = value)) +
  scale_fill_gradient(breaks = c(-4, -8, -12, -16),
                        labels = paste(events, "  "),
                        guide = guide_legend(
                          direction = "horizontal",
                          name = ""),
                      low = "brown4") + 
  labs(x = "",
       y = "",
       title = "Brexit Calendar",
       subtitle = "Countdown to 31 October",
       caption = description) + 
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        plot.caption=element_text(hjust=1, vjust=1.5, size = 13),
        plot.margin = unit(c(1.5,3.5,1.5,3.5), "cm"),
        legend.position = "top",
        legend.title = element_blank(),
        panel.background = element_blank()) + 
  scale_x_discrete(position = "top") + 
  annotate("text", x = 2, y = -2, label = "8 Oct", color = "white") + 
  annotate("text", x = 1, y = -3, label = "14 Oct", color = "white") + 
  annotate("text", x = 4, y = -3, label = "17 Oct", color = "white") + 
  annotate("text", x = 6, y = -3, label = "19 Oct", color = "white") + 
  annotate("text", x = 4, y = -5, label = "31 Oct", color = "white")
