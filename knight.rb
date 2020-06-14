class Node
    attr_accessor :pos, :parent, :children

    def initialize(value = nil, parent = nil)
        @pos = value
        @parent = parent
        @children = []
    end
end

#I tried doing this with a board, but dropped it for some reason, this may be helpful in the future, so keeping it here

# class Board
#     attr_accessor :positions

#     def initialize
#         @positions = Array.new(8) {Array.new(8, '.')}
#         @pieces = { knight: 'k'}
#     end

#     def to_s
#         @positions.each do |i|
#             print '|'
#             i.each {|q| print "#{q}|"}
#             puts
#         end
#     end

#     def add_piece(piece)
#         if piece == :knight
#             pos = []
#             puts 'Input coordinates'
#             pos[0] = gets.chomp.to_i
#             pos[1] = gets.chomp.to_i
#             @knight = Knight.new(pos)
#             @positions[@knight.pos[0]][@knight.pos[1]] = @pieces[:knight]
#         end
#     end
# end

class Knight
    attr_accessor :pos
    MOVES = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]].freeze

    def initialize(pos = [3,3])
        @pos = pos
    end

    def is_valid?(end_pos)
        if end_pos[0] < 0 || end_pos[0] > 7 || end_pos[1] < 0 || end_pos[1] > 7
            return false
        end
        true
    end

    def possible_moves(position)
        arr = []
        MOVES.each do |move|
            end_pos = [move[0] + position[0], move[1] + position[1]]
            if is_valid? end_pos
                arr << end_pos
            end
        end
        arr
    end

    def knight_moves(target, start = @pos)
        raise StandardError.new('burh') unless is_valid? target
        root = Node.new(start)
        p root
        target_acquired = nil
        queue = [root]
        return queue if root.pos == target

        until queue.empty? || target_acquired
            current = queue[0]
            moves = possible_moves current.pos
            moves.each do |move|
                new_node = Node.new move, current
                current.children << new_node
                queue << new_node
                target_acquired = new_node if new_node.pos == target
                puts "Let's goooo" if new_node.pos == target
            end
            queue.shift
        end

        current = target_acquired
        path = [current]
        while current.parent
            path << current.parent
            current = current.parent
        end

        return path.reverse!
    end

    def print_path(array)
        puts "you can get there in #{array.length - 1} moves"
        puts 'In this order'
        array.each {|pos| puts pos.pos.to_s}
    end
end


knight = Knight.new
arr = knight.knight_moves([2,5])
knight.print_path(arr)