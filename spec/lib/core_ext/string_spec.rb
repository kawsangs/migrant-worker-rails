require "rails_helper"

RSpec.describe "String" do
  describe "#to_latin_number" do
    it "converts khmer unicode number to latin number" do
      expect("១២៣៤៥៦៧៨៩០".to_latin_number).to eq("1234567890")
    end
  end

  describe "#remove_special_character" do
    it "removes special character and unicode from string" do
      expect("+12ឆ្នាំ[,]'".remove_special_character).to eq("12")
    end
  end
end
