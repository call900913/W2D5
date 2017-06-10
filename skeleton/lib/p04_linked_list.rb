require 'byebug'
class Link
  attr_accessor :key, :val, :next, :prev

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
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end

end


class LinkedList
  include Enumerable
  def initialize
    @sentinel = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next.nil? && @sentinel.prev.nil?
  end

  def get(key)
    return nil if empty?
    each do |link|
      return link.val if link.key == key
    end

  end

  def include?(key)
    return nil if empty?
    any? do |link|
      link.key == key
    end
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.next = @sentinel
    if empty?
      @sentinel.next = new_link
      @sentinel.prev = new_link
      new_link.prev = @sentinel
    else
      @sentinel.prev.next = new_link
      new_link.prev = @sentinel.prev
      @sentinel.prev = new_link
    end
  end

  def update(key, val)
    # byebug
    return nil if empty?
    each do |link|
      if link.key == key
        link.val = val
      end
    end
  end

  def remove(key)
    return nil if empty?
    each do |link|
      link.remove if link.key == key
    end
  end

  def each(&prc)
    current_link = @sentinel.next

    until current_link == @sentinel
      prc.call(current_link)
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
