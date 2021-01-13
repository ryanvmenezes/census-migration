library(glue)

getfile = function(year) {
  if (year >= 2014) {
    fname = 'county-to-county-migration-flows/Net_Gross_US.txt'
  } else if (year >= 2012) {
    fname = 'net_gross_us.txt'
  } else if (year == 2011) {
    fname = 'znet_gross_us.txt'
  }
  url = glue('https://www2.census.gov/programs-surveys/demo/tables/geographic-mobility/{year}/county-to-county-migration-{year-4}-{year}/{fname}')
  outfile = glue('raw/flows-{year}.txt')
  download.file(url, outfile)
  zip(str_replace(outfile, '.txt', '.zip'), outfile)
}

walk(
  2011:2018,
  getfile
)

beepr::beep()
