require 'minitest/autorun'
require './steps.rb'

def get_max_profit(prices, steps = nil)
  return 0 if prices.count < 2
  min_price = prices[0]
  max_profit = prices[1] - prices[0]
  prices[1..-1].each do |price|
    steps&.add(1)
    profit = price - min_price
    max_profit = [max_profit, profit].max
    min_price = [min_price, price].min
  end
end

describe "stuff" do
  it "works" do
    assert_equal 6, get_max_profit([10, 7, 5, 8, 11, 9])
  end

  it "linear" do
    prices = (1..10).to_a.shuffle
    steps = Steps.new
    get_max_profit(prices, steps)
    assert_operator steps.count, :<=, prices.count
  end
end
