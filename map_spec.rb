require_relative "map"

describe Map do
  let(:map1){Map.new(File.read("map.4.txt"))}
  describe "#valid?(index)" do
    context "the index is off the map" do
      it "returns true" do
        expect(map1.valid?(-4)).to be false
        expect(map1.valid?(10000)).to be false
      end
    end
    context "the index is not open" do
      it "returns false" do
        expect(map1.valid?(18)).to be false
        expect(map1.valid?(0)).to be false
      end
    end
    context "the index is on the map" do
      context "the index is an open space" do
        it "returns true" do
          expect(map1.valid?(1)).to be true
        end
      end
      context "the index is a start space" do
        it "returns true" do
          expect(map1.valid?(42)).to be true
        end
      end
      context "the index is a target space" do
        it "returns true" do
          expect(map1.valid?(49)).to be true
        end
      end
    end
  end
  describe "#neighbors(index)" do
    it "returns all of the neighbors for a given index" do
      expect(map1.neighbors(1).sort).to eq([0,2,-12,14].sort)
    end
  end
  describe "#valid_neighbors(index)" do
    it "returns the valid neighbors" do
      expect(map1.valid_neighbors(1).sort).to eq([2,14].sort)
    end
  end
  describe "#to_s" do
    it "returns the map_string for the map" do
      str = <<-str
x...........
.....#......
.....#...#..
..o..#..#*..
.....#......
.....######.
............
str
      expect(map1.to_s).to eq(str)
    end
  end
  describe "#final_path(came_from_hash)" do
    context "came_from_hash is false" do
      it "returns false" do
        expect(map1.final_path(false)).to be false
      end
    end
    context "came_from_hash is not false" do
      let(:came_from_hash){{54=>41, 42=>41, 28=>41, 40=>41, 53=>40, 27=>14, 39=>40, 52=>39, 26=>39, 13=>26, 14=>13, 15=>2, 1=>14, 2=>1, 3=>2, 16=>3, 4=>3, 17=>4, 5=>4, 6=>5, 19=>20, 7=>6, 20=>21, 8=>7, 21=>22, 9=>8, 22=>23, 10=>9, 23=>24, 11=>10, 24=>11, 37=>24, 36=>23, 34=>33, 33=>32, 32=>19, 45=>46, 46=>33, 59=>58, 58=>45, 60=>59, 61=>60, 62=>61, 48=>61}}
      it "returns a map string and a path_length" do
        expect(map1.final_path(came_from_hash)).to eq ["xxxxxxxxxxxx\nxx...#xxxxxx\nx....#xx.#..\nxxx..#xx#*..\n.....#xxxx..\n.....######.\n............\n", 31]
      end
    end
  end
  describe "#manhattan_distance(index)" do
    it "returns the manhattan_distance" do
      expect(map1.manhattan_distance(0)).to eq 12
    end
  end
end
