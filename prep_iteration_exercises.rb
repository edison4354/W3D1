# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.
require 'byebug'

def factors(num)
  res = []
  (1..num).each {|div| res << div if num % div == 0}
  res
end

# p factors(20)
# p factors(7)

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  def bubble_sort!(&prc)
    sorted = false

    while !sorted
      (0...self.length - 1).each do |idx|
        sorted = true
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx + 1], self[idx] = self[idx], self[idx + 1]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    unsorted_arr = self.map {|ele| ele }

    sorted = false

    while !sorted
      sorted = true
      (0...unsorted_arr.length - 1).each do |idx|
        if prc.call(unsorted_arr[idx], unsorted_arr[idx + 1]) == 1
          unsorted_arr[idx + 1], unsorted_arr[idx] = unsorted_arr[idx], unsorted_arr[idx + 1]
          sorted = false
        end
      end
    end
    unsorted_arr
  end
end

# p [1, 3, 5, 8, 4].bubble_sort! { |num1, num2| num1 <=> num2 }
# p [1, 3, 5, 7, 2].bubble_sort! { |num1, num2| num2 <=> num1 }
# p [1, 3, 5, 8, 4].bubble_sort { |num1, num2| num1 <=> num2 }
# p [1, 3, 5, 7, 2].bubble_sort { |num1, num2| num2 <=> num1 }


# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  res = []
  (0...string.length).each do |i|
    (i...string.length).each do |j|
      res << string[i..j]

    end

  end
  res
end

# p substrings("hello")


def subwords(word, dictionary)
  real_res = []
  res = substrings(word)
  res.each do |sub_word|
    real_res << sub_word if dictionary.include?(sub_word)
  end

  return real_res

end

# p subwords("hello", ["h", "hell", "o", "goodbywe"])

# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.

def doubler(array)
  array.map {|ele| ele * 2 }
end

# p doubler([1, 2, 3, 4, 5, 6])
# p doubler([5, 4, 3, 2, 8, 6])

# ### My Each
# Extend the Array class to include a method named `my_each` that takes a
# block, calls the block on every element of the array, and then returns
# the original array. Do not use Enumerable's `each` method. I want to be
# able to write:
#
# ```ruby
# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]
# ```

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
    prc.call(self[i])
      i += 1
    end
    self
  end
end

return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
# => 1
     2
     3
     1
     2
     3

p return_value # => [1, 2, 3]

# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original array.

class Array
  def my_map(&prc)
    res = []
    self.my_each do |ele|
      res << prc.call(ele)
    end
    res
  end

  def my_select(&prc)
    res = []
    self.my_each do |ele|
      res << ele if prc.call(ele)
    end
    res
  end

  def my_inject(&blk)
    res = self[0]
    self.my_each do |ele|
      res = blk.call(res, ele)
    end
    res
  end
end

p [1, 2, 3, 4].my_inject {|sum, num| sum + num}


# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

def concatenate(strings)
end
