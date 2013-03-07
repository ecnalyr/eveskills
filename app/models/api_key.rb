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
#  char_sheet         :string(255)
#

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
require 'Nokogiri'

class ApiKey < ActiveRecord::Base
  validates_presence_of :user_id, :verification_code, :eve_api_identifier

  belongs_to :user
  
  attr_accessible :id, :verification_code, :eve_api_identifier, :char_sheet
  attr_accessible :user_id

  def populate_char_sheet
    self.char_sheet = get_api_results_for("CharacterSheet")
  end

  def character_name
    api = get_api_results_for("CharacterSheet")
    character_name = get_character_name(api)
  end

  def character_attributes
    api = get_api_results_for("CharacterSheet")
    attributes = get_attributes(api)
  end

  def skill_in_training?
    api = get_api_results_for("SkillInTraining")
    is_skill_in_training(api)
  end

  def name_of_skill_in_training
    api = get_api_results_for("SkillInTraining")
    if skill_in_training?
      get_name_of_skill_in_training(api)
    end
  end

  def current_skill_training_end_time
    api = get_api_results_for("SkillInTraining")
    if skill_in_training?
      get_skill_training_end_time(api)
    end
  end

  def training_queue
    api = get_api_results_for("SkillQueue")
    skill_in_training? ? get_training_queue(api) : []
  end

  private

      def get_api_results_for(specific_api)
        api_reults = Nokogiri.XML(open("https://api.eveonline.com/char/#{specific_api}.xml.aspx?keyID=#{self.eve_api_identifier}&vCode=#{self.verification_code}"))    
      end

      def get_character_name(api)
        api.xpath("//name").inner_text
      end

      def get_attributes(api)
        result = api.at('attributes').children.each_with_object({}){ |o,h| h[o.name.to_sym] = o.text }
        # We have to delete the element :text from the results hash because
        # I have not found a more elegant way to collect the data without
        # :text element in the first place
        result.delete(:text)
        result
      end

      def is_skill_in_training(api)
        api.xpath("//skillInTraining").inner_text.to_bool
      end

      def get_name_of_skill_in_training(api)
        api.xpath("//trainingTypeID").inner_text
      end

      def get_skill_training_end_time(api)
        Time.zone.parse(api.xpath("//trainingEndTime").inner_text).utc
      end

      def get_training_queue(api)
        api.xpath("//row").map do |row|
          Hash[ row.attributes.to_a.map { |k, v| [k.to_sym, v.to_s] } ]
        end
      end
end
