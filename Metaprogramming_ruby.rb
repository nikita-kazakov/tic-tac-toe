#Chapter 1

class Greeting

  def initialize(text)
    @text = text
  end

  def welcome
    @text
  end

end

my_object = Greeting.new("Hello")

#Let's ask the class questions:
my_object.class #Greeting
p my_object.is_a?(Greeting) #True

#Let's ask the class for it's instance methods.
#'false' argument will only show instance methods you defined, not ones you've inherited.
p Greeting.instance_methods(false) #[:welcome]

#What instance variables does your object have? notice it returns a hash.
p my_object.instance_variables #[@text]


#Chapter 2 - Monday
#You're building a bookcase app. In a bookcase class, you have this to_alphanumeric method.
#<==strips out all special characters leaving on alpha numerics and spaces
def to_alphanumeric(s)
  s.gsub(/[^\w\s]/,'')
end

p to_alphanumeric("Go( $483-Hi- give") #"Go 483Hi give"

#Since you're asking Strings to convert this to alpha numeric, wouldn't it be better
#to just apply this to strings?
#
class String
  def to_alphanumeric
    gsub(/[^\w\s]/,'')
  end
end

p "go*#&# here".to_alphanumeric #"go here"

#You didn't have to create a whole new string class, you just added to it!
#Ruby doesn't redefine the string class because it knows it already exists... it
#simply opens it up and defines the method to_alphanumeric there!

#I'll demonstrate this here:

class First
  def a
    'a'
  end
end

p First.object_id #47194324209840

class First
  def b
    'b'
  end
end

p First.object_id #47194324209840  <==Same. It didn't recreate a new class. Just re-opened and added.

#You can think of  "class" as it's core job is to move you into the context of a class when you can define it's methods. Just a scope change.

#However, there is a darkside to using "OPEN CLASSES". You might overwrite an existing method...
#Then you're in trouble...
#When you change open classes like this, people say you "monkeypatch". It's derogatory.





#Chapter2 continuation: Inside the Object Model
class MyClass
  def my_method
    @var = 1
  end
end

obj = MyClass.new
p obj.class #MyClass
p obj.instance_variables

#Did you know that CLASSES have methods, not the instance objects.
#It's because objects share the same class also share the same methods.
#So methods must be stored in the class, not the object itself.



#Classes are NOTHING BUT OBJECTS themselves.
p "hello".class  #String
p String.class #Class

p Array.ancestors #[Array, Enumerable, Object, Kernel, BasicObject]
p Array.superclass #Object
p Object.superclass #BasicObject

#Every Ruby class has a single superclass except BasicObject,
#which is the end of the inheritance chain and doesn’t have a superclass.

p BasicObject.superclass #nil
#There is no superclass of Nil. Nil is Nil.

p String.superclass #Object
p Hash.superclass #Object

#Look at that, superclass method shows they are all objects.

#What's the super class of Class? It's module
p Class.superclass #Module
#A class is a MODULE with three instance methods: new, allocate, and superclass.
p Class.instance_methods(false) #[:allocate, :superclass, :new]

#What's the difference between a Module and a Class?
#A class is simply a MODULE with three instance methods (new, allocate and superclass). That's it.
#That means a class can be instantiated (new method) while a module cannot.

#classes are just objects that inherit from modules...
#You then create objects from Classes (Car1, Car2)
#You can hold on to a class with a reference (variable)
class MyClass
end
my_class = MyClass
#my_class and MyClass will reference the same INSTANCE of a class.
#The only difference is that MyClass is a constant while my_class is a variable.

#Constants are any reference that begin with a capital letter, including names of classes or modules.


#Constants are kind of like a File Directory
module MyModule
  MyConstant = 'outer constant'

  class MyClass
    MyConstant = 'Inner constant'
  end
end

#Those MyConstants are not the same. Follow the indentation!
#It's like a tree similar to a file system.
# --MyModule
#   -MyConstant
#   --myClass
#     -MyConstant

#See how the first MyConstant is in the MyModule folder while the second is in myClass folder?
#Modules and Classes are like directories. Constants are files.
#As long as they are in different directories, you can have the files with the same name.

#You can even access these constants from different directories with a double semi-colon:

p MyModule::MyConstant # "outer constant"

module Cabinet

  class Drawer
    Book = 'Moby Dick'
  end

    Drawer::Book #Moby Dick

end

p Cabinet::Drawer::Book #Moby Dick
#Notice that this file system really works really well for classes and modules and constants.
#You can't call a local variable from a module or a class this way. There is still encapsulation.

#You can also go OUT of the file structure...kind of like "..\..\"
Y = 'a global constant'
module M
  Y = 'constant in module M'
  Y # "a constant in M"
  ::Y # 'a global constant'
end


#Module class can also return all the constants that it has.
#This is kind of like the file system "ls" <=list directory
p M.constants #[:Y]

#If you want the current path of the constant you're accessing, use the #nesting method.

module M
  class C
    module M2
      p Module.nesting #[M::C::M2, M::C, M]
    end
  end
end

#Whoa, lots of similarities between Ruby constants (Modules and Classes are CONSTANTS, remember) and your files on your computer.
#You can even use modules to ORGANIZE your constants the same way you use your directories to organize your files.
#you recognize RAKE, right?

#module Rake
# class Task

#They used a module called rake to organize Task and FileTask just in case
#there would be a collision with other classes. Now there isn't. YOu simply access Rake::Task


#So what if Rake was to be upgraded to version 2.0, what happens with 1.0 users?
#It provided a command-line option "classic-namespace" that loaded an additional source file which
#assigned new safer constant names to old unsafe ones.


#*********
#SUMMARY
#*********

#So what's an object?
#It's a class with a bunch of instance variables within it.
p obj = "Hi"
p obj = String.new("Hi")
#See, SAME DAMN THING.

#So what's a class?
#It's an object (instance of a class), plus a list of instance methods and link to a superclass (inheritance).
class A
end
p A.is_a?(Object) #True
p A.superclass #Object
p Class.superclass #Module
#A class is a subclass of a Module.

#What's the class of an object?
p Object.class #Class
#ALL OBJECTS are CLASSES in Ruby. For example
# "Hi there" is String.new("Hi there") (it's a string CLASS)
# [1,2,3] is really Array.new(1,2,3) (it's an array CLASS)
# Same with Hash and numbers
p String.class #Class
p Numeric.class #Class
p Array.class #Class
p Class.class #Class






#New SECTION - Using NameSpaces
#Somewhere in the code, there is a module called "Text"
module Text
end

#As we continue through the program in the book "bookworm" we stumble on this class:
class TEXT
end

#You say, wait a minute...let's rename that to just "Text", camelcased.

#class Text
#end

# You get ERROR: Text is not a class (TypeError). What the heck happened?

#You already had a module named Text. Ruby raised an error on naming the class Text.
#The solution? wrap that class sucker in a module.

module Bookworm
  class Text
    p'boom, it works now'
  end
end

#You can now change references to:
Bookworm::Text





#Calling a Method
#When you call a method, 2 things happen:
#1 - It finds the method using a process called METHOD LOOKUP.
#2 - It executes the method and it needs "SELF" to do that.


#When you call a method, Ruby looks into the objects class and finds a method there.
#You can show this using a debugger.

#You should know about the RECEIVER and ANCESTORS CHAIN
#The receiver is the object you call the method on:
class Dude
  def speak
    "Yo!"
  end
end

dude1 = Dude.new
p dude1.speak #<==dude1 is the receiver here.

#Receiver chain? Simple.  Ruby goes into receiver class and if it doesn't find a method there, it goes up
#the ancestors chain until it finds the method.

class BigDude < Dude
end

bigdude1 = BigDude.new
bigdude1.speak
#Notice that to call bigdude1.speak, it had to go to the BigDude class...didn't find speak method there,
#then went to Dude class as it is inherited and found it there! If it didn't find it there it would follow
#the chain all the way to BasicObject

#You can ask an object for it's ancestor chain like this:
p BigDude.ancestors #[BigDude, Dude, Object, Kernel, BasicObject]

#What the heck is the Kernel doing in the ancestors?
#Actually, ancestor chain doesn't just go from Class to Superclass...it also includes MODULES. when you INCLUDE
#a module in a class, Ruby will insert the module in the ancestor chain.
#That means Kernel is module


#Let's take a look at what we mean. Let's INCLUDE the module within the vehicle class.
module BasicLocomotive
end

class Vehicle
  include BasicLocomotive
end

class Car < Vehicle
end

#Notice that Ruby first scans Vehicle class and THEN BasicLocomotive
p Car.ancestors #[Car, Vehicle, BasicLocomotive, Object, Kernel, BasicObject]




#You can reverse that. You can make it so that it first scans BasicLocomotive and THEN Vehicle using prepend.
# I couldn't get it to work here for some reason.
module BasicLocomotive
end

class Vehicle
  prepend BasicLocomotive
end

class Car < Vehicle
end

#Notice that Ruby first scans Vehicle class and THEN BasicLocomotive
p Car.ancestors #Prepend doesn't work for some reason. I don't know why.







#So what the heck is Kernel? It shows up in our ancestor chain.
#Kernel includes methods such as "print" that you can call from ANYWHERE in your code.
# Look at how Kernel is AFTER the Object in the chain.
p Class.ancestors #[Class, Module, Object, Kernel, BasicObject]

#This means any object can call Kernel and it's methods, including print. Print is simply a method.
#If you add a method to the Kernel module, it will be available to ALL objects.



#Back to methods again, recall:
# #When you call a method, 2 things happen:
# #1 - It finds the method using a process called METHOD LOOKUP.
# #2 - It executes the method and it needs "SELF" to do that.

#We now know how method lookup (1) works with ancestor chain.
#How does it execute the method(2)?

#How will this get executed? You need to answer 2 questions:
#1- What object does the instance variables @x belong to?
#2- What object should you call my_other_method on?
def my_method
  temp = @x + 1
  my_other_method(temp)
end

#As a human you're smart, you see that @x and my_other_method belongs to the receiver...the object that
#my_method was called upon.  Computers aren't that smart.

#EVERY line of Ruby is executed within an object (think of scope), the CURRENT object. The current object is also
#known as self. You can access it with the self keyword.

#When you call a method, the receiver becomes SELF. From that moment on, all instance variables are instance
#variables belonging to SELF. All methods without an explicit reciever are called on SELF. That continues until
#your code calls a method upon some other object.
#Let's look at a simple example:

class MyClass
  def testing_self
    @var = 10
    my_method
    self
  end

  def my_method
    @var = @var + 1
  end
end

obj = MyClass.new
p obj.testing_self ##<MyClass:0x0000559edbc25a90 @var=11>

#What happened? It returned "MyClass". The scope from which #testing_self ran from was MyClass. It ran my_method, which
#again had the self receiver, which was MyClass, and returned self.

#In other words, this below would be the same as above:
class MyClass
  def testing_self
    @var = 10
    self.my_method #I added self.my_method to make it more explicit. Ruby does this itself.
    self
  end

  def my_method
    @var = @var + 1
  end
end

obj = MyClass.new
p obj.testing_self ##<MyClass:0x0000559edbc25a90 @var=11>


#Now that you know SELF, we can take a look at how private methods work.
#You can't call a private method with an EXPLICIT receiver. That means if you want to call a private method,
#it can only be called by an IMPLICIT receiver (which is self)


class C
  def public_method
    p self
    p private_method
  end
  private

  def private_method
    p self
  end
end

C.new.public_method

#So who is the receiver at any moment?
#You just learned that anytime you call a method on an object that object becomes self.

#you can ask ruby this question anytime. Just stick self inside a method or a module or class to know.
p self #main
p self.class #Object

#MAIN is the top level stack. Top level context. GLOBAL.
class Gold
  self #MyClass
end


#QUIZ TIME. See code below:
module Printable
  def print
    # ...
    "Printable#print()"
  end

  def prepare_cover
    # ...
  end
end


module Document
  def print_to_screen
    prepare_cover
    format_for_screen
    print
  end

  def format_for_screen
    # ...
  end

  def print
    # ...
    "Document#print()"
  end
end

class Book
  include Document
  include Printable #<==this one is the first in chain...counter intuitive but run ancestors on Book class..you'll see.
  # ...
end

b = Book.new
b.print_to_screen

#The company says there's a bug because the WRONG PRINT is being called. Which print_to_screen is called?
#The one from Printable or the one from document?
#Let's check book ancestors:
Book.ancestors  # => [Book, Printable, Document, Object, Kernel, BasicObject]

#When you call b.print_to_screen, the object referenced by b becomes self. That object is Book.
#
#Whew, you're done for monday. Next day, we'll talk more indepth about methods. Don't worry...this was
#a lot of information to handle.