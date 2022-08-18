require_relative 'helper'

# frozen_string_literal: true

# Game class
class Game
  include Helper
  attr_accessor :board, :turn, :player, :computer

  def initialize
    @board = Board.new
    @player = nil
    @computer = nil
    @turn = 1
  end

  def game_set_up
    create_player
    create_computer(player.role)
    create_code
    puts '-----start-----'
  end

  def create_player
    puts 'Input 1 if you want to be the codemaker and 2 if you want to be the codebreaker'
    @player = HumanPlayer.new(return_role)
    print_role(player.role)
  end

  def create_computer(player_role)
    computer_role = ComputerPlayer.other_role(player_role)
    @computer = ComputerPlayer.new(computer_role)
  end

  def create_code
    @board.solution = Player.codemaker(player, board)
  end

  def print_role(role)
    case role
    when 'Maker'
      puts 'You chose to be the codemaker'
    when 'Breaker'
      puts 'You chose to be the codebreaker'
    end
  end

  def play_game
    game_set_up
    play
  end

  def play
    solution = board.solution
    if player.role == 'Breaker'
      playerstuff(solution)
    else
      computerstuff(solution)
    end
  end

  def playerstuff(solution)
    while turn < 13
      print_turn
      input = HumanPlayer.code_input(board)
      hint_arr = player.get_hint(solution, input)
      board.update_and_print_board(input, hint_arr, turn)
      break if board.win?(turn)

      self.turn += 1
    end
  end

  def computerstuff(solution)
    list = create_list
    while turn < 13
      print_turn
      input = auto_input(list)
      hint_arr = player.get_hint(solution, input)
      board.update_and_print_board(input, hint_arr, turn)
      break if board.win?(turn)

      list = computer.swaszek_algo(input, hint_arr, list)
      self.turn += 1
    end
  end

  def print_turn
    puts "Turn no. #{turn}"
  end

  def auto_input(list)
    if turn == 1
      %w[1 1 2 2]
    else
      list.sample
    end
  end

  # THIS DOESNT WORK AS EXPECTED
  def conclusion
    if board.win?(turn - 1)
      puts 'WON'
    else
      puts 'YOU WERENT ABLE TO GUEES'
    end
  end
end
