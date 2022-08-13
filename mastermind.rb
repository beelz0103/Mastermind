require 'pry-byebug'

class Board
  attr_accessor :code, :solution, :board

  def initialize
    @code = ["1", "2", "3", "4", "5", "6"]
    @solution = []
    @board = []
  end

  def codemaker(code)
    @solution = code.sample(4)
    @solution = ["1", "1", "2", "2"]
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

class Game 
  attr_accessor :board, :turn

  def initialize
    @board = Board.new
    @turn = 1
  end

  def play
    board.codemaker(board.code)
    puts board.solution
    start_game
  end

  def start_game
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
end

game = Game.new
game.play