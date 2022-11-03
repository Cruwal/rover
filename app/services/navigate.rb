class Navigate 
  def initialize(plateau:, rovers:)
    @plateau = Plateau.new(plateau) 
    @rovers = rovers
  end

  def call
    rovers.map do |rover|
      if rover[:errors].empty?
        end_position = RoboticRover.new(plateau: plateau, initial_position: rover[:initial_position], commands: rover[:commands]).call
        plateau.add_obstacle(end_position)

        end_position
      else
        rover[:errors]
      end
    end
  end

  private

  attr_reader :plateau, :rovers
end
