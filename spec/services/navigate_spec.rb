require "rails_helper"

RSpec.describe Navigate, type: :service do
  subject(:navigate) { described_class }
  let(:plateau) do
    {
      x: 5,
      y: 5
    }
  end
  let(:rover) do
    {
      x: 5,
      y: 5,
      direction: 'N'
    }
  end
  let(:commands) { ['L', 'M', 'M', 'L', 'M', 'M', 'R', 'M', 'R', 'M', 'R', 'M'] }

  it "should return the correct response" do
    expect(navigate.new({ plateau: plateau, rover: rover, commands: commands }).call).to eql([3, 4, 'E'])
  end

  context "when receive a M command and rover is in N direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'N' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([1, 3, 'N'])
    end
  end

  context "when receive a M command and rover is in S direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'S' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([1, 1, 'S'])
    end
  end

  context "when receive a M command and rover is in E direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'E' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([2, 2, 'E'])
    end
  end

  context "when receive a M command and rover is in W direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'W' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([0, 2, 'W'])
    end
  end

  context "when receive a L command and rover is in N direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'N' }, commands: ['L'] }

      expect(navigate.new(params).call).to eql([1, 2, 'W'])
    end
  end

  context "when receive a L command and rover is in W direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'W' }, commands: ['L'] }

      expect(navigate.new(params).call).to eql([1, 2, 'S'])
    end
  end

  context "when receive a L command and rover is in S direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'S' }, commands: ['L'] }

      expect(navigate.new(params).call).to eql([1, 2, 'E'])
    end
  end

  context "when receive a L command and rover is in E direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'E' }, commands: ['L'] }

      expect(navigate.new(params).call).to eql([1, 2, 'N'])
    end
  end

  context "when receive a R command and rover is in N direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'N' }, commands: ['R'] }

      expect(navigate.new(params).call).to eql([1, 2, 'E'])
    end
  end

  context "when receive a R command and rover is in E direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'E' }, commands: ['R'] }

      expect(navigate.new(params).call).to eql([1, 2, 'S'])
    end
  end

  context "when receive a R command and rover is in S direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'S' }, commands: ['R'] }

      expect(navigate.new(params).call).to eql([1, 2, 'W'])
    end
  end

  context "when receive a R command and rover is in W direction" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 2, direction: 'W' }, commands: ['R'] }

      expect(navigate.new(params).call).to eql([1, 2, 'N'])
    end
  end

  context "when receive a M command and rover is in the top edge" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 5, direction: 'N' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([1, 5, 'N'])
    end
  end

  context "when receive a M command and rover is in the bottom edge" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 0, direction: 'S' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([1, 0, 'S'])
    end
  end

  context "when receive a M command and rover is in the West edge" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 0, y: 2, direction: 'W' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([0, 2, 'W'])
    end
  end

  context "when receive a M command and rover is in the East edge" do
    it "should return the correct response" do
      params = { plateau: plateau, rover: { x: 1, y: 5, direction: 'E' }, commands: ['M'] }

      expect(navigate.new(params).call).to eql([1, 5, 'E'])
    end
  end
end
