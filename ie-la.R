library(tidyverse)

flows = read_rds('processed/flows-all-years.rds')

flows

ie.la = flows %>% 
  filter(fips_state_a == '006') %>% 
  filter(fips_county_a %in% c('065', '071')) %>% 
  filter(fips_state_b == '006') %>% 
  filter(fips_county_b == '037') %>% 
  group_by(year) %>% 
  summarise(
    flow = sum(flow),
    counterflow = sum(counterflow),
    net = sum(net),
    # gross = sum(gross),
    .groups = 'drop'
  )

ie.la

ie.la %>% 
  ggplot(aes(year, net)) +
  geom_line()
