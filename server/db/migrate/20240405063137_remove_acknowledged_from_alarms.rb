class RemoveAcknowledgedFromAlarms < ActiveRecord::Migration[7.1]
  def change
    remove_column :alarms, :acknowledged, :boolean
  end
end
