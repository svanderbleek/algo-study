require 'minitest/autorun'

def merge_ranges(ranges)
  merged = []
  ranges.each do |range|
    start_overlap = merged.find { |other| range[0].between?(*other) }
    end_overlap = merged.find { |other| range[1].between?(*other) }
    next if !start_overlap.nil? && start_overlap == end_overlap
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

describe 'it' do
  it 'works' do
    assert_equal [[0, 1]], merge_ranges([[0, 1]])
    assert_equal [[0, 2]], merge_ranges([[0, 2], [0, 1]])
  end
end
