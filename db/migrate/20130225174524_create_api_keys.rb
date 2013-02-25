class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :id
      t.string :verification_code
      t.references :user

      t.timestamps
    end
    add_index :api_keys, :user_id
  end
end
