require "rails_helper"

RSpec.describe RoboticRover, type: :service do
  subject(:robotic_rover) { described_class }
  let(:plateau) { Plateau.new(x: 5, y: 5) }
  let(:initial_position) { { x: 5, y: 5, direction: 'N' } }
  let(:commands) { ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'] }

  it "should return the correct response" do
    expect(robotic_rover.new({ plateau: plateau, initial_position: initial_position, commands: commands }).call).to eql({ x: 3, y: 4, direction: 'E'})
  end

  context "when receive a M command" do
    it "should return the correct response when robotic_rover is in N direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'N' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 3, direction: 'N' })
    end

    it "should return the correct response when robotic_rover is in S direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'S' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 1, direction: 'S' })
    end

    it "should return the correct response when robotic_rover is in E direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'E' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 2, y: 2, direction: 'E' })
    end

    it "should return the correct response when robotic_rover is in W direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'W' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 0, y: 2, direction: 'W' })
    end
  end

  context "when receive a L command" do
    it "should return the correct response when robotic_rover is in N direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'N' }, commands: ['L'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'W' })
    end

    it "should return the correct response when robotic_rover is in W direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'W' }, commands: ['L'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'S' })
    end

    it "should return the correct response when robotic_rover is in S direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'S' }, commands: ['L'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'E' })
    end

    it "should return the correct response when robotic_rover is in E direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'E' }, commands: ['L'] }

      expect(robotic_rover.new(params).call).to eql({ x:1, y: 2, direction: 'N' })
    end
  end

  context "when receive a R command" do
    it "should return the correct response when robotic_rover is in N direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'N' }, commands: ['R'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'E' })
    end

    it "should return the correct response when robotic_rover is in E direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'E' }, commands: ['R'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'S' })
    end

    it "should return the correct response when robotic_rover is in S direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'S' }, commands: ['R'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'W' })
    end

    it "should return the correct response when robotic_rover is in W direction" do
      params = { plateau: plateau, initial_position: { x: 1, y: 2, direction: 'W' }, commands: ['R'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 2, direction: 'N' })
    end
  end

  context "when receive a M command" do
    it "should return the correct response when robotic_rover is in the top edge" do
      params = { plateau: plateau, initial_position: { x: 1, y: 5, direction: 'N' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 5, direction: 'N' })
    end

    it "should return the correct response when robotic_rover is in the bottom edge" do
      params = { plateau: plateau, initial_position: { x: 1, y: 0, direction: 'S' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 0, direction: 'S' })
    end

    it "should return the correct response when robotic_rover is in the West edge" do
      params = { plateau: plateau, initial_position: { x: 0, y: 2, direction: 'W' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 0, y: 2, direction: 'W' })
    end

    it "should return the correct response when robotic_rover is in the East edge" do
      params = { plateau: plateau, initial_position: { x: 1, y: 5, direction: 'E' }, commands: ['M'] }

      expect(robotic_rover.new(params).call).to eql({ x: 1, y: 5, direction: 'E' })
    end
  end
end
