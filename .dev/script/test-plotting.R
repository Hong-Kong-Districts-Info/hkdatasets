hkdc %>%
  arrange(-Vote) %>%
  slice(1:20) %>%
  ggplot(aes(x = reorder(DC_ZH, Vote), y = Vote, fill = Party_ZH)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = Vote), hjust = -0.25) +
  labs(title = "Number of votes won in District Council election",
       subtitle = "2019 Hong Kong District Council election",
       x = "Elected District Councillors") +
  ggthemes::theme_fivethirtyeight()

