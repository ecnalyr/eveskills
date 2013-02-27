# == Schema Information
#
# Table name: api_keys
#
#  id                :integer          not null, primary key
#  verification_code :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  eve_api_id        :string(255)
#

# require 'spec_helper'

# describe ApiKey do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
