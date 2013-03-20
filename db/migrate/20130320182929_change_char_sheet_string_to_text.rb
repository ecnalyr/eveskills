class ChangeCharSheetStringToText < ActiveRecord::Migration
  def up
    change_column :api_keys, :char_sheet, :text
  end

  def down
    # This might cause trouble if there are strings longer
    # than 255 characters.
    change_column :api_keys, :char_sheet, :string
  end
end
