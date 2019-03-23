require_relative 'modules'

class Player

  def initialize (name)
    @name = name
  end


  def take_turn
    puts "Enter a position"
    Game.take_turn
  end



end

if __FILE__ == $0

  player1 = Player.new("Player1")
  player2 = Player.new("Player2")

  player1.take_turn

#player1.take_turn
# please enter # : 5

#player2.take_turn
# take number

#Loop until win

end