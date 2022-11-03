class Plateau
  def initialize(x:, y:)
    @x = x
    @y = y
    @obstacles = {}
  end

  def can_move?(position)
    current_x = position[:x]
    current_y = position[:y]
    direction = position[:direction]

    if direction == 'N'
      current_y < y && unobstructed?(current_x, current_y + 1)
    elsif direction == 'S'
      current_y > 0 && unobstructed?(current_x, current_y - 1)
    elsif direction == 'E'
      current_x < x && unobstructed?(current_x + 1, current_y)
    elsif direction == 'W'
      current_x > 0 && unobstructed?(current_x - 1, current_y)
    end
  end

  def add_obstacle(position)
    current_x = position[:x]
    current_y = position[:y]

    return obstacles[current_x] = [current_y] if obstacles[current_x].nil?

    obstacles[current_x] << current_y
  end

  private

  attr_reader :x, :y
  attr_accessor :obstacles

  def unobstructed?(current_x, current_y)
    return true if obstacles[current_x].nil?

    !obstacles[current_x].include?(current_y)
  end
end
