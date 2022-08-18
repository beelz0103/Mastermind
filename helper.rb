# frozen_string_literal: true

# Helper module for returning hint
module Helper
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

  def hint(answer, solution)
    hint = []
    perfect_match(solution, answer, hint)
    wrong_positon(solution, answer, hint)
    hint
  end

  def create_list
    list = []
    set = %w[1 2 3 4 5 6]
    set.repeated_permutation(4) { |combination| list << combination }
    list
  end

  def return_role
    role = gets.chomp.to_i
    case role
    when 1
      'Maker'
    when 2
      'Breaker'
    else
      puts 'Incorrect input, choose between 1 or 2'
      return_role
    end
  end
end
