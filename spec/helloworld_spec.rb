require_relative './spec_helper'
require_relative "../helloworld"

describe Helloworld do

  context '#west_of' do
    it "shows location is west of another" do
      VCR.use_cassette("west_of_shows_location_is_west_of_another") do
        helloworld = Helloworld.new
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@bsilva96", "Machalí, Chile")

        expect( helloworld.west_of("@alterisian") ).to eq(["@bsilva96, Machalí, Chile"])
      end
    end

    it 'returns three people west of a given person' do
      VCR.use_cassette("west_of_returns_three_people_west_of_a_given_person") do
        helloworld = Helloworld.new
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhi, India")
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@bsilva96", "Machalí, Chile")
        helloworld.say_hello("@lucianghinda", "Bucharest, Romania")

        expect( helloworld.west_of("@theOnlyMaDDogx") ).to eq(["@alterisian, Málaga, Spain", "@bsilva96, Machalí, Chile", "@lucianghinda, Bucharest, Romania"])
      end
    end

    it 'generates tweetable output' do
      VCR.use_cassette("west_of_generates_tweetable_output") do
        helloworld = Helloworld.new
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhi, India")
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@bsilva96", "Machalí, Chile")
        helloworld.say_hello("@lucianghinda", "Bucharest, Romania")
        people_west_of = helloworld.west_of("@theOnlyMaDDogx")
        location = "New Delhi, India"

        expect( helloworld.generate_tweet(people_west_of, location) ).to eq(<<~TWEET
          Hey @alterisian, @bsilva96, @lucianghinda, #helloworld_rb is almost finished in New Delhi, India.
          Can we hand over the mob to you?
          Join https://meet.jit.si/TodayMálagaTomorrowWeMake
          Please fill out the following form to share your availability: https://forms.gle/BxVGGFqCxJd1i9w88
        TWEET
        )
      end
    end
  end

  context '#generate_tweet' do
    it 'limits the tweetable output to 280 characters' do
      VCR.use_cassette("generate_tweet_limits_the_tweetable_outpot_to_280_characters") do
        helloworld = Helloworld.new
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhi, India")
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@bsilva96", "Machalí, Chile")
        helloworld.say_hello("@lucianghinda", "Bucharest, Romania")
        people_west_of = helloworld.west_of("@theOnlyMaDDogx")
        location = "New Delhi, India"

        tweet = helloworld.generate_tweet(people_west_of, location).gsub("\n", '')
        expect(tweet.size).to be <= Helloworld::TWEET_CHARACTER_LIMIT
      end
    end
  end

  context '#ask_availability' do
    it 'includes all the twitter handles in tweetable format' do
      VCR.use_cassette("includes_all_the_twitter_handles_in_tweetable_format") do
        helloworld = Helloworld.new(false)
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhi, India")
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@bsilva96", "Machalí, Chile")
        helloworld.say_hello("@lucianghinda", "Bucharest, Romania")

        helloworld.say_hello("@CelsoDeSa", "Barra Velha, Brazil")
        helloworld.say_hello("@bsilva96", "Machalí, Chelloworldle")

        helloworld.say_hello("@diazgdev", "Aguascalientes, México")
        helloworld.say_hello("@esquinas", "Málaga, Spain")
        helloworld.say_hello("@sidonath", "Málaga, Spain")
        helloworld.say_hello("@firedev", "Phuket, Thailand")
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhelloworld, India")
        helloworld.say_hello("@karlos_georgy", "Kaufbeuren, Germany")
        helloworld.say_hello("@twobbler", "Antwerp, Belgium")
        helloworld.say_hello("@amosdalmeri", "Brescia, Italy")
        helloworld.say_hello("@_jidemuritala", "Reus, Spain")
        helloworld.say_hello("@mmiy55", "Osaka, Japan")
        helloworld.say_hello("@j3nnn1", "Ciudad Autónoma de Buenos Aires, Argentina")

        tweet = helloworld.generate_availability_tweets
        #initial_tweet, reply_tweet = tweet.slice(0...Helloworld::TWEET_CHARACTER_LIMIT), tweet.slice(Helloworld::TWEET_CHARACTER_LIMIT+1...tweet.length)

        puts "The availability tweet part 1 looks like:"
        puts tweet[0]
        puts "The availability tweet part 2 looks like:"
        puts tweet[1] unless tweet[1].nil?

        expect(tweet[0].size).to be <= Helloworld::TWEET_CHARACTER_LIMIT

        expect(tweet[0]).to include('@theOnlyMaDDogx')
        expect(tweet[0]).to include('@alterisian')
        expect(tweet[0]).to include('@bsilva96')
        expect(tweet[0]).to include('@lucianghinda')

        expect(tweet[1]).to include('@j3nnn1')        
      end
    end
  end

  context '#all_tweets' do
    it 'returns twitter urls for everyone, on a newline per handle' do
      VCR.use_cassette("returns_twitter_urls_for_everyone") do
        helloworld = Helloworld.new
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@esquinas", "Málaga, Spain")
        helloworld.say_hello("@sidonath", "Málaga, Spain")
        twitters = helloworld.all_tweets
        puts "twitters: #{twitters}"
        expect(helloworld.everyone.count).to eq(3)
        expect(twitters.lines.count-1).to eq(3)
        expect(twitters).to_not include('@')
        expect(twitters).to include(Helloworld::TWITTER_BASE_URL)
      end
    end
  end

  context '#in_timezone_of' do
    it 'returns people in the same timezone as that of a given person' do
      VCR.use_cassette("in_timezone_of_returns_people_in_the_same_timezone_as_that_of_a_given_person") do
        helloworld = Helloworld.new
        helloworld.say_hello("@alterisian", "Málaga, Spain")
        helloworld.say_hello("@esquinas", "Málaga, Spain")
        helloworld.say_hello("@sidonath", "Málaga, Spain")
        helloworld.say_hello("@lucianghinda", "Bucharest, Romania")
        helloworld.say_hello("@theOnlyMaDDogx", "New Delhi, India")

        expect(helloworld.in_timezone_of("@alterisian")).to eq(%w[@alterisian @esquinas @sidonath])
      end
    end
  end

end
