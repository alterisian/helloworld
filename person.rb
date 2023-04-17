Person = Struct.new(:name, :location, :coordinates, :timezone) do
  def to_s
    "#{name}, #{location}"
  end
end