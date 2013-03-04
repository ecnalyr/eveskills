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

describe "Api_key", :vcr do
  # Eve api keys should have an access mask of 393224
  eve_api_identifier = "1867200"
  verification_code = "oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4"

  eve_api_identifier_no_skill_in_training = "1878387"
  verification_code_no_skill_in_training = "N918tK4e6MH1D6R61JjPuyxsylg9o2TIrdtuAK6mwhNW3zWy1KTZH7946jY2aV1L"

  context "#character_name" do
    it "should have a character name" do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      api_key.character_name.should == "Alba Tross"
      api_key.character_name.should_not be_nil
    end  
  end
  
  context "#character_attributes" do
    it "should have intelligence, memory, charimsa, perception, and willpower attributes", :vcr do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      api_key.character_attributes.should == 
      {:intelligence=>"27", :memory=>"21", :charisma=>"17", :perception=>"17", :willpower=>"17"}
    end
  end

  context "#skill_in_training?" do
    it "should return 0 if there is no skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_not_training)
      api_key.skill_in_training?.should == false
    end

    it "should return 1 if there is a skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      api_key.skill_in_training?.should == true
    end
  end

  context "#name_of_skill_in_training" do
    it "should return the trainingTypeID of a skill if there is a skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      api_key.name_of_skill_in_training.should == "3320"
    end

    it "should return nil if there is no skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_not_training)
      api_key.name_of_skill_in_training.should be nil
    end      
  end

  context "#current_skill_training_end_time" do
    it "should return a training end time if there is a skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_is_training)
      api_key.current_skill_training_end_time.should == "2013-03-06 22:04:00"
    end

    it "should return nil if there is no skill in training" do
      api_key = FactoryGirl.create(:api_key, :skill_not_training)
      api_key.current_skill_training_end_time.should be nil
    end
  end

end