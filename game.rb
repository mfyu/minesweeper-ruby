require_relative "board"
#require_relative "player"
class Game
    def initialize(size=4)
        @board = Board.new(size)
        #@player = player
        @previous_guess = nil
    end

    def make_guess(pos)
        @previous_guess = pos
        @board.reveal(pos)
        #sleep(1)
    end

    def compare_guess(pos)
        @board.reveal(pos)
        if @previous_guess
            if @board[@previous_guess].value == @board[pos].value
                @board.render
                puts "It's a match!"
            else 
                @board.render
                puts "no match"
                @board.hide(@previous_guess)
                @board.hide(pos)
            end
        end
    end

    def game_over?
        @board.won?
    end

    def play
        while !game_over?
            system("cls")
            make_guess(prompt)
            compare_guess(prompt)
            sleep(1)
            @board.render
        end
        puts "\nyou win."
        
    end

    def prompt
        @board.render
        pos = []
        puts "Please enter the position of card you want to flip (eg. 1,2)"
        position = gets.chomp
        pos<<position[0].to_i
        pos<<position[2].to_i
        
        return pos
    end

end

game = Game.new(20)
game.play