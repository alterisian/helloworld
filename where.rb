require 'geocoder'

locations = ["Málaga, Spain", "Barra Velha, Brazil", "Bucharest, Romania", "Machalí, Chile", "Aguascalientes, México"]

locations.each do |l|
  results = Geocoder.search l
  puts l+" : "+results.first.coordinates
end

def where_is(location)
  (lat,lng) = geo location
end

results = Geocoder.search("Machalí, Chile")
h = Hash.new
h["diazgdev"] = { name: "Aguascalientes, México", geo: results.first.coordinates}
