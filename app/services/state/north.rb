module State
  class North < Base
    def move
      position[:y] += 1 if plateau.can_move?(position)
    end

    def rotate_left(context)
      position[:direction] = 'W'

      context.state = Weast.new(position: position, plateau: plateau)
    end

    def rotate_right(context)
      position[:direction] = 'E'

      context.state = East.new(position: position, plateau: plateau)
    end
  end
end
