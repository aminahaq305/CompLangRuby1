# Amina Haq | Project 4 | Getting to Know Ruby

# Beginning of class definition
class Pair
  #initialize pair by setting value1 and value2 i.e. car and cdr
  def initialize(value1, value2)
    @value1 = value1
    @value2 = value2
  end

  #return first element of pair or list
  def car
    return @value1
  end

  #return everything but the first element
  def cdr
    return @value2
  end

  #helper function for to_s
  #iterates through each car and cdr pair and returns cdr recursively until cdr is not a pair
  def each_pair
    return to_enum(:each_pair) unless block_given?
    cell = self
    while cell.pair?
      yield cell.car, cell.cdr
      cell = cell.cdr
    end
  end

  # Helper function for to_s
  # return string contained dotted pair representation of list
  def print
    list = "(" #initialize string with open parenthesis "("
    each_pair do |car, cdr| #for each car and cdr pair that exists, do the following iteratively
    list = list + yield(car) #add car to string
    if (cdr.pair?) #if cdr is a pair add a space to string
      list = list + " "
    elsif(cdr == Pair.null) #if cdr is null don't do anything
    else #otherwise, add dot to string
    list = list + " . " + yield(cdr)
    end
    end
    #add ending parenthesis to string
    list = list + ")"
  end

  #calls helper print function
  def to_s
    print &:to_s
  end

  def list? #if the last element of the pair is null, return true else false
    if (cdr == Pair.null)
      return true
    end
    if (cdr.pair? ==  false)
      return false
    end
    return cdr.list? #checks recursively
  end

  #return the number of elements in a list or pair recursively
  def count
    counter = 0 #set count to zero
    if (null?) #if list is empty, return zero
      return 0
    end
    if (car.pair? == false && cdr.pair? == false) #if pair is not a list
      if (car == Pair.null || cdr == Pair.null) #and either of the car or cdr is null return 1
        return 1
      end
      return 2 #otherwise, return 2
    end
    if (car.pair? == true) #if car of pair, is a pair call count on car recursively
      counter = counter + car.count
    end
    if (cdr.pair? == true) #if cdr of pair is a pair, call count on cdr recursively
      counter = counter + cdr.count
    end
    if (car.pair? == false || cdr.pair? == false) #if both aren't null, add 1 to count
      if (car != Pair.null) && (cdr != Pair.null)
        counter = counter + 1
      end
    end
    return counter #return final count
  end

  #reduce the value passed to a single argument
  def reduce_right(val, &block)
    block.call(cdr.reduce_right(val, &block), car)
  end

  #appends a value to the end of a list
  def append(rhs)
    #if calling pair is not a list, return false
    if !(self.list?)
      return false
    end
    lhs = self
    #return a list, with rhs appended to lhs
    lhs.reduce_right(rhs) { |result, item| cons(item, result) }
  end

  def null? #if cdr and car are null, return true, else false
    if (@value1 == Pair.null) && (@value2 == Pair.null)
      return true
    else
      return false
    end
  end

  def self.null #when Pair.null is called, return nil object
    return nil
  end

  def null #self calling function to define Pair.null
    self.class.null
  end
end

#global function cons
def cons(value1, value2) #pairs and lists can be created using cons, which calls pair class
  return Pair.new(value1, value2)
end

#open class Object
class Object
  def pair? #if an object belongs to pair class, return true
    if (self.is_a? Pair)
      return true
    end
    return false
  end
end

# open NilClass
class NilClass
  def list? #a null object is a list
    return true
    end
  def reduce_right(val) #when reduce_right is called on nul object, return the object
    val
  end
end





