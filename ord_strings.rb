require 'minitest/autorun'

def all_ord_strs(s1, s2)
  return [s2] if s1.empty?
  return [s1] if s2.empty?
  all_ord_strs(s1[1..-1], s2).map { |s| s1[0] + s } + all_ord_strs(s1, s2[1..-1]).map { |s| s2[0] + s }
end

describe "test" do
  it "tested" do
    assert_equal ["ABCXYZ", "AXYZBC", "ABXYZC", "ABXCYZ", "ABXYCZ", "XABCYZ", "XAYBCZ"], all_ord_strs("ABC", "XYZ")
  end
end
