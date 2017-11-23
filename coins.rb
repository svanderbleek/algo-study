require 'minitest/autorun'
require './steps.rb'

def number_of_ways(amount, denominations, steps = nil)
  ways = Hash.new { |h, k| h[k] = 0 }
  ways[0] += 1
  steps&.sort(denominations)
  denominations.sort.each do |denomination|
    ways.keys.each do |way|
      subamount = way + denomination
      while subamount <= amount
        steps&.one
        ways[subamount] += 1
        subamount += denomination
      end
    end
  end
  ways[amount]
end

describe 'my algo' do
  it 'is baller' do
    assert_equal 4, number_of_ways(4, [3, 2, 1])
    assert_equal 3, number_of_ways(5, [3, 5, 1])
    assert_equal 0, number_of_ways(4, [5, 6])
  end

  it 'is effiecient' do
    denominations = [1, 3, 4, 5]
    n = 10
    m = denominations.count
    steps = Steps.new
    number_of_ways(n, denominations, steps)
    assert_operator steps.count, :<=, n * (Math.log(n, 2) + m)
  end
end
