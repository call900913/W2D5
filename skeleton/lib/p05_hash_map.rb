require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    each {|link_list| return true if link_list.include?(key)}
    false
  end

  def set(key, val)
    resize! if @count == @store.length
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each(&prc)
    debugger
    @store.each do |link_list|
      next if link_list.empty?
      prc.call(link_list)
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    old_hash_links = []

    each do |linked_list|
      next if linked_list.empty?
      linked_list.each do |link|
        old_hash_links << link
      end
    end

    @store = Array.new(num_buckets * 2) { LinkedList.new }

    old_hash_links.each do |link|
      set(link.key, link.val)
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
