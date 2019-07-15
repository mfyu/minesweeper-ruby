#require_relative "board"

class Tile
    def initialize
        @bombed = false
        @flagged = false
        @revealed = false
        @adjacent_bombs = 0
    end
    attr_accessor :adjacent_bombs

    def reveal
        @revealed = true
    end

    def bomb 
        @bombed = true
    end

    def flag
        @flagged = true
    end

    def revealed?
        @revealed
    end
    def flagged?
        @flagged
    end
    def bombed?
        @bombed
    end


    def to_s
        return "F" if flagged?
        return "*" if bombed?
        
        return @adjacent_bombs.to_s if revealed? && @adjacent_bombs!=0
        return "_" if revealed?
        return "*"
    end

    def neighbors
    end
end

