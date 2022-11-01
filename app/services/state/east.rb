module State
  class East < Base
    def move
      position[:x] += 1 if plateau.can_move?(position)
    end

    def rotate_left(context)
      position[:direction] = 'N'

      context.state = North.new(position: position, plateau: plateau)
    end

    def rotate_right(context)
      position[:direction] = 'S'

      context.state = South.new(position: position, plateau: plateau)
    end
  end
end
