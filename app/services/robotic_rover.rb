class RoboticRover
  include BaseService

  attr_accessor :state

  def initialize(initial_position:, commands:, plateau:)
    @initial_position = initial_position
    @commands = commands
    @plateau = plateau
    @current_position = initial_position
  end

  def call
    commands.each do |command|
      execute(command)
    end

    current_position
  end

  private

  attr_reader :initial_position, :commands, :plateau
  attr_accessor :current_position

  def execute(command)
    if command == 'M'
      move
    elsif command == 'L'
      rotate_left
    elsif command == 'R'
      rotate_right
    end
  end

  def execute(command)
    if command == 'M'
      move
    elsif command == 'L'
      rotate_left
    elsif command == 'R'
      rotate_right
    end
  end

  def move
    if current_position[:direction] == 'N' && plateau.can_move?(current_position)
      current_position[:y] += 1 
    elsif current_position[:direction] == 'S' && plateau.can_move?(current_position)
      current_position[:y] -= 1
    elsif current_position[:direction] == 'E' && plateau.can_move?(current_position)
      current_position[:x] += 1
    elsif current_position[:direction] == 'W' && plateau.can_move?(current_position)
      current_position[:x] -= 1
    end
  end

  def rotate_left
    if current_position[:direction] == 'N'
      current_position[:direction] = 'W'
    elsif current_position[:direction] == 'S'
      current_position[:direction] = 'E'
    elsif current_position[:direction] == 'E'
      current_position[:direction] = 'N'
    elsif current_position[:direction] == 'W'
      current_position[:direction] = 'S'
    end
  end

  def rotate_right
    if current_position[:direction] == 'N'
      current_position[:direction] = 'E'
    elsif current_position[:direction] == 'S'
      current_position[:direction] = 'W'
    elsif current_position[:direction] == 'E'
      current_position[:direction] = 'S'
    elsif current_position[:direction] == 'W'
      current_position[:direction] = 'N'
    end
  end
end
