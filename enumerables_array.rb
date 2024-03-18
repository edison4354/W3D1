require 'byebug'

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
    self.each_with_index {|ele, idx| res[idx] << ele}
    arrays.each do |array|
      (0...self.length).each do |i|
        res[i] << array[i]
      end
    end

    res.each do |array|
      if array.length < arrays.count + 1
        short_fall = array.count + 1 - array.length
        short_fall.times do
          array << nil
        end
      end
    end
    res
  end

  def my_rotate(num = 1)

    remainder = num % self.length
    self[remainder..-1] + self[0...remainder]

  end

  def my_join(mark = '')
    res = ''
    self.each do |ele|
      res += ele
      res += mark
    end
    res
  end

  def my_reverse
    res = []
    i = 0
    while i < self.length
      res << self[-1 - i]
      i += 1
    end
    res
  end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"


# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]


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
