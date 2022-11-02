class Parser
  VALID_DIRECTIONS = ['N', 'S', 'E', 'W'].freeze
  VALID_COMMANDS = ['L', 'R', 'M'].freeze

  def initialize(content)
    @content = content
    @errors = []
    @plateau = {}
    @parsed_objects = []
  end

  def call
    validate

    return { errors: errors } unless errors.empty?

    parse_rovers
    { plateau: plateau, rovers: parsed_objects }
  end

  private

  attr_reader :content
  attr_accessor :errors, :plateau, :parsed_objects

  def validate
    return errors << "File isn't provided" if content.nil?

    return errors << "File is empty" if content.empty?

    errors << "Invalid plateau" unless valid_plateau?
  end

  def parse_rovers
    content_splitted[1..-1].each_slice(2) do |rover_params, command_params|
      errors = []

      if valid_rover?(rover_params)
        rover_params = rover_params.split(' ')
        rover = { x: rover_params[0].to_i, y: rover_params[1].to_i, direction: rover_params[2] }
      else
        errors << "Invalid rover"
        rover = {}
      end

      if valid_commands?(command_params)
        commands = command_params.split('')
      else
        errors << "Invalid command"
        commands = []
      end

      parsed_objects << { initial_position: rover, commands: commands, errors: errors }
    end
  end

  def valid_plateau?
    provided_plateau = content_splitted.first

    plateau_parameters = provided_plateau.split(' ')
    return false if plateau_parameters.count != 2

    return false if !digit?(plateau_parameters.first) || !digit?(plateau_parameters.last)

    # TODO: remover daqui
    plateau[:x] = plateau_parameters.first.to_i
    plateau[:y] = plateau_parameters.last.to_i

    true
  end

  def valid_rover?(rover_parameters)
    rover_parameters = rover_parameters.split(' ')

    return false if rover_parameters.count != 3

    x_coordinate = rover_parameters.first
    y_coordinate = rover_parameters[1]
    direction = rover_parameters.last

    return false if !digit?(x_coordinate) || !digit?(y_coordinate) || !VALID_DIRECTIONS.include?(direction)

    return false if x_coordinate.to_i > plateau[:x] || y_coordinate.to_i > plateau[:y]

    true
  end

  def valid_commands?(commands_parameters)
    result = commands_parameters =~ /\A[#{VALID_COMMANDS}]+\z/

    return false if result.nil?

    true
  end

  def digit?(string)
    string =~ /[0-9]/ && string.size == 1
  end

  def content_splitted
    @content_splitted ||= content.split("\n")
  end
end
