class Board
  
  attr_accessor :board_array
  def initialize
    #@board_top = [1,2,3]
    #@board_middle = [4,5,6]
    #@board_bottom = [7,8,9]
    @board_array = [[1, 2, 3], [3, 4, 5], [6, 7, 8]]
  end

  
  def view_board
    p @board_array[0]
    p @board_array[1]
    p @board_array[2]
  end

  def take_turn(player)
    puts "Player #{player.name} move:"
    option = rand(3)

    case option
    when (0..2)
      board_array[0][option] = player.piece
    when (3..5)
      board_array[1][option] = player.piece
    when (6..8)
      board_array[2][option] = player.piece
    end
    view_board
  end
end