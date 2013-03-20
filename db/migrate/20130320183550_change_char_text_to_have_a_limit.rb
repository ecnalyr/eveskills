class ChangeCharTextToHaveALimit < ActiveRecord::Migration
  def up
    change_column :api_keys, :char_sheet, :text, :limit => 4294967296
  end

  def down
    change _column :api_keys, :char_sheet, :text
  end
end
