module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self[0]
  end
  def my_each_with_index
    v = 0
    i = 0
    while i < self.length
      yield self[v, i]
      v += 1
      i += 1
    end
    self[0,0]
  end
  def my_select
    result = []
    each do |i|
      if yield(i) == true
      result << i
      end
    end
    result
  end
  def my_all?
    result = []
    each do |i|
      if yield(i) == true
        result << true
      else
        result << false
      end
    end
      if result.include? false
        return false
      else
      return true
    end
  end
  def my_any?
    each do |i|
      if yield(i) == true
        return true
      else
        return false
      end
    end
    return
  end
  def my_none?
    result = []
    each do |i|
      if yield(i) == true
        result << true
      else
        result << false
      end
    end
      if result.include? true
        return false
      else
      return true
    end
  end
  def my_count(number=nil)
    result = []
    if block_given?
      each do |i|
        if yield(i) == true
          result << true
        else
          result << false
        end
        return result.length
      end

    elsif number.nil?
          return self.length
    else
      each do |i|
        if number == i
          result << number
        end
          return result.length
      end
    end
  end
  def my_map(&my_proc)
    result = []
    each do |i|
        result << my_proc.call(i) || yield[i]
    end
    result
  end
  def my_inject(initial=nil)
    result = initial
    each do |i|
      if result.nil?
        result = i
      else
        result = yield(result, i)
      end
    end
    result
  end
end



#def my_map
#  result = []
#  each do |i|
#    result << yield(i)
#  end
#  result
# end
