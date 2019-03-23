require_relative 'modules'

class Player
  attr_reader :name, :piece
  def initialize (name, piece)
    @name = name
    @piece = piece
    @won = nil
  end
  
  def take_turn
    
    Game.take_turn
    
  end



end

if __FILE__ == $0

  player1 = Player.new("Player1", "X")
  player2 = Player.new("Player2", "O")

  player1.take_turn

#player1.take_turn
# please enter # : 5

#player2.take_turn
# take number

#Loop until win

end