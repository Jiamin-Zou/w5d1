require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next unless self.prev.nil?
    self.next.prev = self.prev unless self.next.nil?
    self.next = nil
    self.prev = nil
    self
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

end

class LinkedList
include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return nil if self.empty?
    @head.next
  end

  def last
    return nil if self.empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each { |node| return node.val if node.key == key}
    nil
  end

  def include?(key)
    self.any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key,val)

    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
    nil    
  end

  def remove(key)
    self.each do |node|
      # debugger
      if node.key == key
        node.remove
        # debugger
        return node.val
      end
    end
    nil
  end

  def each(&prc)
    prc ||= Proc.new {|a| a}
    node = @head.next
    # debugger
    while node != @tail
      # debugger
      prc.call(node)
      # debugger
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end