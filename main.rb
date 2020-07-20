require_relative 'player'
require_relative 'question'
require 'colorize'

@repl_bool = true
@turn = 0

puts 'Welcome to my Ruby math-game'
puts

print 'Player 1 name: '
@username = gets.chomp.to_s
p1 = Player.new(@username)
p1.name = p1.name.colorize(:magenta)

print 'Player 2 name: '
@username = gets.chomp.to_s
p2 = Player.new(@username)
p2.name = p2.name.colorize(:magenta)

puts
puts 'Begin game!'
puts

while @repl_bool

  question = Question.new

  case @turn
  when 0
    print "#{p1.name}, "
  else
    print "#{p2.name}, "
  end
  
  print question.to_string
  @user_input = gets.chomp.to_i

  if @turn == 0 && question.is_correct?(@user_input)
    puts "Correct!".colorize(:green)
    p1.gain_point
    @turn += 1
  elsif @turn == 0 && !question.is_correct?(@user_input)
    puts "Wrong!".colorize(:red)
    p1.lose_life
    @turn += 1
  elsif @turn == 1 && question.is_correct?(@user_input)
    puts "Correct!".colorize(:green)
    p2.gain_point
    @turn -=1
  elsif @turn == 1 && !question.is_correct?(@user_input)
    puts "Wrong!".colorize(:red)
    p2.lose_life
    @turn -=1
  end

  puts
  puts "Score:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} LIVES REMAINING
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} LIVES REMAINING"
  puts

  if p1.lives < 1 || p2.lives < 1
    puts "Game OVER!"
    if p1.lives < 1
      puts "The winner is #{p2.name}"
    elsif p2.lives < 1
      puts "The winner is #{p1.name}"
    end

  puts "Final score is:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} LIVES REMAINING
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} LIVES REMAINING"

  @repl_bool = false
  end
end
