require 'minitest/autorun'

class Heap
  def initialize
    @heap = []
  end

  def add(val)
  end

  def remove(val)
  end

  def max()
    heap.first
  end

  private

  attr_reader :heap
end

describe 'heap' do
  it 'tracks max' do
    heap = Heap.new
    max = 15
    [9, 2, 5, max, 4].each { |v| heap.add(v) }
    assert_equal(heap.max, max)
  end
end
