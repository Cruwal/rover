class Navigate 
  def initialize(plateau:, rover:, commands:)
    @plateau = plateau
    @rover = rover
    @commands = commands
  end

  def call
    commands.each do |command|
      execute(command)
    end

    [rover[:x], rover[:y], rover[:direction]]
  end

  private

  attr_reader :plateau, :rover, :commands

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
    if rover[:direction] == 'N' && rover[:y] < plateau[:y]
      rover[:y] += 1 
    elsif rover[:direction] == 'S' && rover[:y] > 0
      rover[:y] -= 1
    elsif rover[:direction] == 'E' && rover[:y] < plateau[:x]
      rover[:x] += 1
    elsif rover[:direction] == 'W' && rover[:x] > 0
      rover[:x] -= 1
    end
  end

  def rotate_left
    if rover[:direction] == 'N'
      rover[:direction] = 'W'
    elsif rover[:direction] == 'S'
      rover[:direction] = 'E'
    elsif rover[:direction] == 'E'
      rover[:direction] = 'N'
    elsif rover[:direction] == 'W'
      rover[:direction] = 'S'
    end
  end

  def rotate_right
    if rover[:direction] == 'N'
      rover[:direction] = 'E'
    elsif rover[:direction] == 'S'
      rover[:direction] = 'W'
    elsif rover[:direction] == 'E'
      rover[:direction] = 'S'
    elsif rover[:direction] == 'W'
      rover[:direction] = 'N'
    end
  end
end
