require 'minitest/autorun'
require './steps.rb'

def sliding_window_maxs(nums, window_size, steps = nil)
  nums.each_cons(window_size).map do |window|
    steps&.add(window_size)
    window.max
  end
end

describe 'sliding_window_maxs' do
  it 'returns list' do
    assert_equal(sliding_window_maxs([], 1), [])
  end

  it 'is parameterized by window size' do
    assert_equal(sliding_window_maxs([1, 2], 1), [1, 2])
    assert_equal(sliding_window_maxs([1, 2], 2), [2])
  end

  it 'is efficient' do
    steps = Steps.new
    n = 10
    w = 3
    sliding_window_maxs((1..n), w, steps)
    assert_equal steps.count, n
  end
end
