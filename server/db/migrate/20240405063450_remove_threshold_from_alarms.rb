class RemoveThresholdFromAlarms < ActiveRecord::Migration[7.1]
  def change
    remove_column :alarms, :threshold, :boolean
  end
end
