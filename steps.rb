class Steps
  attr_reader :count

  def initialize
    @count = 0
  end

  def add(steps)
    @count += steps
  end

  def one
    @count += 1
  end

  def self.sort_cost(array)
    array.size * Math.log(array.size, 2)
  end
end
