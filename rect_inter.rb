require 'minitest/autorun'

def intersection(r1, r2)
  x_interval = interval_intersection(*[[r1[:x], r1[:w]], [r2[:x], r2[:w]]].sort)
  y_interval = interval_intersection(*[[r1[:y], r1[:h]], [r2[:y], r2[:h]]].sort)
  {
    x: interval_beg(x_interval),
    w: interval_size(x_interval),
    y: interval_end(y_interval),
    h: interval_size(y_interval)
  }
end

def interval_intersection(interval, other)
  [make_interval_end(interval), interval_beg(other)]
end

def interval_size(interval)
  interval_end(interval) - interval_beg(interval)
end

def interval_beg(interval)
  interval[0]
end

def interval_end(interval)
  interval[1]
end

def make_interval_end(interval)
  interval[0] + interval[1]
end

describe 'it' do
  it 'is great' do
    assert_equal(
      {x: 1, y: 1, w: 1, h: 1},
      intersection(
        {x: 0, y: 0, w: 2, h: 2},
        {x: 1, y: 1, w: 2, h: 2}
      )
    )
  end
end
