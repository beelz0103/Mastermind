# frozen_string_literal: true

require_relative 'helper'

# Players class
class Player
  include Helper
  attr_accessor :role

  def initialize(role)
    @role = role
  end

  def self.codemaker(player_class, board)
    if player_class.role == 'Maker'
      puts 'Input code, combination of numbers between 1 to 6 seperated by space'
      code_input(board)
    else
      board.code.sample(4)
    end
  end

  def self.code_input(board)
    input = gets.chomp.split(' ')
    if compare(input, board.code) && input.length == 4
      input
    else
      puts 'Wrong input, please input again'
      code_input(board)
    end
  end

  def self.compare(checked_array, standard)
    (checked_array - standard).empty?
  end

  def get_hint(solution, answer)
    temp_answer = answer.dup
    temp_sol = solution.dup
    hint(temp_answer, temp_sol)
  end
end

# Class for humanplayer
class HumanPlayer < Player
end

# Class for computerplayer
class ComputerPlayer < Player
  def self.other_role(role)
    if role == 'Breaker'
      'Maker'
    else
      'Breaker'
    end
  end

  def swaszek_algo(psudeo_soln, hint, list)
    new_list = []
    list.each do |possible_answer|
      possible_answer_temp = possible_answer.dup
      psudeo_soln_temp = psudeo_soln.dup
      new_list << possible_answer if hint == hint(psudeo_soln_temp, possible_answer_temp)
    end
    new_list
  end
end
