permits <- readRDS("permits.rds")
permits$lat <- as.numeric(permits$lat)
permits$lng <- as.numeric(permits$lng)