require 'minitest/autorun'
require 'pp'

class Node
  attr_reader :val, :children

  def initialize(val, *children)
    @val = val
    @children = children
  end
end

def depth(tree, &f)
  stack = []
  stack.unshift(tree)
  while stack.any?
    node = stack.pop
    f.call(node.val)
    stack.push(*node.children.reverse)
  end
end

def breadth(tree, &f)
  queue = []
  queue.push(tree)
  while queue.any?
    node = queue.shift
    f.call(node.val)
    queue.push(*node.children)
  end
end

def abstract(tree, remove, bullshit, &f)
  struct = []
  struct.push(tree)
  while struct.any?
    node = struct.send(remove)
    f.call(node.val)
    struct.push(*node.children.send(bullshit))
  end
end

def mergesort(array, steps=nil)
  if array.size != 1
    last = array.size - 1
    split = last / 2
    merge(mergesort(array[0..split]), mergesort(array[split+1..last]))
  else
    array
  end
end

def merge(a1, a2)
  merged = []
  while a1.any? && a2.any?
    if a1.first <= a2.first
      merged.push(a1.shift)
    else
      merged.push(a2.shift)
    end
  end
  merged + a1 + a2
end

def quicksort(array, steps=nil)
  pivot = (0..array.size-1).sample
end

dtree =
  Node.new(1,
    Node.new(2,
      Node.new(3,
        Node.new(4),
        Node.new(5)),
      Node.new(6)),
    Node.new(7),
    Node.new(8,
      Node.new(9,
        Node.new(10),
        Node.new(11)),
      Node.new(12)))

btree =
  Node.new(1,
    Node.new(2,
      Node.new(5,
        Node.new(9),
        Node.new(10)),
      Node.new(6)),
    Node.new(3),
    Node.new(4,
      Node.new(7,
        Node.new(11),
        Node.new(12)),
      Node.new(8)))

describe 'basics' do
  it 'depth' do
    answer = []
    depth(dtree) { |val| answer << val }
    assert_equal (1..12).to_a, answer
  end

  it 'breadth' do
    answer = []
    breadth(btree) { |val| answer << val }
    assert_equal (1..12).to_a, answer
  end

  it 'abstract' do
    danswer = []
    banswer = []
    abstract(dtree, :pop, :reverse) { |val| danswer << val }
    abstract(btree, :shift, :itself) { |val| banswer << val }
    assert_equal (1..12).to_a, danswer
    assert_equal (1..12).to_a, banswer
  end

  it 'merge' do
    assert_equal (1..10).to_a, mergesort((1..10).to_a.shuffle)
  end

  it 'quick' do
    assert_equal (1..10).to_a, quicksort((1..10).to_a.shuffle)
  end
end
