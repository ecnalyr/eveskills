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

    def attributes
        api = get_api_results
        attributes = get_attributes(api)
    end

    private

        def get_api_results
          api_reults = Nokogiri.XML(open("https://api.eveonline.com/char/CharacterSheet.xml.aspx?keyID=#{self.eve_api_identifier}&vCode=#{self.verification_code}"))    
        end

        def get_character_name(api)
          api.xpath("//name").inner_text
        end

        def get_attributes(api)
          # attributes = []
          api.xpath('//attributes/*').each_with_object([]) do |n, ary|
            ary << "#{n.name}: #{n.text}"
          end
        # the following line will return an object with symbols instead of a string array, but the first element is a \n character
        #   api.at('attributes').children(:nth-child(1).each_with_object({}){ |o,h| h[o.name.to_sym] = o.text }

        end


end

# class Nokogiri::XML::Document
#   def remove_empty_lines!
#     self.xpath("//text()").each { |text| text.content = text.content.gsub(/\n(\s*\n)+/,"\n") }; self
#   end
# end