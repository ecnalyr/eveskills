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

describe "Products" do

  context "#character_name" do
    it "should have a character name" do
      api_key = FactoryGirl.create(:api_key, :eve_api_identifier => "1867200", :verification_code => "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4")
      # api_key.character_name.should == "Alba Tross"
      api_key.character_name.should_not be_nil
    end  
  end
  
end
