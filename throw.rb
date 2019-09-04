class Game
  attr_accessor :cells; :end_game
  def initialize
    @cells = [" "," "," "," "," "," "," "," "," "]
    @player_1 = Player.new("Player 1", 'X')
    @player_2 = Player.new("Player 2", 'O')
    @current_player = @player_1
    @end_game = false
  end
  def draw_board
    puts "\nBoard:"
    puts "\n #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    puts "\n"
  end
  def draw_legend
    puts "Legend: "
    puts "1|2|3"
    puts "4|5|6"
    puts "7|8|9"
    puts "\n"
  end
  def switch_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end
  def player_input
    puts "Your turn, #{@current_player.name}. Pick a cell by typing a number between 1 and 9."
    input = gets.chomp.to_i
    until input.between?(1, 9)
      puts "You need to type a number between 1 and 9."
      input  = gets.chomp.to_i
    end
    input - 1
  end
  def player_move
    move = player_input
    until @cells[move] == " "
      puts "This cell has already been taken."
      move = player_input
    end
    @cells[move] = @current_player.symbol
    @current_player.taken_cells << move
  end
  def check_end_game
    conditions = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    conditions.each do |condition|
      if (condition - @current_player.taken_cells).empty?
        puts "#{@current_player.name} wins!"
        @end_game = true
      end
    end
    if @player_1.taken_cells.size + @player_2.taken_cells.size >= 9
      puts "It's a draw."
      @end_game = true
    end
    @end_game
  end
end

class Player
  attr_accessor :symbol, :taken_cells, :name
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @taken_cells = []
  end
end

game = Game.new
puts "TIC-TAC-TOE"
game.draw_board
until game.check_end_game
  game.draw_legend
  game.player_move
  game.draw_board
  game.check_end_game
  game.switch_player
end