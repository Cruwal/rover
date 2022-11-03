class RoboticRover
  include BaseService

  attr_accessor :state

  def initialize(initial_position:, commands:, plateau:)
    @initial_position = initial_position
    @commands = commands
    @plateau = plateau
    @current_position = initial_position
    @state = state_factory
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
      state.move
    elsif command == 'L'
      state.rotate_left(self)
    elsif command == 'R'
      state.rotate_right(self)
    end
  end

  def state_factory
    return State::North.new(position: initial_position, plateau: plateau) if current_position[:direction] == 'N'
    return State::South.new(position: initial_position, plateau: plateau) if current_position[:direction] == 'S'
    return State::Weast.new(position: initial_position, plateau: plateau) if current_position[:direction] == 'W'
    State::East.new(position: initial_position, plateau: plateau) if current_position[:direction] == 'E'
  end
end
