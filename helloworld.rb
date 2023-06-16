# Goal: An active global group of rubyists working together

# Usage: bundle exec ruby helloworld.rb
# Without geocoding: bundle exec ruby helloworld.rb false

# Or use in the irb:
# bundle exec irb
# require_relative "./helloworld.rb"
# hi = Helloworld.new
# hi.say_hello("@alterisian", "Málaga, Spain")
# hi.say_hello("@CelsoDeSa", "Barra Velha, Brazil")
# hi.output

# Dependency: install ruby via https://www.ruby-lang.org

# Process:
#  * use github web editor to edit: https://github.com/alterisian/helloworld/blob/main/helloworld.rb
#    (which will fork the github repo: https://github.com/alterisian/helloworld to your user's account)
#  * add your twitter handle and location line to the bottom of helloworld.rb
#  * 
#  * create a commit "adding my name" and select the 'Create a new branch for this commit and start a pull request' option
#  * observe Github Action run the script: ruby helloworld.rb

# WHY: Inspired by Bob Allen who introduced the world to
# global liquid mobs, lets try and create a global mob for ruby
# Reference: https://twitter.com/alterisian/status/1610941873589477377

# History:
# January. 6 people contributed bv adding their say_hello line to gitlab.
# February. 4 more contributed to github. We lost CI though?
# March. Maybe we can refactor so the output is split with everyone
# listed, but the next 3 west of a handle are first? To be more tweetable.
# April. Continue to include more people around the world, and work on handovers.
# May - presented to Munich ruby group, and added new people from Brazil, and a github page.

# We are the Málaga mob listed on Mobusoperandi: https://mobusoperandi.com/mobs/malaga.html
# Follow the instructions on our github page to get involved:
# https://alterisian.github.io/helloworld

require 'optparse'
require 'geocoder'
# require 'tzf'
require_relative 'person'

class Helloworld
  attr_reader :everyone

  VIDEO_CHAT_URL = "https://meet.jit.si/TodayMálagaTomorrowWeMake".freeze
  AVAILABILITY_FORM_LINK = "https://forms.gle/TE7GuW2KNjEJLtLx7".freeze
  TWITTER_BASE_URL = "https://twitter.com/".freeze
  TWEET_CHARACTER_LIMIT = 280
  @everyone = nil
  @geolocation = false
  @twitter_api_key = nil
  @run_type = nil

  def initialize(geolocation=true, run_type="all", twitter_api_key=nil)
    @everyone = []
    @geolocation = geolocation
    @run_type = run_type
    @twitter_api_key = twitter_api_key

    puts "#helloworld_rb - the global ruby mob"
    puts ""
    puts "LETS GO..."
    puts ""
    puts "geolocation is #{@geolocation}"
    puts "run_type is #{@run_type}"
    puts "twitter API key present: #{!@twitter_api_key.empty?}"

    puts "Fetching coordinates...."
  end

  def self.parse_options
    options = {
      geolocation: true,
      twitter_key: ENV['TWITTER_API_KEY']
    }
    OptionParser.new do |opts|
      opts.banner = "Usage: helloworld.rb [options]. For help use -h."
    
      opts.on("--[no-]geolocation", "Run with/without geolocation") do |g|
        options[:geolocation] = g
      end
  
      opts.on("-rall", "--run_type=all", "Run type report i.e. all") do |rt|
        options[:run_type] = rt
      end
  
      # use the environment variable for the twitter api key  
      # unless it doesn't exist, then use passed in parameter
      opts.on("-t KEY", "--twitter-key KEY", "twitter api key") do |tk|
        options[:twitter_key] = tk
      end
    end.parse!

    options
  end

  def say_hello(handle, location)
    if @geolocation
      coordinates = get_coordinates(location)
      timezone = get_timezone(coordinates)
      @everyone << Person.new(handle, location, coordinates, timezone)
    else
      @everyone << Person.new(handle, location, nil, nil)
    end
  end

  def get_coordinates(location)
    results = Geocoder.search location
    results.first.coordinates
  end

  # @param [Array] coordinates
  def get_timezone(coordinates)
    # TZF.tz_name(*coordinates) # TODO -IM: replace with timeanddate.com
  end

  def output(handle="@alterisian")
    puts "--west_of tweet"
    if @geolocation
      puts generate_tweet(west_of(handle), "Málaga, Spain")
    else
      # pick 3 people randomly
      puts generate_tweet(pick_handles_randomly(3), "Málaga, Spain")
    end
    puts "\n--availability tweet\n"
    puts "\ntweet:"+generate_availability_tweets[0]
    puts "\nreply:"+generate_availability_tweets[1] unless generate_availability_tweets[1].nil?
  end

  def all_tweets
    twitter_handles = ""
    @everyone.map { |person| twitter_handles+= "\n\r #{TWITTER_BASE_URL}#{person.name.gsub('@','')}" }
    twitter_handles
  end

  # Latitudes are horizontal lines that measure distance north or south of the equator
  # Longitudes are vertical lines. 
  # Longitutde with a negative is western, positive is eastern
  def west_of(handle)
    person = @everyone.find {|person| true if person.name==handle }
    if person
      # byebug
      handle_longitutde = person.coordinates.last
    end
    @west_of=[]
    @everyone.each do |person|
      if person.coordinates.last < handle_longitutde
        @west_of << person.to_s
      end
    end

    @west_of
  end

  def pick_handles_randomly(num_of_people)
    @everyone.shuffle.first(num_of_people)
  end

  def in_timezone_of(handle)
    person = @everyone.find { |person| person.name == handle }
    if person
      timezone = person.timezone
    end
    @everyone.filter { |person| person.timezone == timezone }
             .map { |person| person.name }
  end

  def generate_tweet(people_west_of, location)
    handles = people_west_of.reduce("") do |acc, current_value|
      acc += "#{current_value.split(',').first}, "
    end
    <<~TWEET
      Hey #{handles.chomp(' ')} #helloworld_rb is almost finished in #{location}.
      Can we hand over the mob to you?
      Join #{VIDEO_CHAT_URL}
      Please fill out the following form to share your availability: https://forms.gle/BxVGGFqCxJd1i9w88
    TWEET
  end

  def split_string(str)
    if str.length <= TWEET_CHARACTER_LIMIT
      return [str]
    else
      first_part = str[0..(TWEET_CHARACTER_LIMIT-1)]
      last_space_index = first_part.rindex(/\s/)
      if last_space_index.nil? || last_space_index == 0
        # no space found or space is at the beginning of the string
        return [first_part, str[TWEET_CHARACTER_LIMIT..-1]]
      else
        # split the string at the last space before 280 characters
        return [str[0..last_space_index-1], str[last_space_index+1..-1]]
      end
    end
  end

  def generate_availability_tweets
    long_tweet = generate_availability_tweet
    split_string(long_tweet)
  end

  def generate_availability_tweet
    handles = ""

    @everyone.each do |person|
      handles += "#{person.name} "
    end

    <<~TWEET
      Hey, look forward to seeing you in #helloworld_rb this week.
      Even if it's only an hour.
      Can you estimate when you are available in your timezone in this form:
      #{AVAILABILITY_FORM_LINK}
      #{handles}
    TWEET
  end
end

if $0 == __FILE__
  # cmd line parameter handling.
  options = Helloworld.parse_options

  # bundle exec ruby helloworld.rb --geolocation -rall
  hi = Helloworld.new(options[:geolocation], options[:run_type], options[:twitter_key])
  
  hi.say_hello("@alterisian", "Málaga, Spain")
  hi.say_hello("@CelsoDeSa", "Barra Velha, Brazil")
  hi.say_hello("@lucianghinda", "Bucharest, Romania")
  hi.say_hello("@bsilva96", "Machalí, Chile")
  hi.say_hello("@diazgdev", "Aguascalientes, México")
  hi.say_hello("@esquinas", "Málaga, Spain")
  hi.say_hello("@sidonath", "Málaga, Spain")
  hi.say_hello("@firedev", "Phuket, Thailand")
  hi.say_hello("@theOnlyMaDDogx", "New Delhi, India")
  hi.say_hello("@karlos_georgy", "Kaufbeuren, Germany")
  hi.say_hello("@twobbler", "Antwerp, Belgium")
  hi.say_hello("@amosdalmeri", "Brescia, Italy")
  hi.say_hello("@_jidemuritala", "Reus, Spain")
  hi.say_hello("@Migreboo", "Osaka, Japan")
  hi.say_hello("@j3nnn1", "Ciudad Autónoma de Buenos Aires, Argentina")
  hi.say_hello("@lamalotos", "Dubai, United Arab Emirates")
  hi.say_hello("@jtsococo", "Tokyo, Japan")
  hi.say_hello("@pusewicz", "Benicarló, Spain")
  
  hi.output
  # TODO - New Joiner - add a call above to hi.say_hello for your twitter handle and location
end
