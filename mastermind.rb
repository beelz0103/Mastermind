class Board
  attr_accessor :code, :solution, :board

  def initialize
    @code = ["1", "2", "3", "4"]
    @solution = []
    @board = []
  end

  def codemaker(code)
    @solution = code.sample(4)
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
      hint_arr = []
      hint(arr,hint_arr)
      board.update_board(arr,hint_arr,board.board,turn)
      board.print_board(board.board)
      break if board.win?(board.board, turn)
      puts turn
      self.turn += 1
    end
  end

  def hint(arr, arr2)
    board.solution.each_with_index do |element, index|
      arr.each_with_index do |e,i|
        if element == e && index == i
          arr2 << "black"
        elsif element == e
          arr2 << "white"
        end
      end
    end
  end

  def player_input
    input = gets.chomp.split("")
    return input
  end 
end

game = Game.new
game.play
