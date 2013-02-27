class AddEveApiIdentifierToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :eve_api_identifier, :string
  end
end
