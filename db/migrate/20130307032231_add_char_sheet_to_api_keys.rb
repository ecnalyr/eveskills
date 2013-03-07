class AddCharSheetToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :char_sheet, :string
  end
end
