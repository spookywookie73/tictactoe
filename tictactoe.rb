module TicTacToe
  # create a constant array with the winning combinations
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  class Game

    attr_reader :board, :current_player_id, :available_positions

    def initialize
      @board = %w[1 2 3 4 5 6 7 8 9]
      @current_player_id = 0
      @players = [Player.new(self, "X", "Player1"), Player.new(self, "O", "Player2")]
      @available_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
    # loop through the game, checking if there is a winner or if it's a draw.
    # if it isn't then change player
    def play
      puts "Player1 goes first."
      loop do
        place_marker(current_player)

        if game_won(current_player)
          display_board
          puts "You win!"
          return
        elsif available_positions.empty?
          puts "It's a draw."
          display_board
          return
        end
        switch_players
      end 
    end
    # loop throgh the winning combinations to see if any have been filled
    # by a players marker
    def game_won(player)
      WINNING_LINES.any? do |line|
        line.all? { |position| @board[position - 1] == player.marker}
      end
    end

    def current_player
      @players[current_player_id]
    end

    def other_player_id
      1 - @current_player_id
    end

    def switch_players
      @current_player_id = other_player_id
    end
    # show the board, store the player's selection, update the available
    # positions then replace the selected position with the player's marker
    def place_marker(current_player)
      display_board
      position = current_player.select_position
      update_positions(position)
      @board[position - 1] = current_player.marker
    end

    def display_board
      puts "\n#{board[0]} | #{board[1]} | #{board[2]}"
      puts "---------"
      puts "#{board[3]} | #{board[4]} | #{board[5]}"
      puts "---------"
      puts "#{board[6]} | #{board[7]} | #{board[8]} \n\n"
    end

    def update_positions(pos)
      @available_positions.delete(pos)
    end
  end


  class Player

  attr_reader :marker, :name

    def initialize(game, marker, name)
      @game = game
      @marker = marker
      @name = name
    end
    # store the player's selection, if the position is available then mark
    # that position. if it's not available then display a message to choose again
    def select_position
      loop do
        puts "#{name} choose a position: "
        selection = gets.to_i
        return selection if @game.available_positions.include?(selection)
        puts "That position is not available. Please choose again."
        end
      end
    end
  end


include TicTacToe

new_game = Game.new
new_game.play