class TestRoversController < ApplicationController
  def index; end

  def commands
    content = params[:file].read
    parsed_file = Parser.new(content).call

    if parsed_file[:errors].nil?
      @rovers = Navigate.new(parsed_file).call
    else
      @errors = parsed_file[:errors]
    end
  end

  private

  def rover_params
    params.permit(:file)
  end
end
