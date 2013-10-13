require 'spec_helper'

describe Chess::Square do

  it "has a rank" do
    expect(Chess::Square.new("a1").rank).to eq(0)
    expect(Chess::Square.new("a2").rank).to eq(1)
    expect(Chess::Square.new("a3").rank).to eq(2)
    expect(Chess::Square.new("a4").rank).to eq(3)
    expect(Chess::Square.new("a5").rank).to eq(4)
    expect(Chess::Square.new("a6").rank).to eq(5)
    expect(Chess::Square.new("a7").rank).to eq(6)
    expect(Chess::Square.new("a8").rank).to eq(7)
  end

  it "has a file" do
    expect(Chess::Square.new("a1").file).to eq(0)
    expect(Chess::Square.new("b1").file).to eq(1)
    expect(Chess::Square.new("c1").file).to eq(2)
    expect(Chess::Square.new("d1").file).to eq(3)
    expect(Chess::Square.new("e1").file).to eq(4)
    expect(Chess::Square.new("f1").file).to eq(5)
    expect(Chess::Square.new("g1").file).to eq(6)
    expect(Chess::Square.new("h1").file).to eq(7)
  end
end
