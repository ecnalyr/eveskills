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

class ApiKey < ActiveRecord::Base
  validates_presence_of :user_id, :verification_code, :eve_api_identifier

  belongs_to :user
  
  attr_accessible :id, :verification_code, :eve_api_identifier
  attr_accessible :user_id

    def character_name
      api = get_api_results
      character_name = get_character_name(api)
    end

    private
    
        def get_api_results
          api_reults = Nokogiri.XML(open("https://api.eveonline.com/char/CharacterSheet.xml.aspx?keyID=#{self.eve_api_identifier}&vCode=#{self.verification_code}").read)    
        end

        def get_character_name(api)
          api.xpath("//name").inner_text
        end


end