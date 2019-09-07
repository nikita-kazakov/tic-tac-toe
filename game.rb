class Player
  attr_reader :name, :figure
  attr_accessor :wins

  def initialize(name, figure)
    @name = name
    @figure = figure
    @wins = 0
  end

end



player1 = Player.new("Jack", "X")
player2 = Player.new("Sue", "O")




class Game

  def initialize(players:)
    @players = players
    @winner = false
    @board = Board.new

  end

  def play
    while @winner == false
      @players.each do |player|
        @board.display
        puts "#{player.name}, which numbered square (1-9)?"
        position = gets.chomp.to_i
        #BOARD[position] = player
        @board.validate(position)
        @board.draw(position, player)


        win?(player)
      end
    end

  end

  def win?(player)
    count = 0
    [1,2,3].each do |position|
      count += 1 if @board.board[position] == player.figure
    end

    if count == 3
      puts "WINNER with a count of #{count}"
      @winner = true
      player.wins
      play_again?
    end

    #BOARD.values_at(1,2,3) == player
    #puts "WINNER!"
  end

  def play_again?
    @winner = false
    puts "Play again? (yes/no)"
    answer = gets.chomp


    if answer == 'yes'
      @board.clear
      play
    end

    abort("Thanks for Playing!") if answer == 'no'
  end

end


class Board
  attr_reader :board
  def initialize

    @board = {
        1 => 1,
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 5,
        6 => 6,
        7 => 7,
        8 => 8,
        9 => 9
    }

  end


  def clear
    @board = {
        1 => 1,
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 5,
        6 => 6,
        7 => 7,
        8 => 8,
        9 => 9
    }
  end

  def validate(position)

  end

  def draw(position, player)

    @board[position] = player.figure
    display

  end

  def display
    divider = "-------"
    puts divider
    puts "|#{@board[1]}|#{@board[2]}|#{@board[3]}|"
    puts divider
    puts "|#{@board[4]}|#{@board[5]}|#{@board[6]}|"
    puts divider
    puts "|#{@board[7]}|#{@board[8]}|#{@board[9]}|"
    puts divider
  end


end


Board.new
game = Game.new(players:[player1, player2])
p game.play