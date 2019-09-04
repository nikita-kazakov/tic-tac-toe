class Game

  attr_accessor :horses, :track_length, :motivator1, :motivator2
  #TODO: 
  #Don't allow a 3 way tie: maybe combine last speed with endurance and top speed?
  #Colorize commentary?

  # Shelby agrees that this game **could** make use of the class variable, which would allow me to puts the avail_names array in the horse class. Its rarely appropriate to use class variables, but this would be a good example of when to do so.

  #https://code.google.com/p/shellinabox/    This may allow terminal window on a webpage!

  def initialize
    system 'clear'
    @@midpoint_comment_given = false
    @avail_names = ["Seabiscuit", "Secretariat", "Seattle Slew", "Affirmed", "Northern Dancer", "Kincsem", "Black Caviar", "Native Dancer", "Man o'War", "Citation", "Assault", "Count Fleet", "Whirlaway", "War Admiral", "Omaha", "Gallant Fox", "Sir Barton"].shuffle
    @horse1 = Horse.new("1")
    @horse2 = Horse.new("2")
    @horse3 = Horse.new("3")
    @horses = [@horse1, @horse2, @horse3]
    assign_random_names()
    welcome
    display_track
    start_race
    race
    determine_winner
    # for testing only....
    # puts "Horse1: #{@horse1.name}: endurance = #{@horse1.endurance}, top_speed #{@horse1.top_speed}, acceleration = #{@horse1.acceleration}"
    # puts "Horse2: #{@horse2.name}: endurance = #{@horse2.endurance}, top_speed #{@horse2.top_speed}, acceleration = #{@horse2.acceleration}"
    # puts "Horse3: #{@horse3.name}: endurance = #{@horse3.endurance}, top_speed #{@horse3.top_speed}, acceleration = #{@horse3.acceleration}"
  end

  def assign_random_names
    @horse1.name = @avail_names.pop
    @horse2.name = @avail_names.pop
    @horse3.name = @avail_names.pop
  end

  def welcome
    puts ""
    puts "========================================"
    puts "### Welcome to the Del Mar RaceTrack ###"
    puts "###  Where the turf meets the surf! ###"
    puts "========================================"
    puts ""
    puts ""
    puts "Once the race begins, try the following commands to motivate your horse."
    puts '["whip", "carrot", "yah", "hay", "sugar", "kick", "apple"]'
    puts ""
    puts "You're riding #{@horse2.name}, in the #2 position."
    #puts "Your horse's motivators include #{@horse2.motivator1}, and #{@horse2.motivator2}"
    sleep(4)
  end

  def display_track
    @track_length = 50
    @@halfway = @track_length / 2
    puts "=" * @track_length
    puts ("." * @horse1.distance) + @horse1.symbol + (" " * (@track_length + 7 - @horse1.distance)) + @horse1.name
    puts ("." * @horse2.distance) + @horse2.symbol + (" " * (@track_length + 7 - @horse2.distance)) + @horse2.name
    puts ("." * @horse3.distance) + @horse3.symbol + (" " * (@track_length + 7 - @horse3.distance)) + @horse3.name
    puts "=" * @track_length
  end

  def start_race
    puts "The horses are at the gate:"
    sleep(3)
    puts "And they're off!!!"
  end

  def race
    #until one crosses the finish line, keep running race methods
    until @horse1.distance >= @track_length || @horse2.distance >= @track_length || @horse3.distance >= @track_length
      @horse2.get_user_input
      @horse1.move_horse
      @horse2.move_horse
      @horse3.move_horse
      display_track
      determine_leader
      race_commentary
    end
  end

  def determine_leader
    @positions = []
    @horses.each do |horse|
      @positions << horse
      @positions.sort! { |a, b|; b.distance <=> a.distance }
    end
    @leader = @positions[0].name
  end

  def race_commentary
    # if @motivated == 1
    #   @horse_responses = ["#{@name} is responding well to his rider!", "#{@name} and jockey look like they understand each other perfectly.", "#{@name} is giving it everything its got!", "#{@name} is really in sync with his jockey!" ]
    #   puts @horse_responses.sample
    # end
    gap1 = @positions[0].distance - @positions[1].distance
    gap2 = @positions[0].distance - @positions[2].distance
    # for testing only....
    # puts "#{@positions[0].distance} = @positions[0]"
    # puts "#{gap1} = gap1"

    #when @leader is at certain areas on the track...
    case @positions[0].distance
    when 12...17
      if gap1 > 0
        puts "It's #{@leader} with an early lead by #{gap1} lengths"
      elsif gap2 == 0
        puts "The horses are running neck-and-neck!"
      else puts "#{@leader} and #{@positions[1].name} are battling for the early lead."
      end
    when @@halfway .. (@@halfway + 5)
      if @@midpoint_comment_given == true
        puts ""
      else
        if gap1 == 0 && gap2 == 0
          puts "At the halfway mark it's too close to call - they're running shoulder-to-shoulder!"
        elsif gap1 == 0
          puts "At the midpoint, it's #{@positions[0].name} and #{@positions[1].name} neck-and-neck for the lead!"
        else
          puts "Halfway to the finish, its #{@leader} ahead by #{gap1} lengths! #{@positions[2].name} is #{gap2} lengths off the lead."
        end
        @@midpoint_comment_given = true
      end
    when 43..49
      if gap1 > 0
        puts "It's #{@leader} charging toward the finish line, with #{@positions[1].name} #{gap1} lengths behind!"
      else
        puts "#{@leader} and #{@positions[1].name} are in a dead-heat nearing the finish line!"
      end
    end
  end


  def determine_winner
    puts "And the winner is..."
    #determine which horses crossed the finish line
    finishers = []
    @horses.each do |horse|
      if horse.distance > @track_length
        finishers << horse
      end
    end
    # if only one finisher
    if finishers.length == 1
      @winner = finishers[0].name
      puts "#{@winner}!"
      # if 2 finishers, which went farthest?
    elsif finishers.length == 2
      puts "It's a photo-finish! The judges will review this..."
      sleep(4)
      finishers.sort {|a, b| a.distance <=> b.distance }
      if finishers[0].distance == finishers[1].distance
        if finishers[0].endurance > finishers[1].endurance
          @winner = finishers[0].name
        else
          @winner = finishers[1].name
        end
      else
        @winner = finishers[0].name
      end
      puts "It's " + "#{@winner}" + " by a neck!"
    else  #all 3 horses crossed finish line
      finishers.sort {|a, b| a.distance <=> b.distance }
      if finishers[0].distance == finishers[1].distance && finishers[1].distance == finishers[2].distance
        puts "It's a three-way tie! These horses will surely need to race again to settle this!"
      end
    end
  end
end



class Horse
  attr_reader :acceleration, :top_speed, :endurance, :motivated, :speed, :distance, :symbol, :motivator1, :motivator2
  attr_accessor :name

  def initialize(sym)
    @name = ""
    @acceleration = rand(1..2)
    @top_speed = rand(4..5)
    @endurance = rand(34..44)
    @motivated = 0
    @speed = 0
    @distance = 0
    @symbol = sym
    @motivator1 = generate_horse_motivator
    @motivator2 = generate_horse_motivator
  end

  def generate_horse_motivator
    motivators = ["whip", "carrot", "yah", "hay", "sugar", "kick", "apple"]
    @motivator1 = motivators.sample
    target = motivators.index(@motivator1)
    #remove 1st motivator so 2nd will be unique
    motivators.delete_at(target)
    @motivator2 = motivators.sample
  end

  def get_user_input
    puts ""
    puts "Encourage your horse:['whip', 'carrot', 'yah', 'hay', 'sugar', 'kick', 'apple']?"
    @attempted_motive = gets.chomp.downcase
    if @attempted_motive == @motivator1 || @attempted_motive == @motivator2
      @motivated = 1
      @horse_responses = ["#{@name} is responding well to his rider!", "#{@name} and jockey look like they understand each other perfectly.", "#{@name} is giving it everything its got!", "#{@name} is really in sync with his jockey!" ]
      puts @horse_responses.sample
    else
      @motivated = 0
    end
  end

  def move_horse
    @speed += (@motivated + @acceleration)
    if @speed > @top_speed
      @speed = @top_speed
    end

    bonus_move = rand(1..9)
    if bonus_move == 9 && distance == 0
      puts "#{@name} explodes out of the gate!"
      @speed += 2
    elsif bonus_move == 9 && distance > 1
      if @horse1
        puts "And #{@name} is making a move on the inside rail!"
      elsif @horse3
        puts "#{@name} surges forward on the outside."
      end
      @speed += 2
    elsif bonus_move == 8 && distance >= 40
      puts "#{@name} is making a dramatic charge toward the finish line!"
      @speed += 2
    end

    @distance_prelim = (@distance + @speed)
    if @distance_prelim > @endurance
      @speed -= 1
      #To ensure motivation gives a bonus, it must exceed top_speed. But this is too powerful if its allowed all the time. Consider only allowing motivation when horse is beyond its endurance (remove it from normal speed calc)!
      @speed += @motivated
      @distance += @speed
    else
      @distance += @speed
    end
  end
end

Game.new