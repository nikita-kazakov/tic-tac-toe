#September 19, 2019
#Let's talk about methods in Chapter 3.


#In compiled languages such as Java or C, the compiler checks to see that the receiving object
#has a matching method. This is called Static Type Checking.  These are static languages.
#If you call #speak on Person object and it doesn't exist, the application WONT compile.

#Dynamic languages (Python, Ruby, Javascript) don't have a compiler. When you run your script,
#checks don't happen in the beginning. You'll only get an error when you call on #speak and
#that method doesn't exist.  There is no A-priori checking.


#With static languages, the compiler can catch some of your errors BEFORE the program is run.
#However...there's a price to pay. That means you might have to write repetitive methods to make
#the compiler happy. Methods that do nothing but delegate to some other object...setters and getters.

#In ruby, you don't need boilerplate methods because it's dynamic. Let's focus on those techniques in this chapter.




#***************
#Duplication Problem
#***************

#Your boss asks you to work on program that raises a flag if company expenses are greater than $(99).
#You have a legacy system that looks like this...THis is already in place:
class DS
  def initialize; end #In initialize, you hook up to the database.

  def get_cpu_info(workstation_id); end
  def get_cpu_price(workstation_id); end

  def get_mouse_info(workstation_id); end
  def get_mouse_price(workstation_id); end

  def get_keyboard_info(workstation_id); end
  def get_keyboard_price(workstation_id); end

end


#To get prices, you run:
ds = DS.new

ds.get_cpu_info(42) #Intel i386
ds.get_cpu_price(42) #Price of cpu for workstation #42. $120

ds.get_mouse_info(42) #Dell Wireless
ds.get_mouse_price(42) # $60

#Look at all that duplication. You need different methods that are verbose just to get prices for different items.
#So now, you create a Computer class because you'll be getting prices for EACH COMPUTER in the company.

class Computer

  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = DS.new
  end

  def mouse
    info = @data_source.get_mouse_info
    price = @data_source.get_mouse_price
    "#{info} - #{price}" if price >= 100
  end

  def keyboard
    info = @data_source.get_keyboard_info
    price = @data_source.get_keyboard_info
    "#{info} - #{price}" if price >= 100
  end

end

#Look at that duplication above. That's just for mouse and keyboard! We need to add a lot more.
#Your mentor says there are two ways to remove this duplication.
#1 - Dynamic Methods
#2 - method_missing


#When you learn to call and define methods dynamically, you will remove duplicated code.
#When you call a method, you're actually sending a message to an object (the receiver).


#You can call using the standard dot notation:
p "Hello".upcase #"HELLO"
#You can do the same by using the Object#send instead of the dot notation.
p "Hello".send(:upcase)
#<you're sending the String object a message (UPCASE). It still calls my_method but through send.
#Notice it uses a symbol to access the method. Remember, symbol lives in the same memory. Can't be string
#because it would just create a new memory area for it and not use the method.
#Just FYI, #send is powerful. It will even breach private methods. In the wild, this happens all the time.



#What the hell are the differences between SYMBOLS and STRINGS?
p :x.class #Symbol
p "x".class #String

#Defining methods DYNAMICALLY on the spot.
#Yep, you can define methods on the spot with a block.
#This technique is called Dynamic Method.
class MyClass
  define_method :my_method do |arg|
    arg * 3
  end
end
obj = MyClass.new
p obj.my_method(2) # 6

#But why would you want to use #define_method rather than the normal #def in a class?
#Because using #define_method allows you to decide the name of the defined method at RUN TIME.


#Let's go back to our original problem again:
class Computer

  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = DS.new
  end

  def mouse
    info = @data_source.get_mouse_info
    price = @data_source.get_mouse_price
    "#{info} - #{price}" if price >= 100
  end

  def keyboard
    info = @data_source.get_keyboard_info
    price = @data_source.get_keyboard_info
    "#{info} - #{price}" if price >= 100
  end

end

#Let's refactor:

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse #<==we delegate getting the mouse info to the COMPONENT method. We just feed it a name as a symbol.
    component :mouse
  end

  def keyboard
    component :keyboard
  end

  def component(name)
    info  = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    "#{info} - #{price}" if price >= 100
  end
end

#The advantage is that if you EVER need to change the way you're grabbing data, you'll only need
#to change it in the component method. That's it.

my_computer = Computer.new(42, DS.new)
my_computer.keyboard #<== CPU: 2.16ghz ($220)

#So this is how DYNAMIC methods work. Good progress, good refactoring but you still need to duplicate
#many methods called mouse, keyboard, cpu, etc...
#Your mentor and you refactor this thing further:
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def self.define_component(name)
    define_method(name) do                #<==Whoa...it just creates a method on the fly! That's why you use define_method.
      info  = @data_source.send("get_#{name}_info", @id)
      price = @data_source.send("get_#{name}_price", @id)
      "#{info} - #{price}" if price >= 100
    end
  end

  define_component(:mouse) #<==the implicit self is the COMPUTER HERE. This is why your define_component method has to be a SELF (computer) class Method.
  define_component(:cpu)

end

#NOT BAD...we just cut down a bunch of def end methods to just single liners.

