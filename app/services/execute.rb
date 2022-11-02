class Execute
  def initialize(plateau:, rovers:)
    @plateau = plateau
    @rovers = rovers
  end

  def call
    rovers.map do |rover|
      if rover[:errors].empty?
        Navigate.new(plateau: plateau, rover: rover[:initial_position], commands: rover[:commands]).call
      else
        rover[:errors]
      end
    end
  end

  private

  attr_reader :plateau, :rovers
  
end
