require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
      self[key].any? { |el| el == key }
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  def show
    print @store
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    old_store_nums = @store.dup.flatten
    @store = Array.new( num_buckets * 2 ) { Array.new }
    old_store_nums.each { |num| insert(num) }
  end
end
