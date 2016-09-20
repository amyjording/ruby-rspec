require 'caesar'

describe "caesar cipher functions" do

  describe "#caesar_cipher" do
    context "given 'Hello', 5" do
      it "returns 'Mjqqt'" do
      expect(caesar_cipher("Hello", 5).join).to eql("Mjqqt")
    end
  end

    context "retain spaces and punctuation" do
      it "returns K'o Coa!" do
        expect(caesar_cipher("I'm Amy!", 2).join).to eql("K'o Coa!")
      end
    end
end
end
