require "rails_helper"

RSpec.describe Parser, type: :service do
  subject(:parse) { described_class }
  let(:content) { "5 5\n5 5 N\nLMMLMMRMRMRM\n" }

  it "should return the correct response" do
    expected_response = {
      plateau: { x: 5, y: 5 },
      rovers: [
        initial_position: { x: 5, y: 5, direction: 'N' },
        commands: ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'],
        errors: []
      ]
    }

    expect(parse.new(content).call).to eql(expected_response)
  end

  context "when more than one rover is provided" do
    it "should return the correct response" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: { x: 5, y: 5, direction: 'N' }, 
            commands: ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'],
            errors: []
          },
          {
            initial_position: { x: 3, y: 3, direction: 'S'},
            commands: ['L', 'M', 'R', 'R', 'M'],
            errors: []
          }
        ]
      }

      expect(parse.new("5 5\n5 5 N\nLMMLMMRMRMRM\n3 3 S\nLMRRM").call).to eql(expected_response)
    end
  end

  context "when content isn't valid" do
    it "should return the correct error message when content isn't provided" do
      response = parse.new(nil).call
      expect(response[:errors].first).to eql("File isn't provided")
    end

    it "should return the correct error message when content is empty" do
      response = parse.new('').call
      expect(response[:errors].first).to eql("File is empty")
    end
  end

  context "when plateau isn't valid" do
    it "should return the correct error message isn't provided" do
      response = parse.new('5 5 N').call
      expect(response[:errors].first).to eql("Invalid plateau")
    end

    it "should return the correct error message when plateau's y coordinate isn't valid" do
      response = parse.new('5 5T').call
      expect(response[:errors].first).to eql("Invalid plateau")
    end

    it "should return the correct error message when plateau's x coordinate isn't valid" do
      response = parse.new('T5 5').call
      expect(response[:errors].first).to eql("Invalid plateau")
    end

    it "should return the correct error message when plateau's x coordinate is negative" do
      response = parse.new('-1 5').call
      expect(response[:errors].first).to eql("Invalid plateau")
    end

    it "should return the correct error message when plateau's x coordinate is negative" do
      response = parse.new('5 -5').call
      expect(response[:errors].first).to eql("Invalid plateau")
    end
  end

  context "when rover isn't valid" do
    it "should return the correct error message when rover isn't provided" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: [],
            errors: ["Invalid rover", "Invalid command"]
          }
        ]
      }

      expect(parse.new("5 5\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover is empty" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover has more than two coordinates" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n4 5 6 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover has less than two coordinates" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n4 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover has only direction" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\nN\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover x coordinates isn't valid" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\nx5 5 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover y coordinates isn't valid" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n5 x5 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rover direction isn't valid" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n5 5 Z\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rovers x coordinate isn't in the plateau" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n6 5 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end

    it "should return the correct error message when rovers y coordinate isn't in the plateau" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: {},
            commands: ["L", "M", "M", "L", "M", "M", "R", "M", "R", "M", "R", "M"],
            errors: ["Invalid rover"]
          }
        ]
      }

      expect(parse.new("5 5\n5 6 N\nLMMLMMRMRMRM\n").call).to eql(expected_response)
    end
  end

  context "when commands isn't valid" do
    it "should return the correct error message when commands isn't provided" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: { x: 5, y: 5, direction: 'N' },
            commands: [],
            errors: ["Invalid command"]
          }
        ]
      }

      expect(parse.new("5 5\n5 5 N\n").call).to eql(expected_response)
    end

    it "should return the correct error message when commands is an empty list" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: { x: 5, y: 5, direction: 'N' },
            commands: [],
            errors: ["Invalid command"]
          }
        ]
      }

      expect(parse.new("5 5\n5 5 N\n\n").call).to eql(expected_response)
    end

    it "should return the correct error message when commands contains invalid character" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: { x: 5, y: 5, direction: 'N' },
            commands: [],
            errors: ["Invalid command"]
          }
        ]
      }

      expect(parse.new("5 5\n5 5 N\nRLMT").call).to eql(expected_response)
    end

    it "should return the correct error message when commands contains invalid character" do
      expected_response = {
        plateau: { x: 5, y: 5 },
        rovers: [
          {
            initial_position: { x: 5, y: 5, direction: 'N' },
            commands: [],
            errors: ["Invalid command"]
          }
        ]
      }

      expect(parse.new("5 5\n5 5 N\nRLM1").call).to eql(expected_response)
    end
  end
end
