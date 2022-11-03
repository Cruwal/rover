require "rails_helper"

RSpec.describe Navigate, type: :service do
  subject(:navigate) { described_class }
  let(:plateau) { { x: 5, y: 5 } }
  let(:rovers) do
    [
      {
        initial_position: { x: 5, y: 5, direction: 'N' },
        commands: ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'],
        errors: []
      }
    ]
  end

  it "should return the correct response" do
    expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 3, y: 4, direction: 'E'}])
  end

  context "when rovers has errors" do
    it "should return the correct response" do
      rovers = [
        {
          initial_position: { x: 5, y: 5, direction: 'N' },
          commands: ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'],
          errors: ['Invalid rover']
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([["Invalid rover"]])
    end
  end

  context "when rovers has errors" do
    it "should return the correct response" do
      plateau = { x: 5, y: 7 }
      rovers = [
        {
          initial_position: { x: 3, y: 5, direction: 'N' },
          commands: ['M', 'M', 'R', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M'],
          errors: []
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 0, y: 0, direction: 'W'}])
    end
  end

  context "when rover tries to move to a place occupied by another rover" do
    it "ignores the command and execute the next one" do
      plateau = { x: 5, y: 7 }
      rovers = [
        {
          initial_position: { x: 3, y: 5, direction: 'N' },
          commands: ['M', 'M', 'R', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M'],
          errors: []
        },
        {
          initial_position: { x: 1, y: 1, direction: 'N' },
          commands: ['L', 'M', 'L', 'M', 'L', 'M'],
          errors: []
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 0, y: 0, direction: 'W'}, { x: 1, y: 1, direction: 'E' }])
    end
  end

  context "when rover tries to move out of plateau" do
    it "ignores the command and execute the next one" do
      plateau = { x: 5, y: 7 }
      rovers = [
        {
          initial_position: { x: 3, y: 5, direction: 'N' },
          commands: ['M', 'M', 'R', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M'],
          errors: []
        },
        {
          initial_position: { x: 1, y: 1, direction: 'N' },
          commands: ['L', 'M', 'M', 'M', 'R', 'M'],
          errors: []
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 0, y: 0, direction: 'W'}, { x: 0, y: 2, direction: 'N' }])
    end
  end

  context "when some of rovers has errors" do
    it "ignores the command and execute the next one" do
      plateau = { x: 5, y: 7 }
      rovers = [
        {
          initial_position: { x: 3, y: 5, direction: 'N' },
          commands: ['M', 'M', 'R', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M'],
          errors: []
        },
        {
          initial_position: { x: 1, y: 1, direction: 'N' },
          commands: [],
          errors: ['Invalid command']
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 0, y: 0, direction: 'W'}, ['Invalid command']])
    end
  end

  context "when rover does not have commands" do
    it "shouldn't move the rover" do
      plateau = { x: 5, y: 7 }
      rovers = [
        {
          initial_position: { x: 3, y: 5, direction: 'N' },
          commands: ['M', 'M', 'R', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M', 'M', 'M', 'R', 'M', 'M', 'M', 'M', 'M'],
          errors: []
        },
        {
          initial_position: { x: 1, y: 1, direction: 'N' },
          commands: [],
          errors: []
        }
      ]

      expect(navigate.new({ plateau: plateau, rovers: rovers }).call).to eql([{ x: 0, y: 0, direction: 'W'}, { x: 1, y: 1, direction: 'N'}])
    end
  end
end
