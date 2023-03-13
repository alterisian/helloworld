Person = Struct.new(:name, :location, :coordinates) do
  def to_s
    "#{name}, #{location}"
  end
end