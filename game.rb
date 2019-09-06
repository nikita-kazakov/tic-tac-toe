class Player
end

player1 = Player.new
player2 = Player.new


BOARD = {
    1 => nil,
    2 => nil,
    3 => nil,
    4 => nil,
    5 => nil,
    6 => nil,
    7 => nil,
    8 => nil,
    9 => nil

}

class Game

  def initialize(players:)
    @players = players
    @winner = false

  end

  def play
    while @winner == false
      @players.each do |player|
        puts "Your turn, which numbered square?"
        square = gets.chomp.to_i
        BOARD[square] = player
        win?(player)
      end
    end

  end

  def win?(player)
    count = 0
    [1,2,3].each do |position|
      count += 1 if BOARD[position] == player
    end

    if count == 3
      puts "WINNER with a count of #{count}"
      @winner = true
      play_again?
    end

    #BOARD.values_at(1,2,3) == player
    #puts "WINNER!"
  end

  def play_again?
    @winner = false
    puts "Play again?"
    answer = gets.chomp
    play if answer == 'yes'
    abort("Thanks for Playing!") if answer == 'no'

  end

end

game = Game.new(players:[player1, player2])
p game.play
