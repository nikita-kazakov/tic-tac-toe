require_relative 'player'
require_relative 'board'
#require_relative 'modules'

class Game
  attr_accessor :board, :players
  def initialize
    @players = [Player.new("Player1", :x), Player.new("Player2", :y)]
    @board = Board.new
    @gameover = nil
  end

  def play

    @players.each do |player|
      @board.take_turn(player)
      winner?(player, @board)
    end

  end

  def take_turn

    board.board_array

    loop do

      players.each do |player|
        puts "Player #{player.name} move:"
        option = rand(0..8)
        case option
        when (0..2)
          board.board_array[0][option] = player.piece
        when (3..5)
          board.board_array[1][option - 3] = player.piece
        when (6..8)
          board.board_array[2][option - 6] = player.piece
        end
        board.view_board
        break if winner?(player,board)
      end

      break if @gameover


    end

  end
  
  def winner?(player,board)
    board_array = board.board_array
    case pattern = player.piece

    when (board_array[0][0] && board_array[0][1] && board_array[0][2]) == player.piece
      player.won = true
      @gameover = true
      puts "#{player.name} has won the game!"
    else

    end

  end
  
  

end


#Sample Code
if __FILE__ == $0


#array = [:x,:x,:y]
 # if (array[0] && array[1] && array[2]) == :x
    puts "you have x"
#  end
#  puts "over"
#
  game = Game.new
  game.take_turn




end