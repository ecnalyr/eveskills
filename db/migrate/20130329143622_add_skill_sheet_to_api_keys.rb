class AddSkillSheetToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :skill_sheet, :text, :limit => 4294967296
  end
end
