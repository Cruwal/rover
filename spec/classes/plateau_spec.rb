require "rails_helper"

RSpec.describe Plateau, type: :class do
  subject(:plateau) { described_class }

  context "when can_move?" do
    it "should not allow move in the North direction when robotic_rover is in the top edge" do
      params = { x: 5, y: 5 }
      position = { x: 1, y: 5, direction: 'N' }

      expect(plateau.new(params).can_move?(position)).to be false
    end

    it "should not allow move in the South direction when robotic_rover is in the bottom edge" do
      params = { x: 5, y: 5 }
      position = { x: 1, y: 0, direction: 'S' }

      expect(plateau.new(params).can_move?(position)).to be false
    end

    it "should not allow move in the West direction when robotic_rover is in the West edge" do
      params = { x: 5, y: 5 }
      position = { x: 0, y: 3, direction: 'W' }

      expect(plateau.new(params).can_move?(position)).to be false
    end

    it "should not allow move in the East direction when robotic_rover is in the East edge" do
      params = { x: 5, y: 5 }
      position = { x: 5, y: 3, direction: 'E' }

      expect(plateau.new(params).can_move?(position)).to be false
    end

    it "should not allow move when next position has an obstacle" do
      params = { x: 5, y: 5 }
      position = { x: 1, y: 2, direction: 'E' }
      plateau_instance = plateau.new(params)
      plateau_instance.add_obstacle({ x: 2, y: 2 })

      expect(plateau_instance.can_move?(position)).to be false
    end
  end
end
