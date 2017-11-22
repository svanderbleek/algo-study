require 'minitest/autorun'
require './steps.rb'

def merge_ranges_slow(ranges, steps = nil)
  merged = []
  ranges.each do |range|
    steps&.add(2 * merged.size)
    start_overlap = merged.find { |other| range[0].between?(*other) }
    end_overlap = merged.find { |other| range[1].between?(*other) }
    next if !start_overlap.nil? && start_overlap == end_overlap
    steps&.add(2 * merged.size)
    merged.delete(start_overlap)
    merged.delete(end_overlap)
    if start_overlap && end_overlap
      merged << [start_overlap[0], end_overlap[1]]
    elsif start_overlap
      merged << [start_overlap[0], range[1]]
    elsif end_overlap
      merged << [range[0], end_overlap[1]]
    else
      merged << range
    end
  end
  merged
end

def merge_ranges(ranges, steps = nil)
  return ranges unless ranges.size > 1
  sorted = ranges.sort
  steps&.add(Steps.sort_cost(ranges))
  sorted[1..-1].each_with_object([sorted.first]) do |range, merged|
    steps&.one
    if range[0].between?(*merged.last)
      unless range[1].between?(*merged.last)
        last = merged.pop
        merged << [last[0], range[1]]
      end
    else
      merged << range
    end
  end
end

describe 'it' do
  it 'works' do
    assert_equal [[0, 1]], merge_ranges([[0, 1]])
    assert_equal [[0, 2]], merge_ranges([[0, 2], [0, 1]])
    assert_equal [[1, 3]], merge_ranges([[1, 2], [2, 3]])
    assert_equal [[1, 5]], merge_ranges([[1, 5], [2, 3]])
    assert_equal [[1, 10]], merge_ranges([[1, 10], [2, 6], [3, 5], [7, 9]])
  end

  it 'efficient' do
    steps = Steps.new
    n = 10
    c = 2
    ranges = (1..n).to_a.shuffle.zip((1..n).to_a.shuffle)
    merge_ranges(ranges, steps)
    assert_operator steps.count, :<=, c * n * Math.log(n, 2)
  end
end
