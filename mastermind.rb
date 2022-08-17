require 'pry-byebug'

class Board
  attr_accessor :code, :solution, :board

  def initialize
    @code = ["1", "2", "3", "4", "5", "6"]
    @solution = []
    @board = []
  end

  def win?(board,turn)
    board[turn - 1][0] == solution
  end

  def update_board(move, hint,board,turn)
    board << []
    board[turn - 1] << move
    board[turn - 1] << hint
  end

  def print_board(board)
    board.each do |element| 
      element.each_with_index do |ele, index|
        ele.each { |e| print "#{e}  " }
        print '---------  ' if index < 1
      end
      puts
    end
  end
end

class Players
  attr_accessor :role

  def initialize(role)
    @role = role
  end
end


class Game 
  attr_accessor :board, :turn, :player, :computer

  def initialize
    @board = Board.new
    @player = nil
    @computer = nil
    @turn = 1
  end

  def other_role(role)
    if role == 'Brekaer'
      'Maker'
    else 
      'Breaker'
    end
  end


  def game_set_up
    puts "Choose: BREAKER OR MAKER"
    role = gets.chomp    
    @player = Players.new(role)
    computer_role = other_role(role)
    @computer = Players.new(computer_role)
  end

  def codemaker
    if player.role == "maker"
      puts "Input code"

      solution5 = gets.chomp
      board.solution = solution5.to_s.split("")    
    else 
      board.solution = board.code.sample(4)

    end
  end      

  def play
    game_set_up
    codemaker
    puts board.solution
    start_game
  end

  def start_game
    if player.role == "maker"
      computermethods
    else
      playermethods
    end
  end

  def playermethods
    loop do
      arr = player_input
      sol_arr = arr.dup
      hint_arr = hint(sol_arr)
      board.update_board(arr,hint_arr,board.board,turn)
      board.print_board(board.board)
      break if board.win?(board.board, turn)
      puts turn
      self.turn += 1
    end
  end

  def computermethods
    loop do
      arr = computer_input(self.turn)
      sol_arr = arr.dup
      hint_arr = hint(sol_arr)
      board.update_board(arr,hint_arr,board.board,turn)
      board.print_board(board.board)
      break if board.win?(board.board, turn)
      puts turn
      self.turn += 1
    end
  end

def perfect_match(solution, answer, hint_arr)
  solution.each_with_index do |sol_color, sol_pos|
    answer.each_with_index do |answer_color, answer_pos|
      next unless sol_color == answer_color && sol_pos == answer_pos

      solution[sol_pos] = 'o'
      answer[answer_pos] = 'x'
      hint_arr << 'red'
      break
    end
  end
end

def wrong_positon(solution, answer, hint_arr)
  solution.each_with_index do |sol_color, sol_pos|
    answer.each_with_index do |answer_color, answer_pos|
      next unless sol_color == answer_color

      hint_arr << 'white'
      solution[sol_pos] = 'o'
      answer[answer_pos] = 'x'
      break
    end
  end
end

def hint(answer)
  hint = []
  solution_2 = board.solution.dup
  perfect_match(solution_2, answer, hint)
  wrong_positon(solution_2, answer, hint)
  hint
end

  def player_input
    input = gets.chomp.split("")
    return input
  end 

  def computer_input(turn)
    (turn + 1110).to_s.split("")    
  end
end

game = Game.new
game.play