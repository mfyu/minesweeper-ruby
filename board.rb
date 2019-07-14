require_relative "tile"
class Board
    def initialize
        @grid = Array.new(9){Array.new(9){Tile.new}}
        
        
    end
    attr_accessor :grid

    def [](pos)
        row, col = pos
        self.grid[row][col]
    end

    def render
        print "  "
        (0...9).each {|i| print "#{i} "}
        puts
        (0...9).each do |i| 
            print i
            (0...9).each do |j|
                print " #{self[[i,j]]}"
            end
            puts
        end

    end
end

board = Board.new

p board.grid
board[[0,0]].flag
board[[1,1]].reveal
board[[2,1]].bomb

board.render