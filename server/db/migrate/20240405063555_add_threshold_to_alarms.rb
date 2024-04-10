class AddThresholdToAlarms < ActiveRecord::Migration[7.1]
  def change
    add_column :alarms, :threshold, :integer
  end
end
