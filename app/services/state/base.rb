module State
  class Base
    def initialize(position:, plateau:)
      @position = position
      @plateau = plateau
    end

    def move
      raise "should implement"
    end

    def rotate_left
      raise "should implement"
    end

    def rotate_right
      raise "should implement"
    end

    private

    def transition_to(state)
    end

    attr_reader :position, :plateau
  end
end
