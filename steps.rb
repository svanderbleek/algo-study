class Steps
  attr_reader :count

  def initialize
    @count = 0
  end

  def add(steps)
    @count += steps
  end
end
