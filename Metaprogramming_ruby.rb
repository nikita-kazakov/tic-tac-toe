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


