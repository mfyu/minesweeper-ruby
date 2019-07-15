require_relative "tile"
require "byebug"
class Board
    def initialize(num_bombs=2)
        @grid = Array.new(9){Array.new(9){Tile.new}}
        place_bombs(num_bombs)
        
        
    end
    attr_accessor :grid

    def neighbors(pos)
        neighbors = []
        row, col = pos
        neighbors<<[row-1,col-1] if row != 0 && col != 0
        neighbors<<[row-1,col] if row != 0
        neighbors<<[row-1,col+1] if row != 0 && col != 8
        neighbors<<[row,col-1] if col != 0
        neighbors<<[row,col+1] if col != 8
        neighbors<<[row+1,col-1] if col != 0 && row != 8
        neighbors<<[row+1,col] if row != 8
        neighbors<<[row+1,col+1] if row != 8 && col != 8
        return neighbors
    end

    
 

    def place_bombs(num=2)
        a = (0..8).to_a.shuffle
        b = (0..8).to_a.shuffle
        (num).times do
            row = a.pop
            col = b.pop
            self[[row, col]].bomb
            neighbors([row,col]).each do |pos|
                self[pos].adjacent_bombs += 1
            end
        end
    
    end



    def [](pos)
        row, col = pos
        self.grid[row][col]
    end

    def render
        system("clear")
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

    def update_neighbors(pos)
        return nil if neighbors(pos).all? {|tile| self[tile].revealed?}
        neighbors(pos).each do |tile|
            tiles = []
            if !self[tile].bombed? && !self[tile].revealed?
                self[tile].reveal
                tiles<<tile
            end
            tiles.each do |t|
                update_neighbors(t) if neighbors(t).all? {|t| !self[t].bombed?}
            end
        end
    end



    


    def turn(pos, flag)
        flag ||= false
        self[pos].flag if flag=="f"
        self[pos].reveal if !self[pos].flagged?
        return nil if self[pos].adjacent_bombs != 0

        update_neighbors(pos) if !self[pos].flagged?
        
    end

    def lose
        @grid.flatten.any? {|tile| tile.bombed?&&tile.revealed?} 
    end

    def win
        @grid.flatten.all? {|tile| tile.revealed? || tile.bombed?}
    end

    def game
        while true
            
            
           
            render
            puts "Enter a square like 1,2. Add ' f' to flag"
            print ">"
            input = gets.chomp
            turn([input[0].to_i,input[2].to_i], input[4])
            if lose
                render
                puts "BOOM! You hit a mine."
                break
            end
            if win
                render
                puts "You win."
                break
            end
        end
    end

end

board = Board.new(9)


board.game



