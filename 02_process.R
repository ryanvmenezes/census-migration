library(tidyverse)
library(glue)

specs = fwf_cols(
  fips_state_a = c(1,3),
  fips_county_a = c(4,6),
  fips_state_b = c(7,9),
  fips_county_b = c(10,12),
  state_a = c(14, 43),
  county_a = c(44,78),
  state_b = c(80,109),
  county_b = c(110,144),
  flow = c(146,153),
  flow_moe = c(155,162),
  counterflow = c(164,171),
  counterflow_moe = c(173,180),
  net = c(182,189),
  net_moe = c(191,198),
  gross = c(200,207),
  gross_moe = c(209,216)
)

processfile = function(year) {
  df = read_fwf(glue('raw/flows-{year}.txt'), specs) %>% 
    mutate(year = year) %>% 
    select(-starts_with('state_'), -starts_with('county_'))
  return(df)
}

all.data = map_dfr(2011:2018, processfile)

all.data

all.data %>% write_rds('processed/flows-all-years.rds', compress = 'gz')
