class AddActiveToAlarms < ActiveRecord::Migration[7.1]
  def change
    add_column :alarms, :active, :boolean
  end
end
