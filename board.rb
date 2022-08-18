# frozen_string_literal: true

# Mastermind board
class Board
  attr_accessor :code, :solution, :board

  def initialize
    @code = %w[1 2 3 4 5 6]
    @solution = []
    @board = []
  end

  def win?(turn)
    board[turn - 1][0] == solution
  end

  def update_board(move, hint, turn)
    board << []
    board[turn - 1] << move
    board[turn - 1] << hint
  end

  def print_board
    puts "Current state of board"
    board.each do |element|
      element.each_with_index do |ele, index|
        ele.each { |e| print "#{e}  " }
        print '---------  ' if index < 1
      end
      puts
    end
  end

  def update_and_print_board(input, hint_arr, turn)
    update_board(input, hint_arr, turn)
    print_board
  end
end
