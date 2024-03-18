class Array
  def my_each(&prc)
    (0...self.length).each {|idx| prc.call(self[idx])}
  end

  def my_select(&prc)
    array = []
    self.my_each do |ele|
      array << ele if prc.call(ele)
    end
    array
  end

  def my_reject(&prc)
    array = []
    self.my_each do |ele|
      array << ele if !prc.call(ele)
    end
    array
  end

  def my_any?(&prc)
    self.my_each do |ele|
      return true if prc.call(ele)
    end
    false

  end

  def my_all?(&prc)
    self.my_each do |ele|
      return false if !prc.call(ele)
    end
    true
  end

  def my_flatten
    return [] if self == []

    res = []

    self.each do |ele|
      if ele.is_a?(Array)
        res += ele.my_flatten
      else 
        res << ele
      end
    end
    res
  end

  def my_zip(*arrays)
    res = Array.new(self.length) {Array.new}
  end

end

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [1, 2, 3]
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false


# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#  puts num
# end.my_each do |num|
#  puts num
# end
# # => 1
# #    2
# #    3
# #    1
# #    2
# #    3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]
