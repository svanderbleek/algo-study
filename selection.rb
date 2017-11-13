require 'minitest/autorun'
require './steps.rb'

def selection_sort(list, steps = nil)
  (0..list.size - 2).each do |swap_index|
    min_index = swap_index
    (min_index + 1..list.size - 1).each do |compare_index|
      steps&.add(1)
      min_index = compare_index if list[compare_index] < list[min_index]
    end
    list[swap_index], list[min_index] = list[min_index], list[swap_index]
  end
  list
end

describe 'selection_sort' do
  it 'returns sorted list' do
    sorted = (1..10).to_a
    assert_equal(selection_sort(sorted.shuffle), sorted)
  end

  it 'runs n(n-1)/2' do
    steps = Steps.new
    n = 10
    sorted = (1..n).to_a
    selection_sort(sorted.shuffle, steps)
    assert_operator steps.count, :<=, n * (n - 1) / 2
  end
end
