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




