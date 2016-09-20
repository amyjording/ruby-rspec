require 'caesar1'

describe "ceasar cipher functions" do

  describe "#caesar_cipher" do
    context "given 'Hello'" do
      it "returns 'Mjqqt'" do
      expect(caesar_cipher("Hello", 5)).to eql("Mjqqt")
    end
  end
end  
end
