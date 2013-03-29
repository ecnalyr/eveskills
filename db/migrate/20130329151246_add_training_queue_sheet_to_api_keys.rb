class AddTrainingQueueSheetToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :training_queue, :text, :limit => 4294967296
  end
end
