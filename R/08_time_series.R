
library(dplyr)
library(ggplot2)
library(lubridate)
library(zoo)

covid <- read.csv("data/raw/covid19-dd7bc8e57412439098d9b25129ae6f35.csv")


class(covid$date)

covid$date <- as_date(covid$date)

class(covid$date)



ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()

# Fixing the negative values
covid$new_confirmed[covid$new_confirmed < 0] <- 0

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()



ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  scale_x_date(breaks = "4 months", date_labels = "%Y-%m") +
  labs(x = "Date", y = "New cases")


#  Rolling mean

covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill = NA)

head(covid)

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  scale_x_date(breaks = "4 months", date_labels = "%Y-%m") +
  labs(x = "Date", y = "New cases") +
  geom_line(aes(x = date, y = roll_mean), color = "red", size = 1.2)


