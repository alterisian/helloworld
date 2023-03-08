require 'geocoder'

people = Hash.new

people["@alterisian"] = { location: "Málaga, Spain" }
people["@CelsoDeSa"] = { location: "Barra Velha, Brazil" }
people["@lucianghinda"] = { location: "Bucharest, Romania" }
people["@bsilva96"] = { location: "Machalí, Chile" }
people["@diazgdev"] = { location: "Aguascalientes, México" }
people["@esquinas"] = { location: "Málaga, Spain" }
people["@sidonath"] = { location: "Málaga, Spain" }
people["@firedev"] = { location: "Phuket, Thailand" }
people["@theOnlyMaDDogx"] = { location: "New Delhi, India" }
people["@georgy5"] = { location: "Kaufbeuren, Germany" }
people["@twobbler"] = { location: "Antwerp, Belgium" }

puts '{'
puts '"people": ['
people.each do |person, details|
  results = Geocoder.search details[:location]
  people[person][geo: results.first.coordinates]
  puts '{ "name": "'+person+'",
    "latitude": '+results.first.coordinates.first.to_s+',
    "longitude": '+results.first.coordinates.last.to_s+'
   },'
end
puts ' ] '
puts '}'
