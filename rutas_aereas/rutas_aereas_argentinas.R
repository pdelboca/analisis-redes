library(dplyr)

# GET AIRPORTS
# http://openflights.org/data.html
airports <- readr::read_csv("./data/airports-extended.dat",col_names = FALSE)
colnames(airports) <- c("airport_id", "name", "city", "country", "IATA", "ICAO",
                        "latitude", "longitude", "altitude","timezone",
                        "dst", "timezone_tz", "type", "source")
airports$IATA <- ifelse(is.na(airports$IATA), airports$ICAO, airports$IATA)

aa <- airports %>% 
        filter(country == "Argentina") %>%
        select(name, city, IATA, latitude, longitude, airport_id) %>%
        rename(id = IATA, lat = latitude, lng = longitude)

readr::write_csv(aa, path = "./data/aeropuertos_argentina.csv")

# GET ROUTES
routes <- readr::read_csv("./data/routes.dat",col_names = FALSE)
colnames(routes) <- c("airline","route_id","source","source_airport_id",
                      "destination", "destination_airport_id","codeshare",
                      "stops", "equipement")

aa_routes <- routes %>% 
    filter(source_airport_id %in% aa$airport_id,
           destination_airport_id %in% aa$airport_id) %>%
    select(source, destination, airline) %>%
    rename(Source = source, Target = destination, Label = airline)
    
readr::write_csv(aa_routes, path = "./data/rutas_argentina.csv")
