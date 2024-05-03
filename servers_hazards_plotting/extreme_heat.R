heat <- ggplot(data = extreme_heat1,
               aes(x = year, y = total, color = scenario)) +
  geom_line() +
  theme_classic() +
  labs(x = "Year",
       y = "Number of Extreme Heat Days") +
  theme(legend.position = "top",
        legend.title = element_blank())

ggplotly(heat) %>% 
  layout(legend = list(orientation = "h", y = 1.1,
                       title = list(text = 'Scenarios')),
         margin = list( t = 60))