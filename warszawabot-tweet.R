# Twitter token 
warszawabot_token <- rtweet::create_token(
  app = "warszawabot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# tylko do testów
# warszawabot_token <- readRDS("~/.rtweet_token_warszawabot.rds")

# Współrzędne punktu w Warszawie .

# centrum 52.188268, 20.885447 - 52.272606, 21.141751
lon <- round(runif(1, 20.885, 21.141), 4)
lon <- format(lon, scientific = FALSE)
lat <- round(runif(1, 52.188, 52.272), 4)
lat <- format(lat, scientific = FALSE)

# bbox Wawy

# lon <- round(runif(1, 20.851, 21.271), 4)
# lon <- format(lon, scientific = FALSE)
# lat <- round(runif(1, 52.097, 52.368), 4)
# lat <- format(lat, scientific = FALSE)
# Adres do MapBox API
# https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/

# po 600x400 dodany był @2x
img_url <- paste0(
  "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/static/",
  paste0(lon, ",", lat),
  ",15,0/850x500?access_token=",
  Sys.getenv("MAPBOX_PUBLIC_ACCESS_TOKEN")
)

# Pobranie zdjęcia satelitarnego z MapBox

temp_file <- tempfile()
download.file(img_url, temp_file)

# Współrzędne punktu i adres do mapy w OpenStreetMaps

latlon_details <- paste0("Jestem botem, który co ca. 60 min. wybiera losowo punkt w #Warszawa (i okolicy), pobiera zdjęcie satelitarne.  Poniżej pkt o współ.: ", lat, ",", lon, "\n", "Jeśli nie poznajesz, to zobacz na mapie. ",
  "https://www.openstreetmap.org/#map=17/", lat, "/", lon, "/"
)

# Wysłanie twita ze zdjęciem satelitarnym
rtweet::post_tweet(
  status = latlon_details,
  media = temp_file,
  token = warszawabot_token
)
