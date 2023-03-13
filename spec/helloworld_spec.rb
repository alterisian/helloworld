require_relative "../helloworld.rb"

describe Helloworld do
  it "displays a name." do
    # helloworld = Helloworld.new
    # expect()
  end
  it "shows location is west of another" do
    helloworld = Helloworld.new
    helloworld.say_hello("@alterisian", "Málaga, Spain")
    helloworld.say_hello("@bsilva96", "Machalí, Chile")    

    expect( helloworld.west_of("@alterisian") ).to eq(["@bsilva96, Machalí, Chile"])
  end
end
