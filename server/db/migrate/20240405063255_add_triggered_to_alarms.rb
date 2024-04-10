class AddTriggeredToAlarms < ActiveRecord::Migration[7.1]
  def change
    add_column :alarms, :triggered, :boolean
  end
end
