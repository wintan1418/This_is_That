Geocoder.configure(
  # Geocoding options
  timeout: 5,                 # geocoding service timeout (secs)
  lookup: :nominatim,         # name of geocoding service (symbol)
  use_https: true,           # use HTTPS for lookup requests? (if supported)

  # Nominatim REQUIRES a User-Agent header
  http_headers: { "User-Agent" => "ThisIsThatApp/1.0" },

  # Calculation options
  units: :mi,                 # :km for kilometers or :mi for miles
  distances: :linear          # :spherical or :linear
)
