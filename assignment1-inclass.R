library(tidyverse)
if (!file.exists("video_view.csv")) {
data_url <- paste0(
"https://raw.githubusercontent.com/hannesdatta/",
"course-dprep/refs/heads/main/material/tutorials/r-bootcamp-rev/",
"video_view.csv"
)
download.file(data_url, "video_view.csv")
}
videos <- read_csv("video_view.csv") 

# Exercise 1 
# Build a baseline scatter plot: 1. data: videos 2. x-axis: impressions_n 3. y-axis: watch_rate 4. chart type: geom_point()

ggplot(data = videos, aes(x = impressions_n, y = watch_rate)) +
geom_point()

# Exercise 2: Improve your plot for a non-technical reader
# Create readability bands first
videos_plot <- videos %>%
  mutate(
    visibility_band = case_when(
      impressions_n < 20 ~ "Low visibility",
      impressions_n < 60 ~ "Medium visibility",
      TRUE ~ "High visibility"
    )
  )

# Improved plot
ggplot(videos_plot, aes(x = impressions_n, y = watch_rate, color = visibility_band)) +
  geom_point(alpha = 0.7, size = 2) +
  labs(
    title = "Video quality vs reach",
    x = "Impressions",
    y = "Watch rate",
    color = "Visibility"
  ) +
  theme_minimal()
# One AI suggestion you used: Adding clearer title and axis labels with labs().
# One AI suggestion you did NOT use: Faceting into separate plots by creator because it created too many small panels.

ggsave("plot.png")