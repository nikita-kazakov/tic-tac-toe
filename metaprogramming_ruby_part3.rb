#*************
#Let's try Method_Missing
#*************

class Lawyer; end
nick = Lawyer.new
#nick.speak_simply #<=undefined method `speak_simply' for #<Lawyer:0x000055bfc08b00a8> (NoMethodError)

#Have you ever wondered where that "undefined method" error comes from? It's simply a method!
#Ruby tries to search for #speak_simply but doesn't find it in the Lawyer class. It goes up the chain.
#Doesn't find it anywhere. Finally, it reaches the BasicObject which has #method_missing. It calls it and you get error.
#It's a private method but using send, you can access it yourself!

# nick.send(:method_missing, :speak_simply)    #undefined method `speak_simply' for #<Lawyer:0x00005556fb223fb0>

#This is the job of method_missing. Like lost mail at the post office.


#I got lost in the remaining chapter...really went off to the deep end. I won't continue with method_missing.


#The summary of all of this from the author. He recommends to use DYNAMIC METHODS when you can and ONLY use
#method_missing / ghost methods if you HAVE TO.
# ON Chapter 3 - Wednesday - Blocks (REDO THe dynamic method with an actual example)