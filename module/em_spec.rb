require 'em'

describe "My Enumerable Methods" do
  let(:array) { [1,2,3,4] }

  describe "#my_each" do

    it "iterates over each item" do
      sum = 0
      array.my_each { |item| sum += item }
      sum.should == 10
    end
  end

  describe "#my_select" do

    context "when block returns true" do
      it "selects array of elements" do
      result = array.my_select { |num| num.even? }
      result.should == [2,4]
      end
    end
  end

  describe "#my_all?" do

    context "when all block returns true" do
      it "returns true"do
      result = array.my_all? { |num| num > 0 }
      result.should == true
      end
    end

    context "when any block returns false" do
      it "returns false" do
      result = array.my_all? { |num| num < 2 }
      result.should == false
      end
    end

    context "when all block returns false" do
      it "returns false" do
      result = array.my_all? { |num| num < 0 }
      result.should == false
      end
    end
  end

  describe "#my_any?" do

    context "when block returns any true" do
      it "returns true if any" do
      result = array.my_any? { |num| num == 1 }
      result.should == true
      end
    end

    context "when block returns any false" do
      it "returns false if any" do
      result = array.my_any? { |num| num > 9 }
      result.should == false
      end
    end
  end

  describe "#my_map" do

    it "maps each value to a new value" do
      result = array.my_map { |item| item * 2 }
      result.should == [2,4,6,8]
    end
  end

  describe "#my_inject" do
    context "with an explicit initial" do
      it "injects and operation in the array" do
        result = array.my_inject(0) { |acc, item| acc + item }
        result.should == 10
        end
      end

    context "with an implicit initial" do
      it "injects an operation in the array" do
        result = array.my_inject { |acc, item| acc + item }
        result.should == 10
      end
    end
  end
end
