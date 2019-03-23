require_relative 'player'


BOARD_TOP = [1,2,3]
BOARD_MIDDLE = [4,5,6]
BOARD_BOTTOM = [7,8,9]
PLAYERS_LIST = []

def view_board

  p BOARD_TOP
  p BOARD_MIDDLE
  p BOARD_BOTTOM

end


module Game

  def self.take_turn
    case option = 4
    when 1
      BOARD_TOP[option - 1] = "X"
      view_board
    when 2
      BOARD_TOP[option - 1] = "X"
      view_board
    when 3
      BOARD_TOP[option - 1] = "X"
      view_board
    when 4
      BOARD_MIDDLE[option - 4] = "X"
      view_board
    when 5
      BOARD_MIDDLE[option - 4] = "X"
      view_board
    when 6
      BOARD_MIDDLE[option - 4] = "X"
      view_board
    when 7
      BOARD_BOTTOM[option - 7] = "X"
      view_board
    when 8
      BOARD_BOTTOM[option - 7] = "X"
      view_board
    when 9
      BOARD_BOTTOM[option - 7] = "X"
      view_board
    else
      puts "Pick a slot 1 - 9"
    end
  end

  def self.game_start
    PLAY
    PLAYERS_LIST.each do |player|
      Play

  end


  end


end
