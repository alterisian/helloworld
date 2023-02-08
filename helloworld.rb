# Goal: An active global group of rubyists working together

# Usage: ruby helloworld.rb
# Dependency: install ruby via https://www.ruby-lang.org

# Process:
#  fork the github repo: https://github.com/alterisian/helloworld
#  add your line see bottom of helloworld.rb
#  run the script: ruby helloworld.rb
#  commit and push: git commit -am "adding my name" 
#  Create pull request (PR) via your fork via the webbrowser at https://github.com

# WHY: Inspired by Bob Allen who introduced the world to
# global liquid mobs, lets try and create a global mob for ruby
# Reference: https://twitter.com/alterisian/status/1610941873589477377

# History: January. 6 people contributed bv adding their say_hello line to gitlab.
# TODO: February. Add your say_hello line to github 

# Join the Málaga mob listed on: https://mobusoperandi.com/mobs/malaga.html

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
hi.say_hello("@esquinas", "Málaga, Spain")
hi.say_hello("@sidonath", "Málaga, Spain")

#TODO - February - add your call to hi.say_hello above this line. Keep this line.
