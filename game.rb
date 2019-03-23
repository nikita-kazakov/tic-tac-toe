require_relative 'player'
#require_relative 'modules'

class Game
  attr_reader :board
  def initialize
    @winner = false
    @players = [Player.new("Player1", "X"), Player.new("Player2", "O")]
    @board = Board.new
  end

  def play

    @players.each do |player|
      @board.take_turn(player)
      winner?(player, @board)
    end

  end
  
  def winner?(player,board)

    case pattern = player.piece
    when board.board[0][1] == pattern
      puts "#{player.name} has won!"
    end

  end
  
  

end

class Board
  attr_reader :board
  def initialize
    @board_top = [1,2,3]
    @board_middle = [4,5,6]
    @board_bottom = [7,8,9]
    @board = [[0,1,2], [3,4,5], [6,7,8]]
  end



  def view_board
    p @board[0]
    p @board[1]
    p @board[2]
  end

  def take_turn(player)
    puts "Player #{player.name} move:"
    option = rand(3)

    case option
    when (0..2)
      board[0][option] = player.piece
    when (3..5)
      board[1][option] = player.piece
    when (6..8)
      board[2][option] = player.piece
    end
    view_board
  end


=begin
    case option
    when 1
      @board_top[option - 1] = player.piece
    when 2
      @board_top[option - 1] = player.piece
    when 3
      @board_top[option - 1] = player.piece
    when 4
      @board_middle[option - 4] = player.piece
    when 5
      @board_middle[option - 4] = player.piece
    when 6
      @board_middle[option - 4] = player.piece
    when 7
      @board_bottom[option - 7] = player.piece
    when 8
      @board_bottom[option - 7] = player.piece
    when 9
      @board_bottom[option - 7] = player.piece
    else
      puts "Pick a slot 1 - 9"
    end
=end



end


#Sample Code
if __FILE__ == $0

  game = Game.new
  board = Board.new
  game.play





end