# data from Carto: https://phl.carto.com/api/v2/sql?q=SELECT *, left(zip,5) as zipnumber,TO_CHAR(permitissuedate,'yyyy-mm-dd') AS permitdate, ST_Y(the_geom) AS lat, ST_X(the_geom) AS lng FROM li_permits&filename=permits&format=json&skipfields=permitissuedate,cartodb_id,organization,the_geom,the_geom_webmercator,geocode_x,geocode_y,zip
# parameters: filename,sql,format
library(dplyr)
library(lubridate)
library(readr)
library(magrittr)
library(stringr)
library(purrr)

permits <- read_csv("permits.csv")

permits %<>%
  filter(!is.na(lat)) %>%
  filter(!is.na(lng))

permits %<>%
  filter(!is.na(permitdate)) %>%
  mutate(popdate = paste("Date:", permitdate)) %>%
  mutate(content = paste(popdate, address, permitdescription, sep = "<br/>"))

saveRDS(permits, "permits.rds")
