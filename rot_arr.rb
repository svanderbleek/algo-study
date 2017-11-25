require 'minitest/autorun'
require './steps.rb'
require 'pp'

def search_regular(array, value, steps = nil)
  lo = 0
  hi = array.size - 1
  while lo != hi
    steps&.one
    mid = lo + (hi - lo) / 2
    if mid == lo || mid == hi
      lo = hi = lo + array[lo..hi].index(value)
    elsif value < array[mid]
      hi = mid
    else
      lo = mid
    end
  end
  lo
end

def search_rotated(array, value, steps = nil)
  lo = 0
  hi = array.size - 1
  while lo != hi
    steps&.one
    mid = lo + (hi - lo) / 2
    if mid == lo || mid == hi
      if value == array[lo]
        hi = lo
      elsif value == array[hi]
        lo = hi
      end
    elsif subsorted?(array, lo, mid)
      if value.between?(array[lo], array[mid])
        hi = mid
      else
        lo = mid
      end
    elsif subsorted?(array, mid, hi)
      if value.between?(array[mid], array[hi])
        lo = mid
      else
        hi = mid
      end
    end
  end
  lo
end

def subsorted?(array, i, j)
  array[i] < array[j]
end

describe 'it' do
  it 'regular' do
    n = 10
    regular = (1..n).to_a
    value = regular.sample
    index = regular.index(value)
    steps = Steps.new
    assert_equal index, search_regular(regular, value, steps)
    assert_operator steps.count, :<=, n * Math.log(n, 2)
  end

  it 'rotated' do
    n = 10
    rotated = (1..n).to_a.rotate(rand(n))
    value = rotated.sample
    index = rotated.index(value)
    steps = Steps.new
    assert_equal index, search_rotated(rotated, value, steps)
    assert_operator steps.count, :<=, n * Math.log(n, 2)
  end
end
