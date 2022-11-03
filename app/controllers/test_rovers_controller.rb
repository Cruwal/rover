class TestRoversController < ApplicationController
  def index; end

  def commands
    content = params[:file].read
    parsed_file = Parser.call(content)

    if parsed_file[:errors].nil?
      @rovers = Navigate.call(parsed_file)
    else
      @errors = parsed_file[:errors]
    end
  end

  private

  def rover_params
    params.permit(:file)
  end
end
