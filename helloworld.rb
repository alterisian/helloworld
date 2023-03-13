# Goal: An active global group of rubyists working together

# Usage: ruby helloworld.rb
# Dependency: install ruby via https://www.ruby-lang.org

# Process:
#  * use github web editor to edit: https://github.com/alterisian/helloworld/blob/main/helloworld.rb
#    (which will fork the github repo: https://github.com/alterisian/helloworld to your user's account)
#  * add your line see bottom of helloworld.rb
#  * create a commit "adding my name" and select the 'Create a new branch for this commit and start a pull request' option
#  * observe Github Action run the script: ruby helloworld.rb

# WHY: Inspired by Bob Allen who introduced the world to
# global liquid mobs, lets try and create a global mob for ruby
# Reference: https://twitter.com/alterisian/status/1610941873589477377

# History: January. 6 people contributed bv adding their say_hello line to gitlab.
# TODO: February. 4 more contributed to github. We lost CI though?
# TODO: March. Maybe we can refactor so the output is split with everyone
# listed, but the next 3 west of a handle are first? To be more tweetable.
#  - Consider introducing the hometown as an additional argument?

# Join the Málaga mob listed on: https://mobusoperandi.com/mobs/malaga.html

require 'geocoder'
require_relative 'person'

class Helloworld
  @everyone = nil

  def initialize
    @everyone = []
    puts "helloworld.rb - the global ruby mob"
    puts "..."
    puts "Don't forget to bundle for geocoding!"
    puts "LETS GO..."
    puts "  "
  end

  def say_hello(handle, location)    
    @everyone << Person.new(handle, location, get_coordinates(location) )
  end

  def get_coordinates(location)
    results = Geocoder.search location
    results.first.coordinates
  end

  def output(handle="@alterisian")
    puts west_of(handle)
  end

  # Latitudes are horizontal lines that measure distance north or south
  # of the equator. Longitudes are vertical lines.
  # Longitutde with a negative is western, positive is eastern.
  def west_of(handle)
    person = @everyone.find {|person| true if person.name==handle }
    if person
      handle_latitude = person.coordinates.first
    end
    @west_of=[]
    @everyone.each do |person|
      if person.coordinates.first < handle_latitude
        @west_of << person.to_s
      end
    end

    @west_of
  end
end

hi = Helloworld.new

hi.say_hello("@alterisian", "Málaga, Spain")
hi.say_hello("@CelsoDeSa", "Barra Velha, Brazil")
hi.say_hello("@lucianghinda", "Bucharest, Romania")
hi.say_hello("@bsilva96", "Machalí, Chile")
hi.say_hello("@diazgdev", "Aguascalientes, México")
hi.say_hello("@esquinas", "Málaga, Spain")
hi.say_hello("@sidonath", "Málaga, Spain")
hi.say_hello("@firedev", "Phuket, Thailand")
hi.say_hello("@theOnlyMaDDogx", "New Delhi, India")
hi.say_hello("@georgy5", "Kaufbeuren, Germany")
hi.say_hello("@twobbler", "Antwerp, Belgium")
hi.say_hello("@amosdalmeri", "Brescia, Italy")

hi.output

# TODO - March - if new add a call above to hi.say_hello for yourself.
