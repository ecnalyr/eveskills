# == Schema Information
#
# Table name: api_keys
#
#  id                 :integer          not null, primary key
#  verification_code  :string(255)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  eve_api_identifier :string(255)
#

require 'spec_helper'

describe "Api_key" do
  # Eve api keys should have an access mask of 393224
  eve_api_identifier = 1878387
  verification_code = "N918tK4e6MH1D6R61JjPuyxsylg9o2TIrdtuAK6mwhNW3zWy1KTZH7946jY2aV1L"

  context "#character_name" do
    it "should have a character name" do
      api_key = FactoryGirl.create(:api_key, :eve_api_identifier => eve_api_identifier, :verification_code => verification_code)
      api_key.character_name.should == "Mrkt Obsrvr"
      api_key.character_name.should_not be_nil
    end  
  end
  
  context "#attributes" do
    it "should have intelligence, memory, charimsa, perception, and willpower attributes" do
      api_key = FactoryGirl.create(:api_key, :eve_api_identifier => eve_api_identifier, :verification_code => verification_code)
      api_key.attributes.should == ["intelligence: 20", "memory: 25", "charisma: 23", "perception: 16", "willpower: 15"]
    end
  end

end
