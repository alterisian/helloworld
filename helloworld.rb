# Hi from @alterisian in Málaga
# Lets make the Mexican wave of ruby code.
#
# Usage: ruby helloworld.rb
#
# Dependency: install ruby via https://www.ruby-lang.org
#
# Process:
#  create a local branch,
#  add your line,
#  run the script,
#  commit and push.
#  Create merge request (MR)

# Inspired by the likes of Woody Zuil and Bob Allen
# who popularised mob programming, and introduced the world to
# global liquid mobs, lets try and create a global mob for ruby

# TODO: January. Add your say_hello line. Commit. Push.
# Keep it as simple as possible in January's circumvention of the globe,
# to make it as easy as possible for the next contributor.

# TODO: February. Write what features you'd like us all to work on below.
# TODO - @alterisian : Add next_location to calculate where is next WEST from you using the previous contributions as a reference

# Reference: https://twitter.com/alterisian/status/1610941873589477377

# Last Thursday of the month. 16:00 CET (Spain/Germany) lets me at Wonder.me:
# https://app.wonder.me/?spaceId=00b3a3a8-163a-4ae9-b5ec-7e9520e39862

class Helloworld
  def initialize
    puts "Hi from:"
  end

  def say_hello(person, location)
    puts "#{person}, #{location}"
  end
end

hi = Helloworld.new
hi.say_hello("@alterisian", "Málaga, Spain")
hi.say_hello("@CelsoDeSa", "Barra Velha, Brazil")
hi.say_hello("@lucianghinda", "Bucharest, Romania")
hi.say_hello("@bsilva96", "Machalí, Chile")
hi.say_hello("@diazgdev", "Aguascalientes, México")

#TODO - January - add your call to hi.say_hello above this line. Keep this line.
