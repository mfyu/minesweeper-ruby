class Tile
    def initialize
        @bombed = false
        @flagged = false
        @revealed = false
    end

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
        return "0" if revealed?
        return " "
    end

    def neighbors
    end
end

