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
end


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
