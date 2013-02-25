# == Schema Information
#
# Table name: api_keys
#
#  id                :integer          not null, primary key
#  verification_code :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ApiKey < ActiveRecord::Base
  validates_presence_of :user_id, :id, :verification_code

  belongs_to :user
  
  attr_accessible :id, :verification_code
end
