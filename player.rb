require_relative 'modules'

class Player
  attr_accessor :name, :piece, :won
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

  player1 = Player.new("Player1", "x")
  player2 = Player.new("Player2", "y")
  player1.take_turn

end