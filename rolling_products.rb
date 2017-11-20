require 'minitest/autorun'
require './steps.rb'

def get_products_of_all_ints_except_at_index(ints)
  forward_products = rolling_products(ints)[0..-2]
  reverse_products = rolling_products(ints.reverse).reverse[1..-1]
  forward_products.zip(reverse_products).map { |a, b| a * b }
end

def rolling_products(ints)
  ints.inject([1]) do |products, next_int|
    products << products.last * next_int
  end
end

describe 'the shit' do
  it 'does the shit' do
    result = get_products_of_all_ints_except_at_index([1, 2, 6, 5, 9])
    assert_equal [540, 270, 90, 108, 60], result
  end
end
