require 'minitest/autorun'

def highest_product_of_3(ints)
  return if ints.count < 3
  highest_pos = []
  highest_neg = []
  ints.each do |int|
    if int.negative?
      highest_neg = [*highest_neg, int].sort.reverse[0..1]
    else
      highest_pos = [*highest_pos, int].sort[0..2]
    end
  end
  neg_product = [*highest_neg, highest_pos.max].inject(:*)
  pos_product = highest_pos.inject(:*)
  [neg_product, pos_product].max
end

describe 'it' do
  it 'works' do
    assert_equal 5000, highest_product_of_3([1, 10, -5, 1, -100])
  end
end
