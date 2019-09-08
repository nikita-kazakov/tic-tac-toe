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
#So methods musth be stored in the class, not the object itself.



#Classes are NOTHING BUT OBJECTS themselves.
p "hello".class  #String
p String.class #Class

p Array.ancestors #[Array, Enumerable, Object, Kernel, BasicObject]
p Array.superclass #Object
p Object.superclass #BasicObject
p BasicObject.superclass #nil
#There is no superclass of Nil. Nil is Nil.

p String.superclass #Object
p Hash.superclass #Object

#Look at that, superclass method shows they are all objects.

#What's the super class of Class? It's module
p Class.superclass #Module
#A class is a MODULE with three instance methods: new, allocate, and superclass.
p Class.instance_methods(false) #[:allocate, :superclass, :new]

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

  class myClass
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





